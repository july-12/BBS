Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  get "profile", to: "users#profile"
  resources :users, except: [:create] do
    collection do
      get "followers"
      get "followings"
    end
    post "follow"
    post "unfollow"
  end
  resources :posts do
    # resources :comments, only: [:create]
    post "comments", as: :comments, to: "comments#create_of_post"
    member do
      post "favorite"
      post "unfavorite"
      post "like"
      post "unlike"
      post "subscribe"
      post "unsubscribe"
    end
  end
  resources :questions do
    post "comments", as: :comments, to: "comments#create_of_question"
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
