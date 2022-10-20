require 'rails_helper'

RSpec.describe 'Attachments', type: :request do
  describe 'GET /index' do
    before do
      get attachments_path
    end

    it { expect(response).to have_http_status(:success) }
  end
end
