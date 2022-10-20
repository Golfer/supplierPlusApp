require_relative '../rails_helper'

describe InvoiceMailer, type: :mailer do
  describe '#csv_processing' do
    subject(:csv_processing) { InvoiceMailer.csv_processing(user.email, attachment.id) }

    let(:user) { FactoryBot.create(:user) }
    let(:attachment) { FactoryBot.create(:attachment) }


    context 'renders the body' do
      xit { expect(csv_processing.body.raw_source.html_safe).to match("Dear #{user.email}!") }
      xit { expect(csv_processing.body.raw_source.html_safe).to match("Result processing CSV file finished ok.") }
    end

    it { expect { csv_processing.deliver }.to change { ActionMailer::Base.deliveries.count }.by(1) }
  end
end
