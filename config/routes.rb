Rails.application.routes.draw do
  root 'welcome#index'

  namespace :welcome do
    get '/' => :index
    get '/demo' => :demo
  end
end
