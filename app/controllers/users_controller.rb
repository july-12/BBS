class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :follow, :unfollow]
  before_action :set_follow_target, only: [:follow, :unfollow]

  def index
    @users = User.all.order(created_at: "ASC")
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.turbo_stream
        format.html { redirect_to :profile, notice: "user was successfully updated." }
        format.json { render :profile, status: :ok, location: current_user }
      else
        format.html { render :profile, status: :unprocessable_entity }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
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
      format.turbo_stream { render turbo_stream: turbo_stream.replace("follow_#{params[:user_id]}", partial: "users/follow_status", locals: { user_id: params[:user_id] }) }
      format.html { redirect_to users_url }
    end
  end

  private

  def set_follow_target
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:name, :phone, :email, :avatar)
  end
end
