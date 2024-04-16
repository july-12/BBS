Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  resources :users, only: [:index, :show] do
    collection do
      get "followers"
      get "followings"
    end
    post "follow"
    post "unfollow"
  end
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :questions do
    resources :comments, only: [:create]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
