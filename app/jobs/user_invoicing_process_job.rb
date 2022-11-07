# Create Invoice record after parse CSV file
# When find failed row in csv file
# insert this row to new file with problem invoices
# If invoice valid create and relate this invoice to Attachment
class UserInvoicingProcessJob < SidekiqJob
  queue_as :default

  def perform(attachment_id, *args)
    invoice_code, amount, due_date = args.flatten
    attachment = Attachment.find attachment_id
    user = attachment.user

    invoice = Invoice.new(attachment:, user:, invoice_code:, amount:, due_date:)

    if invoice.invalid?
      invoice.description = invoice.errors.full_messages.join(',')
      invoice.save(validate: false)

      if save_to_scv?
        invalid_csv_line_insert(attachment,
                                invoice.errors.full_messages.join(','),
                                invoice_code, amount, due_date)
      end
    end

    invoice.save!
  end

  private

  # Insert failed invoice row to file with problem invoices
  def invalid_csv_line_insert(attachment, errors, *args)
    invoice_code, amount, due_date = args.flatten
    folder_path = Rails.root.join("public/uploads/#{attachment.class.to_s.underscore}/file_processed/#{attachment.id}")
    FileUtils.mkdir_p(folder_path)
    invoice_file_processed = Rails.root.join(folder_path, "Incorrect_#{attachment.file_identifier}")

    file_processed = CSV.open(invoice_file_processed, 'a+') do |row|
      row << [invoice_code, amount, due_date, errors]
    end
    attachment.file_processed = file_processed
    attachment.save!
  end

  def save_to_scv?
    ActiveModel::Type::Boolean.new.cast(ENV.fetch("ERROR_LOGG_TO_CSV", false))
  end
end
