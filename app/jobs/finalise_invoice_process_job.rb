class FinaliseInvoiceProcessJob < SidekiqJob
  include Sidekiq::Worker
  queue_as :low

  def perform(user_id, attachment_id)
    user = User.find(user_id)
    attachment = Attachment.find(attachment_id)
    raise 'Cant find user' unless user
    raise 'Cant find attachment' unless attachment

    if attachment.file_processed.present?
      Rails.logger.debug { "Has Failed Invoices :( #{attachment_id}, #{user_id}" }
      InvoiceMailer.csv_processing(attachment.user.email, attachment.id, failed: true).deliver_later(wait: 5.seconds)
    else
      InvoiceMailer.csv_processing(attachment.user.email, attachment.id).deliver_later(wait: 5.seconds)
      Rails.logger.debug { "All invoices valid and inserted correctly! #{attachment_id}, #{user_id}" }
    end

    Rails.logger.debug { "Work after finish all UserInvoicingProcessJob #{attachment_id}, #{user_id}" }
  end
end
