require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user, :admin) }

  describe 'GET /index' do
    before do
      sign_in user
      get users_path
    end

    it { expect(response).to have_http_status(:success) }
  end
end
