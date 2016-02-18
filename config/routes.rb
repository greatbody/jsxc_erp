# encoding: UTF-8
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/20150612', as: 'rails_admin'

  devise_for :users

  root 'welcome#index'

  namespace :welcome do
    get '/' => :index
    get '/demo' => :demo
    get '/map' => :map
  end

  namespace :open do
    get '/' => :index
    get '/map' => :map
  end

  namespace :contact_logs do
    get 'new_contact_log' => :new_contact_log
    post 'new_contact_log' => :new_contact_log
  end

  namespace :service do
    post 'assign_task' => :assign_task
    get 'search' => :search
    post 'daily_sign' => :daily_sign
  end

  resources :intentions do
    collection do
      post 'get_intention_list' => :get_intention_list
    end
  end

  resources :students do
    resources :residence_cards
    resources :contact_logs
    collection do
      post 'get_student_status' => :get_student_status
      post 'update_id_card' => :update_id_card
      get 'upload_id_card_form' => :upload_id_card_form
      post 'notify_got_number' => :notify_got_number
      post 'notify_got_card' => :notify_got_card
      get 'signed_up' => :signed_up
      get 'wait_pay' => :wait_pay
    end
  end

  resources :student_sources do
    # resources :source_contracts
    resources :source_contacts
    collection do
      get 'list' => :list
      get 'new_source_contact' => :new_source_contact
      post 'new_source_contact' => :new_source_contact
    end
  end

  resources :coaches, only: [:index, :new, :show, :edit, :update, :create] do
    resources :train_services, only: [:index, :new, :show, :edit, :update, :create]
    collection do
      get 'train_services' => :train_services
      post 'train_services' => :train_services
    end
  end

  namespace :api do
    post 'notify' => :notify
  end

end
