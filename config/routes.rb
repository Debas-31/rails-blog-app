Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
=begin
    get '/users/:user_id/posts', to: 'posts#index'
    get '/users/:user_id/posts/:id', to: 'posts#show'
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'

    Equivalent to the one below

    resources :users, only: [:index, :show] do
      resources :posts, only: [:index, :show]
    end
=end
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new , :create]
      resources :likes, only: [:new, :create]
    end
  end

  # Defines the root path route ("/")
  root "users#index"
end
