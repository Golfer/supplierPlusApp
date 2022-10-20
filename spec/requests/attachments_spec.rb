require 'rails_helper'

RSpec.describe 'Attachments', type: :request do
  let(:user) { create(:user) }
  let(:attachment) { create(:attachment) }

  describe 'GET /index' do
    before do
      sign_in user
      get attachments_path
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    before do
      sign_in user
      get attachments_path
    end

    it {
      post attachments_path, params: {
        attachment: {
          file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/csv_example.csv')),
          user_id: user.id
        }
      }
      expect(response).to redirect_to(attachments_path)
    }

    describe 'POST /create' do
      before do
        sign_in user
        get attachments_path
      end

      it {
        post attachments_path, params: {
          attachment: {
            user_id: user.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      }

      it {
        expect(ParserUserInvoicesJob).to receive(:perform_async)
        post attachments_path, params: {
          attachment: {
            file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/csv_example.csv')),
            user_id: user.id
          }
        }
      }
    end
  end

  describe 'PATCH /update' do
    before do
      sign_in user
      get attachments_path
    end

    it {
      expect(ParserUserInvoicesJob).to receive(:perform_async)
      patch attachment_path(attachment), params: {
        attachment: {
          file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/correct_1.csv')),
          user_id: user.id
        }
      }

      expect(response).to have_http_status(:found)
    }
  end
end
