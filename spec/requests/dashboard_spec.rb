require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  describe 'GET /index' do
    before do
      get dashboard_index_path
    end

    it { expect(response).to have_http_status(:success) }
  end
end
