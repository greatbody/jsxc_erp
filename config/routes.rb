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

  resources :intentions
end
