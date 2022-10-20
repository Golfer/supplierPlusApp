# Send Email notice for usesr after finish precessed Attachment file
class FinaliseInvoiceProcessJob < SidekiqJob
  include Sidekiq::Worker
  queue_as :low

  def perform(user_id, attachment_id)
    user = User.find(user_id)
    attachment = Attachment.find(attachment_id)
    attachment.update(finish_processing: true)
    raise 'Cant find user' unless user
    raise 'Cant find attachment' unless attachment

    if attachment.file_processed.present?
      Rails.logger.info { "Failed parser Invoices :( #{attachment_id}, #{user_id}" }
      InvoiceMailer.csv_processing(attachment.user.email, attachment.id, failed: true).deliver_later(wait: 5.seconds)
    else
      InvoiceMailer.csv_processing(attachment.user.email, attachment.id).deliver_later(wait: 5.seconds)
      Rails.logger.info { "All invoices valid and inserted correctly! #{attachment_id}, #{user_id}" }
    end

    Rails.logger.info { "Work after finish all UserInvoicingProcessJob #{attachment_id}, #{user_id}" }
  end
end
