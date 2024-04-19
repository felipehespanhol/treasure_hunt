module Api
  class WinnersController < ApiController
    # GET /api/winners
    def index
      page_no = params[:page]&.to_i || 1
      per_page = 10
      order = params[:order] == 'desc' ? :desc : :asc

      @winners = User.select('users.id, users.email, MIN(guesses.distance) AS best_distance')
                     .joins(:guesses)
                     .where(guesses: { is_successful: true })
                     .group('users.id, users.email')
                     .offset((page_no - 1) * per_page)
                     .limit(per_page)
                     .order(best_distance: order, 'users.id': order)
    end
  end
end
