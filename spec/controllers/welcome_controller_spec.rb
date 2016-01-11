# encoding: UTF-8
require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  let(:user) { User.create(phone: '18771024287', name: 'sr') }

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

end
