# encoding: UTF-8
Rails.application.routes.draw do

  get 'residence_cards/new'

  get 'residence_cards/show'

  mount RailsAdmin::Engine => '/20150612', as: 'rails_admin'

  devise_for :users

  root 'welcome#index'

  namespace :welcome do
    get '/' => :index
    get '/demo' => :demo
  end

  resources :contact_logs

  resources :intentions do
    collection do
      post 'get_intention_list' => :get_intention_list
    end
  end

  resources :students do
    resources :residence_cards
    collection do
      post 'get_student_status' => :get_student_status
    end
  end

  resources :coaches, only: [:show]

end
