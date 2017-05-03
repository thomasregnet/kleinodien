Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :import do
      resources :brainz_releases, only: [:create]
    end
    namespace :v01 do
      jsonapi_resources :album_heads
      jsonapi_resources :artist_credits
      jsonapi_resources :artist_identifiers      
      jsonapi_resources :artists
      jsonapi_resources :ch_identifiers
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
