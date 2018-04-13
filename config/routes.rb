Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Custom Devise login/out routes
  devise_for :users, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :boards, param: :abbreviation, :only => [:index, :show], :path => '' do
    resources :root_posts, :path => 'threads'
  end
  resources :child_posts, :except => [:index] , :path => 'posts'

  get '/pages/:page' => 'pages#show'

  root to: redirect('/boards')
end
