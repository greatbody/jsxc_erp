require 'rails_helper'

RSpec.describe OpenController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #map" do
    it "returns http success" do
      get :map
      expect(response).to have_http_status(:success)
    end
  end

end
