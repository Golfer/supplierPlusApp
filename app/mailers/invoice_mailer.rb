class InvoiceMailer < ApplicationMailer
  def csv_processing(email, attachment, failed: false)
    @user = User.find_by(email:)
    @attachment = Attachment.find(attachment)
    @failed = failed
    mail(
      to: email,
      subject: failed ? I18n.t('.mailer.csv_failed_processing') : I18n.t('.mailer.csv_success_processing')
    )
  end
end
