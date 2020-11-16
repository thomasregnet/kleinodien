# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  resources :release_images
  resources :release_copies
  resources :original_releases, controller: 'release_copies', type: 'OriginalRelease'
  resources :releases
  resources :import_orders
  # get 'heaps/index'
  # get 'heaps/show'

  # get 'import_orders/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'import_requests/new'

  # get 'import_requests/create'

  devise_for :users

  resources :uri_import_orders, only: %i[create new]

  # https://stackoverflow.com/questions/5246767/sti-one-controller
  resources :releases, only: %i[index show]
  resources(
    :albums,
    controller: 'releases',
    type:       'Album',
    only:       %i[index show]
  )
  resources(
    :singles,
    controller: 'releases',
    type:       'Single',
    only:       %i[index show]
  )

  resources :movie_heads, only: %i[index show]

  get 'pages/index'

  root to: 'pages#index'
end
# rubocop:enable Metrics/BlockLength
