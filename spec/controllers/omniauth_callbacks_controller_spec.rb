require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  describe "GET #stripe_connect" do
    it "returns http success" do
      get :stripe_connect
      expect(response).to have_http_status(:success)
    end
  end

end
