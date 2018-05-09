Rails.application.routes.draw do
  # different roots for authenticated users
  authenticated :user do
    root to: 'pages#home', page: 'home', as: :authenticated_root
  end
  root to: redirect('/login')
  
  # custom Devise login/out routes
  devise_for :users, controllers: { registrations: "registrations" }, path: 'account', skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  
  # move rails_admin to shorter uri
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # api stuff
  scope '/api' do
    namespace :charts do
      get 'posts'
      get 'posts-by-hour'
      get 'messages'
      get 'rooms'
    end
    get :search, controller: :search
    
    get 'root-posts', to: 'root_posts#index' 
    get 'root-post/:id', to: 'root_posts#show' 
    get 'child-post/:id', to: 'child_posts#show' 
  end
  
  
  # resource routes
  resources :rooms, except: [:edit], path: 'r' do
    resource :room_users
    resources :messages
  end
  resources :boards, param: :abbreviation, only: [:index, :show], path: 'b', as: :boards do
    resources :root_posts, :path => 'threads'
  end
  resources :child_posts, except: [:index] , path: 'posts'

  # static page routes
  get '/pages/:page' => 'pages#show'
end
