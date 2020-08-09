Rails.application.routes.draw do
  get    '/about',   to: 'pages#about'
  root   'pages#home'

  devise_for :users, :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup",   :to => "users/registrations#new"
    get "login",    :to => "users/sessions#new"
    get 'logout',   :to => "devise/sessions#destroy"
    get '/users/sign_out' => 'devise/sessions#destroy'
    # get "/users/sign_out",   :to => "users/sessions#destroy"
    #get 'logout' => 'devise/sessions#destroy'
  end
end
