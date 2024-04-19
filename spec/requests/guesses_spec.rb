require 'rails_helper'

RSpec.describe 'Guesses', type: :request do
  describe 'GET /new' do
    subject do
      get '/guesses/new'
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        subject

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when user is authenticated' do
      before do
        post '/sessions', params: { email: 'test_user@email.com' }

        follow_redirect!
      end

      it 'renders the page for the current match' do
        match = create(:match)

        allow(Match).to receive(:find_current_or_create_next).and_return(match)

        subject

        expect(response.body).to include(match.id.to_s)
      end
    end
  end

  describe 'POST /create' do
    subject { post '/guesses', params: { guess: guess_params } }

    let(:guess_params) { { coord_x: 1, coord_y: 2, match_id: 1 } }

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        subject

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when user is authenticated' do
      let(:match) { create(:match) }
      let(:guess_params) { { coord_x: 1, coord_y: 2, match_id: match.id } }

      before do
        post '/sessions', params: { email: 'test_user@email.com' }

        follow_redirect!
      end

      subject do
        post '/guesses', params: { guess: guess_params }
      end

      context 'and the match is already finished' do
        before { match.update(winner: create(:user)) }

        it 'redirects to the match page' do
          subject

          expect(response).to redirect_to(match_path(match))
        end
      end

      context 'and the guess is successful' do
        before do
          guess_params[:coord_x] = match.treasure_x
          guess_params[:coord_y] = match.treasure_y
        end

        it 'redirects to the match page' do
          subject

          expect(response).to redirect_to(match_path(match))
        end

        it 'sends an email to the user' do
          mail_double = double
          allow(mail_double).to receive(:deliver_later)

          user_mailer_double = double(you_won: mail_double)
          allow(UserMailer).to receive(:with).with(guess: an_instance_of(Guess)).and_return(user_mailer_double)

          allow(mail_double).to receive(:deliver_later)

          subject

          expect(UserMailer).to have_received(:with).with(guess: Guess.last)
          expect(mail_double).to have_received(:deliver_later)
        end
      end

      context 'and the guess is not successful' do
        before do
          guess_params[:coord_x] = match.treasure_x + 1 # wrong answer
        end

        it 'redirects to the new guess page' do
          subject

          expect(response).to redirect_to(new_guess_path)
        end
      end

      context 'and the guess is invalid' do
        let(:guess_params) { { coord_x: nil, match_id: match.id } }

        it 'renders the new guess page' do
          subject

          expect(response).to have_http_status(:unprocessable_entity)

          expect(response.body).to include('Invalid request. Please send both coordinates.')
        end
      end
    end
  end
end
