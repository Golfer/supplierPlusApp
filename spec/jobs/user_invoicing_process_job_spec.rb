require 'rails_helper'

RSpec.describe UserInvoicingProcessJob, type: :job do
  let(:user) { FactoryBot.create(:user) }
  let(:attachment) { FactoryBot.create(:attachment) }

  describe '#perform_later' do
    before(:all) do
      Sidekiq::Testing.fake!
    end

    it 'uploads a backup' do
      ActiveJob::Base.queue_adapter = :test

      expect do
        described_class.perform_async(user.id, attachment.id)
      end.to change(described_class.jobs, :size).by(1)
    end
  end
end
