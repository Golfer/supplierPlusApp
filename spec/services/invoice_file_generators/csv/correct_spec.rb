require 'rails_helper'

RSpec.describe InvoiceFileGenerators::Csv::Correct, type: :model do
  describe '#processed' do
    before(:all) do
      create(:user)
    end

    it {
      expect(described_class.new(rows: 5).processed).eql? 5
    }
  end
end
