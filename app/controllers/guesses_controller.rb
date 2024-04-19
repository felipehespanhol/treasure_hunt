class GuessesController < ApplicationController
  before_action :authenticate_user!

  # GET /guesses/new
  def new
    @match = Match.find_current_or_create_next

    @last_guess = current_user.guesses.where(match: @match).last

    @guess = @match.guesses.build(coord_x: @last_guess&.coord_x, coord_y: @last_guess&.coord_y)
  end

  # POST /guesses
  def create
    MakeGuess.new(self).call(current_user, guess_params)
  end

  # See MakeGuess
  def match_has_already_finished(match)
    flash[:alert] = 'Match already finished'

    redirect_to match_path(match)
  end

  # See MakeGuess
  def invalid_request(guess)
    flash[:alert] = 'Invalid request. Please send both coordinates.'

    @guess = guess
    @match = guess.match
    @last_guess = current_user.guesses.where(match: guess.match).last

    render :new, status: :unprocessable_entity
  end

  # See MakeGuess
  def successful_guess(guess)
    guess.match.update(winner: guess.user)

    UserMailer.with(guess:).you_won.deliver_later

    flash[:notice] = 'Congratulations! You found the treasure!'

    redirect_to match_path(guess.match)
  end

  # See MakeGuess
  def unsuccessful_guess
    flash[:info] = 'Try again!'

    redirect_to new_guess_path
  end

  private

  def guess_params
    params.require(:guess).permit(:coord_x, :coord_y, :match_id)
  end
end
