require "rails_helper"

RSpec.describe ParserUserInvoicesJob, :type => :job do
  let(:attachment) { FactoryBot.create(:attachment) }
  let(:attachment_correct) { FactoryBot.create(:attachment, :file_correct_5000) }
  let(:attachment_incorrect) { FactoryBot.create(:attachment, :file_incorrect_5000) }

  describe "#perform_async" do
    before(:all) do
      Sidekiq::Testing.fake!
    end

    it "correct run parser ParserUserInvoicesJob with params attachment" do
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

    xit "Run parser CSV job ParserUserInvoicesJob with incorrected Invoices" do
      ActiveJob::Base.queue_adapter = :inline

      expect do
        described_class.perform_async(attachment_incorrect.id)
      end.to change(described_class.jobs, :size).by(1)
    end

    it 'raise error without params' do
      ActiveJob::Base.queue_adapter = :test

      expect do
        described_class.new.perform
      end.to raise_error(ArgumentError)


    end

    it 'raise error with wrong ID' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        described_class.new.perform('12312')
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
