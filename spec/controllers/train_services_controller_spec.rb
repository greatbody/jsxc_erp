require 'rails_helper'

RSpec.describe TrainServicesController, type: :controller do
  before :each do
    @user ||= FactoryGirl.create :user
    @coach ||= FactoryGirl.create :coach
    sign_in @user
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index, coach_id: @coach.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, coach_id: @coach.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      @train_service ||= FactoryGirl.create :train_service
      @train_service.coach = @coach
      get :edit, coach_id: @coach.id, id: @train_service.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      @train_service ||= FactoryGirl.create :train_service
      @train_service.coach = @coach
      get :show, coach_id: @coach.id, id: @train_service.id
      expect(response).to have_http_status(:success)
    end
  end

end
