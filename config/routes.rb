Rails.application.routes.draw do
  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    sessions: "admins/sessions"
  }

  get "users" => "users#index", as: "users"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }

  root 'pages#home'
  get "categories/:id" => "categories#index", as: "categories"
  post "line_items/:product_id" => "line_items#create", as: "buy_items"
  resources :products
  get "all_orders" => "orders#index_all", as: "all_orders"
  resources :orders
  resources :line_items, except: :create
  resource :cart, only: [:show, :destroy]
  resources :carts, only: :create
  get "search" => "products#search", as: "search"
end
