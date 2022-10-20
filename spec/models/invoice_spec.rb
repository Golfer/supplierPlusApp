require 'rails_helper'

RSpec.describe Invoice, type: :model do
  subject(:invoice) { build(:invoice) }

  let(:inccorect_due_date) { build(:invoice, :incorrect_date) }
  let(:inccorect_amount) { build(:invoice, :incorrect_amount) }

  describe 'included fields' do
    it { is_expected.to respond_to(:invoice_code) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:due_date) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(invoice).to be_valid
    end

    it 'is not valid without a due_date' do
      invoice.due_date = nil
      expect(invoice).not_to be_valid
    end

    it 'due_date correct format [YYYY-MM-DD]' do
      expect(inccorect_due_date).not_to be_valid
    end

    it 'amount incorrect' do
      expect(inccorect_amount).not_to be_valid
    end
  end

  describe 'Relations' do
    it { is_expected.to belong_to(:user) }
  end
end
