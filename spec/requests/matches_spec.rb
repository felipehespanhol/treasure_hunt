require 'rails_helper'

RSpec.describe 'Matches', type: :request do
  let(:match) { create(:match) }

  describe 'GET /show' do
    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        get "/matches/#{match.id}"

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when user is authenticated' do
      before do
        post '/sessions', params: { email: 'test_user@email.com' }
      end

      it 'returns http success' do
        get "/matches/#{match.id}"

        expect(response).to have_http_status(:success)
      end
    end
  end
end
