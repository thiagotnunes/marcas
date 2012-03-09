Marcas::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  post "login" => "sessions#create", :as => "login"
  get "signup" => "users#new", :as => "signup"

  get "index" => "home#index", :as => "home"

  root :to => "home#index"

  resources :users do
    member do
      get :activate
    end
  end
  resources :sessions
  resources :password_resets
end
