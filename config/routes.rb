Rails.application.routes.draw do
  get 'contact_logs/index'

  get 'contact_logs/new'

  get 'contact_logs/edit'

  get 'contact_logs/show'

  unless Rails.env == 'production'
    mount RailsAdmin::Engine => '/20150612', as: 'rails_admin'
  end
  devise_for :users
  root 'welcome#index'

  namespace :welcome do
    get '/' => :index
    get '/demo' => :demo
  end

  resources :intentions

  resources :students do
    member do
      resources :contact_logs
    end
  end

end
