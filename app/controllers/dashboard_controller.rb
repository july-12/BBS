class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index, :comment, :favorite]

  def index
    @posts = current_user.posts.order(updated_at: :desc)
  end

  def comment
  end

  def favorite
  end
end
