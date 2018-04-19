Rails.application.routes.draw do
  # different roots for authenticated users
  authenticated :user do
    root to: 'boards#index', as: :authenticated_root
  end
  root to: redirect('/login')

  # custom Devise login/out routes
  devise_for :users, controllers: { registrations: "registrations" }, path:'account', skip: [:sessions]
  as :user do
    get '/account/preferences', to: 'registrations#preferences'
    get '/account/details', to: 'registrations#details'
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  # move rails_admin to shorter uri
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # resource routes
  resources :boards, param: :abbreviation, :only => [:index, :show], :path => '' do
    resources :root_posts, :except => [:index], :path => 'threads'
  end
  resources :child_posts, :except => [:index] , :path => 'posts'

  # static page routes
  get '/pages/:page' => 'pages#show'
end
