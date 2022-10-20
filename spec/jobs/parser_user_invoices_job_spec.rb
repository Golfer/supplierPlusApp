require 'rails_helper'

RSpec.describe ParserUserInvoicesJob, type: :job do
  let(:attachment) { create(:attachment) }
  let(:attachment_correct) { create(:attachment, :file_correct_50) }
  let(:attachment_incorrect) { create(:attachment, :file_incorrect_50) }

  describe '#perform_async' do
    it 'correct run parser ParserUserInvoicesJob with params attachment' do
      Sidekiq::Testing.fake!
      ActiveJob::Base.queue_adapter = :test

      expect do
        described_class.perform_async(attachment.id)
      end.to change(described_class.jobs, :size).by(1)
    end

    it "Run parser CSV job ParserUserInvoicesJob with correct Invoices" do
      ActiveJob::Base.queue_adapter = :inline

      expect do
        described_class.perform_async(attachment_correct.id)
      end.to change(described_class.jobs, :size).by(1)
    end

    it 'raise error without params' do
      Sidekiq::Testing.inline!
      ActiveJob::Base.queue_adapter = :test

      expect do
        described_class.new.perform
      end.to raise_error(ArgumentError)
    end

    it 'raise error with wrong ID' do
      Sidekiq::Testing.inline!
      ActiveJob::Base.queue_adapter = :test
      expect do
        described_class.new.perform('12312')
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
