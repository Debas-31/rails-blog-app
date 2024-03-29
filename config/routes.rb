Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
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

  post "/api/register", to: 'authentication#register'
  post '/api/login', to: 'authentication#login'
  get '/api/users/:user_id/posts', to: 'posts#posts'
  get '/api/posts/:id/comments', to: 'comments#comments'
  post '/api/posts/:id/comments', to: 'comments#add_comment'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new , :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end

  # Defines the root path route ("/")
  root "users#index"
end
