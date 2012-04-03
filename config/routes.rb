Marcas::Application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  post "login" => "sessions#create", :as => "login"

  get "signup" => "users#new", :as => "signup"
  get "edit_password/:id" => "users#edit_password", :as => "edit_password"
  put "edit_password/:id" => "users#update_password", :as => "update_password"

  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"

  get "index" => "home#index", :as => "home"
  get "trademark_registration" => "home#trademark_registration", :as => "trademark_registration"

  root :to => "home#index"

  resources :users do
    member do
      get :activate
    end
  end
  resources :sessions
  resources :password_resets

  resources :trademark_orders do
    member do
      get :edit_status
      put :update_status
      get :prepare_payment
      put :pay
    end
  end
  resources :services
  resources :order_types
  resources :order_statuses
end
