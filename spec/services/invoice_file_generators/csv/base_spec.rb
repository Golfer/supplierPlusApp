require 'rails_helper'

RSpec.describe InvoiceFileGenerators::Csv::Base, type: :model do
  describe '#processed' do
    before(:all) do
      create(:user)
    end

    it {
      expect(described_class.new(rows: 3).processed).eql? 3
    }
  end
end
