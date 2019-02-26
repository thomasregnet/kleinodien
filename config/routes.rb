Rails.application.routes.draw do
  get 'heaps/index'
  get 'heaps/show'
  # get 'import_orders/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'import_requests/new'

  # get 'import_requests/create'

  devise_for :users

  resources :compilation_copies, only: [:create, :edit, :index, :new, :show]

  resources :album_heads, only: [:index, :show]

  resources :album_releases, only: [:index, :show]

  resources :uri_import_orders, only: [:create, :new]

  resources :movie_heads, only: [:index, :show]

  resources :original_exemplars

  resources :repositories

  resources :import_requests, only: [:create, :new]

  get 'pages/index'

  root to: 'pages#index'
  namespace :api do
    namespace :import do
      resources :brainz_releases, only: [:create]
    end
    namespace :v01 do
      resources :brainz_releases, only: [:create]
      jsonapi_resources :artist_credits
      jsonapi_resources :artists
      jsonapi_resources :compilation_heads
      jsonapi_resources :episode_heads
      jsonapi_resources :movie_heads
      jsonapi_resources :participants
      jsonapi_resources :piece_heads
      jsonapi_resources :song_heads
      jsonapi_resources :sources
    end
  end
end
