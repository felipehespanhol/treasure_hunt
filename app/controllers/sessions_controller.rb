class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_by(email: params[:email])

    session[:user_id] = user.id

    redirect_to new_guess_path
  end
end
