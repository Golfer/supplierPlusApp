class UserInvoicingProcessJob < SidekiqJob
  queue_as :default

  def perform(attachment_id, *args)
    invoice_code, amount, due_date = args.flatten
    attachment = Attachment.find attachment_id
    user = attachment.user

    invoice = Invoice.new(attachment:, user:, invoice_code:, amount:, due_date:)

    if invoice.invalid?
      return invalid_csv_line_insert(attachment,
                                     invoice.errors.full_messages.join(','),
                                     invoice_code, amount, due_date
                                     )
    end

    invoice.save!
  end

  private

  def invalid_csv_line_insert(attachment, errors, *args)
    invoice_code, amount, due_date = args.flatten
    folder_path = Rails.root.join("uploads/#{attachment.class.to_s.underscore}/file_processed/#{attachment.id}")
    FileUtils.mkdir_p(folder_path)
    invoice_file_processed = Rails.root.join(folder_path, "Incorrect_#{attachment.file_identifier}")

    file_processed = CSV.open(invoice_file_processed, 'a+') do |row|
      row << [invoice_code, amount, due_date, errors]
    end
    attachment.file_processed = file_processed
    attachment.save!
  end
end
