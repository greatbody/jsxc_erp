require 'rails_helper'

RSpec.describe StudentSourcesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/student_sources').to route_to('student_sources#index')
    end

    it 'routes to #new' do
      expect(get: '/student_sources/new').to route_to('student_sources#new')
    end

    it 'routes to #show' do
      expect(get: '/student_sources/1').to route_to('student_sources#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/student_sources/1/edit').to route_to('student_sources#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/student_sources').to route_to('student_sources#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/student_sources/1').to route_to('student_sources#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/student_sources/1').to route_to('student_sources#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/student_sources/1').to route_to('student_sources#destroy', id: '1')
    end

    # extended routes

    it 'routes to #new_source_contact via GET' do
      expect(get: '/student_sources/new_source_contact').to route_to('student_sources#new_source_contact')
    end

    it 'routes to #new_source_contact via POST' do
      expect(post: '/student_sources/new_source_contact').to route_to('student_sources#new_source_contact')
    end

  end
end
