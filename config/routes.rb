Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/20150612', as: 'rails_admin'

  devise_for :users
  root 'welcome#index'

  namespace :welcome do
    get '/' => :index
    get '/demo' => :demo
  end

  resources :intentions
end
