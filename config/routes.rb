Rails.application.routes.draw do
  devise_for :users
  resources :child_posts, :path => 'posts'
  resources :root_posts, :path => 'threads'
  
  root to: redirect('/threads')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
