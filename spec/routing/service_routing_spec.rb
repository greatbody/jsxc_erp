require 'rails_helper'

RSpec.describe ServiceController, type: :routing do
  describe 'routing' do

    # extent routes

    it 'routes to service#assign_task' do
      expect(post: '/service/assign_task').to route_to(
        controller: 'service',
        action: 'assign_task'
      )
    end

    it 'routes to service#search' do
      expect(get: '/service/search').to route_to(
        controller: 'service',
        action: 'search'
      )
    end

    it 'routes to service#daily_sign' do
      expect(post: '/service/daily_sign').to route_to(
        controller: 'service',
        action: 'daily_sign'
      )
    end

  end
end
