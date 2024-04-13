class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]

  def index
    @users = User.all.order(created_at: "ASC")
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    relation = current_user.following_relations.create!(following_id: params[:user_id])
  end

  def unfollow
    relation = current_user.following_relations.find_by(following_id: params[:user_id])
    relation.destroy!
  end
end
