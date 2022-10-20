require "rails_helper"

RSpec.describe FinaliseInvoiceProcessJob, :type => :job do
  let(:attachment) { FactoryBot.create(:attachment) }

  describe "#perform_later" do
    before(:all) do
      Sidekiq::Testing.fake!
    end
    it "uploads a backup" do
      ActiveJob::Base.queue_adapter = :test

      expect do
        described_class.perform_async(attachment.id)
      end.to change(described_class.jobs, :size).by(1)
    end
  end
end
