class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index, :comment, :favorite]

  def index
    @posts = current_user.posts.order(updated_at: :desc)
  end

  def comment
    @comments = current_user.comments.order(updated_at: :desc)
  end

  def favorite
    @posts = current_user.favorite_posts.order("post_actions.created_at DESC")
  end
end
