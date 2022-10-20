require 'carrierwave/test/matchers'

describe AttachmentInvoicesUploader do
  include CarrierWave::Test::Matchers

  let(:attachment) { create(:attachment) }
  let(:uploader) { described_class.new(attachment, :file) }
  let(:path_to_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/csv_example.csv')) }

  before do
    described_class.enable_processing = true
    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  it { expect(uploader.file.identifier).not_to be_empty }
end
