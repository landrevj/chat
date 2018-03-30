Rails.application.routes.draw do

  # Custom Devise login/out routes
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end
  devise_for :users, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :child_posts, :path => 'posts'
  resources :root_posts, :path => 'threads'

  root to: redirect('/threads')
end
