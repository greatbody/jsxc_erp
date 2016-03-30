require 'rails_helper'

RSpec.describe WorkTasksController, type: :controller do
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
      @work_task ||= FactoryGirl.create :work_task
      get :show, id: @work_task.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      @work_task ||= FactoryGirl.create :work_task
      get :edit, id: @work_task.id
      expect(response).to have_http_status(:success)
    end
  end

end
