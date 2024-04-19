class MakeGuess
  def initialize(listener)
    @listener = listener
  end

  def call(user, guess_params)
    match = Match.find(guess_params[:match_id])

    return @listener.match_has_already_finished(match) if match.winner.present?

    guess = Guess.new_with_coordenates(guess_params.merge(user:))

    return @listener.invalid_request(guess) unless guess.save

    return @listener.successful_guess(guess) if guess.is_successful?

    @listener.unsuccessful_guess
  end
end
