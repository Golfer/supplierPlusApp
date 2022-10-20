require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'GET /index' do
    before do
      get invoices_path
    end

    it { expect(response).to have_http_status(:success) }
  end
end
