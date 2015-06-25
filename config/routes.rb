SteamCardTracker::Application.routes.draw do

  admin_auth_routes

  namespace :admin do
    resources :games, only: [:index, :create, :destroy]
  end

  namespace :api do
    resources :games, only: [:index, :show]
  end

  get '/sitemap(.xml)' => 'home#sitemap', format: 'xml'

  root 'home#index'
end
