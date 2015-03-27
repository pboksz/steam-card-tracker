SteamCardTracker::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :api do
    resources :games, only: [:index, :show]
  end

  resources :games, only: [:index, :create]

  get '/sitemap(.xml)' => 'home#sitemap', format: 'xml'

  root 'home#index'
end
