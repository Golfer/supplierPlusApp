require 'rails_helper'

RSpec.describe InvoiceFileGenerators::Csv::Incorrect, type: :model do

  describe '#processed' do
    before(:all) do
      FactoryBot.create(:user)
    end

    it {
      expect(described_class.new(rows: 500).processed).eql? 500
    }
  end
end