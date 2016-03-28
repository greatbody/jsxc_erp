# encoding: UTF-8
require 'rails_helper'

RSpec.describe M::DashboardController, type: :controller do
  before :each do
    @user ||= FactoryGirl.create :user
    sign_in @user
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
