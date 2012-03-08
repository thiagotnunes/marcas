Marcas::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  root :to => "users#index"

  resources :users do
    member do
      get :activate
    end
  end
  resources :sessions
end
