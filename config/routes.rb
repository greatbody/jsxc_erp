Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  namespace :welcome do
    get '/' => :index
    get '/demo' => :demo
  end
end
