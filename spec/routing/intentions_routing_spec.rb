require 'rails_helper'

RSpec.describe IntentionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/intentions').to route_to('intentions#index')
    end

    it 'routes to #new' do
      expect(get: '/intentions/new').to route_to('intentions#new')
    end

    it 'routes to #show' do
      expect(get: '/intentions/1').to route_to('intentions#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/intentions/1/edit').to route_to('intentions#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/intentions').to route_to('intentions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/intentions/1').to route_to('intentions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/intentions/1').to route_to('intentions#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/intentions/1').to route_to('intentions#destroy', id: '1')
    end

    # extended routes

    it 'routes to #get_intention_list' do
      expect(post: '/intentions/get_intention_list').to route_to('intentions#get_intention_list')
    end

  end
end
