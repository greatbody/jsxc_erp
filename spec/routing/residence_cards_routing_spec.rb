require 'rails_helper'

RSpec.describe ResidenceCardsController, type: :routing do
  describe 'routing' do

    it 'routes to /students/:student_id/residence_cards#index' do
      expect(get: '/students/1/residence_cards').to route_to(
        controller: 'residence_cards',
        action: 'index',
        student_id: '1'
      )
    end

    it 'routes to /students/:student_id/residence_cards#new' do
      expect(get: '/students/1/residence_cards/new').to route_to(
        controller: 'residence_cards',
        action: 'new',
        student_id: '1'
      )
    end

    it 'routes to /students/:student_id/residence_cards#create' do
      expect(post: '/students/1/residence_cards').to route_to(
        controller: 'residence_cards',
        action: 'create',
        student_id: '1'
      )
    end

    it 'routes to /students/:student_id/residence_cards#show' do
      expect(get: '/students/1/residence_cards/1').to route_to(
        controller: 'residence_cards',
        action: 'show',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/residence_cards#edit' do
      expect(get: '/students/1/residence_cards/1/edit').to route_to(
        controller: 'residence_cards',
        action: 'edit',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/residence_cards#update via PUT' do
      expect(put: '/students/1/residence_cards/1').to route_to(
        controller: 'residence_cards',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/residence_cards#update via PUT' do
      expect(patch: '/students/1/residence_cards/1').to route_to(
        controller: 'residence_cards',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to /students/:student_id/residence_cards#destroy' do
      expect(delete: '/students/1/residence_cards/1').to route_to(
        controller: 'residence_cards',
        action: 'destroy',
        student_id: '1',
        id: '1'
      )
    end

  end
end
