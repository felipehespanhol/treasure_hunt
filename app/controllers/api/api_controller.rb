class Api::ApiController < ApplicationController
  # This is a base class for all API controllers. It provides some common
  # functionality that all API controllers will need.

  before_action :authenticate!

  private

  def authenticate!
    return if request.headers['HTTP_API_KEY'] == Rails.application.credentials.api_key

    head :unauthorized
  end
end
