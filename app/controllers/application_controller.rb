class ApplicationController < ActionController::Base
  add_flash_types :info

  helper_method :current_user

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    redirect_to new_session_path unless current_user
  end
end
