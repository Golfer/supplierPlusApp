require 'rails_helper'

RSpec.describe Attachment, type: :model do
  subject(:attachment) { FactoryBot.create(:attachment) }

  describe 'included fields' do
    it { is_expected.to respond_to(:file) }
    it { is_expected.to respond_to(:description) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(attachment).to be_valid
    end
  end

  describe 'Relations' do
    it { is_expected.to belong_to(:user) }
  end
end
