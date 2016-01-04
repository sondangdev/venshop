Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }
  root 'pages#home'
  get "categories/:id" => "categories#index", as: "categories"
  resources :products, :line_items#, :orders
  resource :cart, only: [:show, :destroy]
  resources :carts, only: :create
end
