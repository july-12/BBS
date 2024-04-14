class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]
  before_action :set_follow_target, only: [:follow, :unfollow]

  def index
    @users = User.all.order(created_at: "ASC")
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    relation = current_user.following_relations.create!(following_id: params[:user_id])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to users_url }
    end
  end

  def unfollow
    relation = current_user.following_relations.find_by(following_id: params[:user_id])
    relation.destroy!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to users_url }
    end
  end

  private

  def set_follow_target
    @user = User.find(params[:user_id])
  end
end
