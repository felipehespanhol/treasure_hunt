require 'rails_helper'

RSpec.describe 'Api::Winners', type: :request do
  describe 'GET /api/winners' do
    let!(:best_guesses) do
      1.upto(20).map do
        user = create(:user)

        best_guess = create(:guess, user:, is_successful: true, distance: Random.rand(1..10))
        create(:guess, user:, is_successful: true, distance: Random.rand(11..20))
        create(:guess, user:, is_successful: false, distance: Random.rand(1001..10_000))

        { id: user.id, email: user.email, best_distance: best_guess.distance }
      end.sort_by { |o| o[:best_distance] }
    end

    it 'returns a list of users with their best guesses' do
      get '/api/winners'

      expect(response.body).to eq({ winners: best_guesses.first(10) }.to_json)
    end

    it 'paginates the results' do
      get '/api/winners', params: { page: 2 }

      expect(response.body).to eq({ winners: best_guesses[10..19] }.to_json)
    end

    it 'orders the results' do
      get '/api/winners', params: { order: 'desc' }

      expect(response.body).to eq({ winners: best_guesses.reverse.first(10) }.to_json)
    end
  end
end
