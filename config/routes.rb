Rails.application.routes.draw do
  root "home#index"
  get "wiki", to: "home#wiki"
  get "sites", to: "home#sites"
  devise_for :users

  get "search", to: "home#search"

  get "setting", to: "users#setting"
  get "edit_password", to: "users#edit_password"
  get "advance", to: "users#advance"

  post "upload", to: "photo#create"
  resources :users, except: [:create] do
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

  resources :comments, only: [] do
    member do
      post "like"
      delete "unlike"
    end
  end

  scope "/topic" do
    get ":slug", to: "categories#slug", as: :category_slug
  end

  get ":slug", to: "users#slug", as: :slug
  get ":slug/comments", to: "users#comments", as: :slug_comments
  get ":slug/favorites", to: "users#favorites", as: :slug_favorites
  get ":slug/followers", to: "users#followers", as: :slug_followers
  get ":slug/followings", to: "users#followings", as: :slug_followings

  namespace :admin do
    resources :posts do
      member do
        put "block"
        put "unblock"
        # put "remove"
      end
    end
    resources :users
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
