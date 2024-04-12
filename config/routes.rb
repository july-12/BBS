Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  resources :users, only: [:show]
  resources :posts do
    resources :comments, only: [:create]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
