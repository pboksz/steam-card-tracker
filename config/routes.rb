SteamCardTracker::Application.routes.draw do

  admin_auth_routes

  namespace :admin do
    resources :games, only: [:index, :create, :show]
  end

  namespace :api do
    resources :games, only: [:index] do
      get 'parse', on: :member
    end
  end

  get '/sitemap(.xml)' => 'home#sitemap', format: 'xml'

  root 'home#index'
end
