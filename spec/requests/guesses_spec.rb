require 'rails_helper'

RSpec.describe "Guesses", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/guesses/new"
      expect(response).to have_http_status(:success)
    end
  end

end
