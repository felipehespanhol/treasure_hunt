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
    @match = Match.find(guess_params[:match_id])

    if @match.winner.present?
      flash[:alert] = 'Match already finished'

      redirect_to match_path(@match)

      return
    end

    @guess = Guess.new_with_coordenates(guess_params.merge(user: current_user))

    unless @guess.save
      flash[:alert] = 'Invalid request. Please send both coordinates.'

      @last_guess = current_user.guesses.where(match: @match).last

      render :new, status: :unprocessable_entity

      return
    end

    if @guess.is_successful?
      @match.update(winner: @guess.user)

      UserMailer.with(guess: @guess).you_won.deliver_later

      flash[:notice] = 'Congratulations! You found the treasure!'

      redirect_to match_path(@guess.match)

      return
    end

    flash[:info] = 'Try again!'

    redirect_to new_guess_path
  end

  private

  def guess_params
    params.require(:guess).permit(:coord_x, :coord_y, :match_id)
  end
end
