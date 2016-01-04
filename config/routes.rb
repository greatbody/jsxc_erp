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

  namespace :service do
    post 'assign_task' => :assign_task
    get 'search' => :search
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
      post 'update_id_card' => :update_id_card
      get 'upload_id_card_form' => :upload_id_card_form
      post 'notify_got_number' => :notify_got_number
      post 'notify_got_card' => :notify_got_card
    end
  end

  resources :coaches, only: [:show]

end
