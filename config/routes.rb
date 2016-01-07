Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }
  root 'pages#home'
  get "categories/:id" => "categories#index", as: "categories"
  post "line_items/:product_id" => "line_items#create", as: "buy_items"
  resources :products, :line_items, :orders
  resource :cart, only: [:show, :destroy]
  resources :carts, only: :create
  get "search" => "products#search", as: "search"
end
