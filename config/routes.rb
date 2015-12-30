Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }
  root 'pages#home'
  get "categories/:id" => "categories#index", as: "categories"
  resources :products#, :carts, :cart_items, :orders
end
