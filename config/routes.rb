Rails.application.routes.draw do
  get 'categories/index'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  root 'pages#home'
end
