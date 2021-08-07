Rails.application.routes.draw do
  devise_for :users, :controllers => { registration: 'registration' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root "users#profile"
  post "/registration", to: "users#registration"
  get "/profile", to: "users#profile"
  get "/confirm_gender", to: "users#confirm_gender"
  get "/update_gender", to: "users#update_gender"
end
