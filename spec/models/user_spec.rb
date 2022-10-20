require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  describe 'included fields' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:password) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a Email' do
      user.email = nil
      expect(user).not_to be_valid
    end
  end

  describe 'Relations' do
    it { is_expected.to have_many(:attachments) }
  end
end
