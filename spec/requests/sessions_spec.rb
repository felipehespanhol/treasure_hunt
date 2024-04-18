require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/sessions/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /' do
    let(:email) { 'test_user@email.com' }

    subject do
      post '/sessions', params: { email: email }
    end

    it 'creates a new user' do
      expect { subject }.to change { User.count }.by(1)

      expect(User.last.email).to eq(email)
    end

    it 'signs in the user' do
      subject

      expect(session).to have_key(:user_id)
    end

    it 'redirects to /guesses/new' do
      subject

      expect(response).to redirect_to('/guesses/new')
    end
  end

  describe 'DELETE /' do
    let!(:user) { create(:user) }

    before do
      post '/sessions', params: { email: user.email }
    end

    subject do
      delete '/sessions'
    end

    it 'signs out the user' do
      subject

      expect(session).not_to have_key(:user_id)
    end

    it 'redirects to /sessions/new' do
      subject

      expect(response).to redirect_to('/sessions/new')
    end
  end
end
