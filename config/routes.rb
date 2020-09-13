Rails.application.routes.draw do

  root   'pages#home'
  get    '/about',   to: 'pages#about'
  get    '/mypage',  to: 'users#mypage'
  get "users/show" => "users#show"
  # get '/users/:id', to: 'users#show', as: :users_show


  devise_for :users, :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "user/:id",   :to => "users/registrations#detail"
    get "signup",     :to => "users/registrations#new"
    get "login",      :to => "users/sessions#new"
    get "logout",     :to => "devise/sessions#destroy"
    get "/users/sign_out" => 'devise/sessions#destroy'
    # get "user/edit",  :to => "users/registrations#edit"
    get '/users/password', to: 'devise/passwords#new'
  end

  resources :topics
  resources :users, :only => [:index, :show]
  resources :relationships,       only: [:create, :destroy]
  resources :posts, :only => [:index, :show, :new, :create, :show] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
end
