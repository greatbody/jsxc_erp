Rails.application.routes.draw do
  unless Rails.env == 'production'
    mount RailsAdmin::Engine => '/20150612', as: 'rails_admin'
  end

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

  resources :students

end
