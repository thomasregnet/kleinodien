Rails.application.routes.draw do
  namespace :api do
    namespace :v01 do
      get 'music_brainz_releases/create'
    end
  end

  namespace :api do
    namespace :v01 do
      get 'music_brainz_release/create'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :compilation_copies, only: [:create, :edit, :index, :new, :show]

  resources :album_heads, only: [:index, :show]

  resources :album_releases, only: [:index, :show]

  resources :movie_heads, only: [:index, :show]

  resources :original_exemplars

  resources :repositories

  get 'pages/index'

  root to: 'pages#index'
  namespace :api do
    namespace :import do
      resources :brainz_releases, only: [:create]
    end
    namespace :v01 do
      jsonapi_resources :album_heads
      jsonapi_resources :artist_credits
      jsonapi_resources :artist_identifiers
      jsonapi_resources :artists
      jsonapi_resources :compilation_head_identifiers
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
