class UserInvoicingProcessJob < SidekiqJob
  queue_as :default

  def perform(attachment_id, *args)
    code, amount, due_date = args.flatten
    attachment = Attachment.find attachment_id

    invoice = Invoice.new(attachment:, user: attachment.user, invoice_code: code, amount:, due_date:)
    folder_path = Rails.root.join("uploads/#{attachment.class.to_s.underscore}/file_processed/#{attachment.id}")
    FileUtils.mkdir_p(folder_path)
    invoice_file_processed = Rails.root.join(folder_path, "Incorrect_#{attachment.file_identifier}")

    if invoice.invalid?
      file_processed = CSV.open(invoice_file_processed, 'a+') do |row|
        row << [code, amount, due_date, invoice.errors.full_messages.join(',')]
      end
      attachment.file_processed = file_processed
      attachment.save!
    else
      invoice.save!
    end
  end
end
