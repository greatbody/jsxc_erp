require 'rails_helper'

RSpec.describe SourceContactsController, type: :routing do
  describe 'routing' do

    it 'routes to /student_sources/:student_sources_id/source_contacts#index' do
      expect(get: '/student_sources/1/source_contacts').to route_to(
        controller: 'source_contacts',
        action: 'index',
        student_source_id: '1'
      )
    end

    it 'routes to /student_sources/:student_sources_id/source_contacts#new' do
      expect(get: '/student_sources/1/source_contacts/new').to route_to(
        controller: 'source_contacts',
        action: 'new',
        student_source_id: '1'
      )
    end

    it 'routes to /student_sources/:student_sources_id/source_contacts#show' do
      expect(get: '/student_sources/1/source_contacts/1').to route_to(
        controller: 'source_contacts',
        action: 'show',
        student_source_id: '1',
        id: '1'
      )
    end

    it 'routes to /student_sources/:student_sources_id/source_contacts#edit' do
      expect(get: '/student_sources/1/source_contacts/1/edit').to route_to(
        controller: 'source_contacts',
        action: 'edit',
        student_source_id: '1',
        id: '1'
      )
    end

    it 'routes to /student_sources/:student_sources_id/source_contacts#create' do
      expect(post: '/student_sources/1/source_contacts').to route_to(
        controller: 'source_contacts',
        action: 'create',
        student_source_id: '1'
      )
    end

    it 'routes to /student_sources/:student_sources_id/source_contacts#update via PUT' do
      expect(put: '/student_sources/1/source_contacts/1').to route_to(
        controller: 'source_contacts',
        action: 'update',
        student_source_id: '1',
        id: '1'
      )
    end

    it 'routes to /student_sources/:student_sources_id/source_contacts#update via PATCH' do
      expect(patch: '/student_sources/1/source_contacts/1').to route_to(
        controller: 'source_contacts',
        action: 'update',
        student_source_id: '1',
        id: '1'
      )
    end

    it 'routes to /student_sources/:student_sources_id/source_contacts#update via PUT' do
      expect(delete: '/student_sources/1/source_contacts/1').to route_to(
        controller: 'source_contacts',
        action: 'destroy',
        student_source_id: '1',
        id: '1'
      )
    end

  end
end
