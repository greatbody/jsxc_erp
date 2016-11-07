require 'rails_helper'

RSpec.describe PayUnitsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #fee_list" do
    it "returns http success" do
      get :fee_list
      expect(response).to have_http_status(:success)
    end
  end

end
