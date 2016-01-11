require 'rails_helper'

RSpec.describe StudentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(:get => '/students').to route_to('students#index')
    end

    it 'routes to #new' do
      expect(:get => '/students/new').to route_to('students#new')
    end

    it 'routes to #show' do
      expect(:get => '/students/1').to route_to('students#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(:get => '/students/1/edit').to route_to('students#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/students').to route_to('students#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/students/1').to route_to('students#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/students/1').to route_to('students#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/students/1').to route_to('students#destroy', :id => '1')
    end

    # extended routes

    it 'routes to #get_student_status' do
      expect(:post => '/students/get_student_status').to route_to('students#get_student_status')
    end

    it 'routes to #update_id_card' do
      expect(:post => '/students/update_id_card').to route_to('students#update_id_card')
    end

    it 'routes to #upload_id_card_form' do
      expect(:get => '/students/upload_id_card_form').to route_to('students#upload_id_card_form')
    end

    it 'routes to #notify_got_number' do
      expect(:post => '/students/notify_got_number').to route_to('students#notify_got_number')
    end

    it 'routes to #notify_got_card' do
      expect(:post => '/students/notify_got_card').to route_to('students#notify_got_card')
    end

    it 'routes to #signed_up' do
      expect(:get => '/students/signed_up').to route_to('students#signed_up')
    end

    it 'routes to #wait_pay' do
      expect(:get => '/students/wait_pay').to route_to('students#wait_pay')
    end

  end
end
