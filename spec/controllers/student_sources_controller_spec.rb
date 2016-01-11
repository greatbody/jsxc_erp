require 'rails_helper'

let(:user) { FactoryGirl.create(:user) }

RSpec.describe StudentSourcesController, type: :controller do
  before { sign_in(user) }
  before { controller.stub(:current_user).and_return user }
  describe "GET #index" do
    it "returns http success" do
      let(@superadmin) { FactoryGirl.create(:superadmin) }
      before do
        sign_in @superadmin
      end
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
