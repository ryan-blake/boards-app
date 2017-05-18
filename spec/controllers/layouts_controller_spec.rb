require 'rails_helper'

RSpec.describe LayoutsController, type: :controller do

  describe "GET #msg" do
    it "returns http success" do
      get :msg
      expect(response).to have_http_status(:success)
    end
  end

end
