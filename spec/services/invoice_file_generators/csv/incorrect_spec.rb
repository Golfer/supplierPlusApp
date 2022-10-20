require 'rails_helper'

RSpec.describe InvoiceFileGenerators::Csv::Incorrect, type: :model do
  describe '#processed' do
    it {
      expect(described_class.new(rows: 500).processed).eql? 500
    }
  end
end
