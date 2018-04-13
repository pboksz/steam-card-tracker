SteamCardTracker::Application.routes.draw do

  admin_auth_routes

  namespace :admin do
    resources :games, only: [:index, :create, :show, :destroy] do
      resources :items, only: [:destroy]
    end
  end

  namespace :api do
    resources :games, only: [:index, :show]
  end

  get '/sitemap(.xml)' => 'home#sitemap', format: 'xml'

  root 'home#index'
end
