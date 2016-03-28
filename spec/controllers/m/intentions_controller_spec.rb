# encoding: UTF-8
require 'rails_helper'

RSpec.describe M::IntentionsController, type: :controller do
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

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, :id => @user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, :id => @user.id
      expect(response).to have_http_status(:success)
    end
  end

end
