require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  let(:user) { create(:user) }
  describe 'GET /index' do
    before do
      sign_in user
      get invoices_path
    end

    it { expect(response).to have_http_status(:success) }
  end
end
