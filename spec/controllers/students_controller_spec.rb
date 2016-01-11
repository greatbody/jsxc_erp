# encoding: UTF-8
require 'rails_helper'

RSpec.describe StudentsController, type: :controller do

  let(:user) { User.create(phone: '18771024287', name: 'sr', admin: '1') }

  before :each do
    sign_in user
    user.add_role :superadmin
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'GET #new' do
  #   it 'returns http success' do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #show' do
  #   it 'returns http success' do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #edit' do
  #   it 'returns http success' do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
