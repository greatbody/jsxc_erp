require 'rails_helper'

RSpec.describe ContactLogsController, type: :routing do
  describe 'routing' do

    it 'routes to /students/:student_id/contact_logs#index' do
      expect(get: '/students/1/contact_logs').to route_to(
        controller: 'contact_logs',
        action: 'index',
        student_id: '1'
      )
    end

    it 'routes to /students/:student_id/contact_logs#new' do
      expect(get: '/students/1/contact_logs/new').to route_to(
        controller: 'contact_logs',
        action: 'new',
        student_id: '1'
      )
    end

    it 'routes to /students/:student_id/contact_logs#create' do
      expect(post: '/students/1/contact_logs').to route_to(
        controller: 'contact_logs',
        action: 'create',
        student_id: '1'
      )
    end

    it 'routes to /students/:student_id/contact_logs#show' do
      expect(get: '/students/1/contact_logs/1').to route_to(
        controller: 'contact_logs',
        action: 'show',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/contact_logs#edit' do
      expect(get: '/students/1/contact_logs/1/edit').to route_to(
        controller: 'contact_logs',
        action: 'edit',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/contact_logs#update via PUT' do
      expect(put: '/students/1/contact_logs/1').to route_to(
        controller: 'contact_logs',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/contact_logs#update via PUT' do
      expect(patch: '/students/1/contact_logs/1').to route_to(
        controller: 'contact_logs',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/contact_logs#destroy' do
      expect(delete: '/students/1/contact_logs/1').to route_to(
        controller: 'contact_logs',
        action: 'destroy',
        student_id: '1',
        id: '1'
      )
    end

    # extent routes

    it 'routes to contact_logs#new_contact_log via GET' do
      expect(get: '/contact_logs/new_contact_log').to route_to(
        controller: 'contact_logs',
        action: 'new_contact_log'
      )
    end

    it 'routes to contact_logs#new_contact_log via POST' do
      expect(post: '/contact_logs/new_contact_log').to route_to(
        controller: 'contact_logs',
        action: 'new_contact_log'
      )
    end

  end
end
