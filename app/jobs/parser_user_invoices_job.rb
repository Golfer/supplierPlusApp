# Parse CSV file from User
class ParserUserInvoicesJob < SidekiqJob
  include Sidekiq::Worker
  queue_as :height

  def perform(attachment_id)
    attachment = Attachment.find(attachment_id)

    csv_data = CSV.parse(attachment.file.read, headers: true)
    csv_data.each do |invoice|
      UserInvoicingProcessJob.perform_async(attachment_id, invoice.to_h.values)
    end

    FinaliseInvoiceProcessJob.perform_async(attachment.user.id, attachment_id)
  end
end
