require 'rails_helper'

RSpec.describe "Homes", type: :request do

  describe "GET /contact" do
    it "returns http success" do
      get "/home/contact"
      expect(response).to have_http_status(:success)
    end
  end

end
