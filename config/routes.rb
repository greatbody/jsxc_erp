# encoding: UTF-8
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/20150612', as: 'rails_admin'

  devise_for :users

  root 'welcome#index'

  namespace :welcome do
    get '/' => :index
    get '/demo' => :demo
    get '/map' => :map
    get '/temp' => :temp
    get '/unsigned' => :unsigned
  end

  namespace :open do
    get '/' => :index
    get '/map' => :map
    get '/rank' => :rank
    # temp
    get '/students' => :students
    get '/coaches' => :coaches
    get '/student_sources' => :student_sources
    # for exe
    get '/lakldnfhw' => :lakldnfhw
    get '/mxl82wepoasdm' => :mxl82wepoasdm
    get '/ekz1k4xja1ve5y4r' => :ekz1k4xja1ve5y4r
  end

  namespace :contact_logs do
    get 'new_contact_log' => :new_contact_log
    post 'new_contact_log' => :new_contact_log
  end

  namespace :service do
    post 'assign_task' => :assign_task
    get 'search' => :search
    post 'daily_sign' => :daily_sign
    post 'sms_consultant' => :sms_consultant
  end

  resources :intentions do
    collection do
      post 'get_intention_list' => :get_intention_list
    end
  end

  resources :fees, only: [:index]

  resources :students do
    resources :residence_cards
    resources :contact_logs
    resources :fees do
      resources :payments do
        post 'update_post' => :update_post
      end
      collection do
        get 'new_exams' => :new_exams
      end
    end
    member do
      post 'update_km1' => :update_km1
      post 'fee_list' => :fee_list
    end
    collection do
      post 'get_student_status' => :get_student_status
      post 'update_id_card' => :update_id_card
      get 'upload_id_card_form' => :upload_id_card_form
      post 'notify_got_number' => :notify_got_number
      post 'notify_got_card' => :notify_got_card
      get 'signed_up' => :signed_up
      get 'wait_pay' => :wait_pay
      get 'need_contact' => :need_contact
      post 'update_evaluation' => :update_evaluation
      post 'peek_before_evaluation' => :peek_before_evaluation
    end
  end

  resources :fees do
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

  resources :work_tasks do
    collection do
      post 'process_task' => :process_task
    end
  end

  namespace :api do
    post 'notify' => :notify
  end

  namespace :m do
    root 'dashboard#index'
    namespace :dashboard do
      get '/' => :index
      post '/logout' => :logout
    end
    resources :intentions
    resources :students do
      resources :contact_logs
      member do
        get 'set_to_me' => :set_to_me
      end
      collection do
        post 'query' => :query
      end
    end
  end

end
