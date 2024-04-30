Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  get "setting", to: "users#setting"
  get "edit_password", to: "users#edit_password"
  get "advance", to: "users#advance"

  post "upload", to: "photo#create"
  resources :users, except: [:create] do
    get "profile", action: "show"
    get "dashboard"
    get "comments"
    get "favorites"
    get "followers"
    get "followings"

    patch "update_password"
    post "follow"
    post "unfollow"
  end
  resources :posts do
    # resources :comments, only: [:create]
    post "comments", as: :comments, to: "comments#create_of_post"
    member do
      post "favorite"
      delete "unfavorite"
      post "like"
      delete "unlike"
      post "subscribe"
      delete "unsubscribe"
    end
  end
  resources :questions do
    post "comments", as: :comments, to: "comments#create_of_question"
  end

  get ":slug", to: "users#slug"
  get "up" => "rails/health#show", as: :rails_health_check
end
