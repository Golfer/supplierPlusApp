require 'rails_helper'

RSpec.describe UserInvoicingProcessJob, type: :job do
  let(:attachment) { create(:attachment) }
  let(:attachment_correct) { create(:attachment, :file_correct_5000) }
  let(:value_csv) { %w[c02150fb-8d35-4b9e-9a83-e4b2ef5a2c68 1694 2022-11-12] }

  describe '#perform_async' do
    before(:all) do
      Sidekiq::Testing.fake!
    end

    it 'Correct run UserInvoicingProcessJob' do
      ActiveJob::Base.queue_adapter = :test

      expect do
        described_class.perform_async(attachment.id, value_csv)
      end.to change(described_class.jobs, :size).by(1)
    end
  end
end
