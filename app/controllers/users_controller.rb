class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:setting, :edit_password, :update_password, :setting, :follow, :unfollow]
  before_action :set_follow_target, only: [:follow, :unfollow]
  before_action :set_user, only: [:show, :dashboard, :favorites, :comments, :followers, :followings, :update_password]

  def index
    @users = User.all.order(created_at: "ASC")
  end

  def show
    @posts = @user.posts.order(updated_at: :desc)
  end

  def setting
  end

  def edit_password
  end

  def advance
  end

  def dashboard
    @posts = current_user.posts.order(updated_at: :desc)
  end

  def comments
    @comments = current_user.comments.order(updated_at: :desc)
  end

  def favorites
    @posts = current_user.favorite_posts.order("post_actions.created_at DESC")
    @key = "favorite"
    render :dashboard
  end

  def followers
    @users = @user.followers
  end

  def followings
    @users = @user.followings
    @key = "followings"
    render :followers
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

  def update_password
    password_params = update_password_params
    if @user.valid_password?(password_params[:old_password])
      @user.update(password: password_params[:new_password])
      sign_in(@user, bypass: true)
    else
      @user.errors.add(:password, message: "old password invalid")
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
      # format.turbo_stream { render turbo_stream: turbo_stream.replace("follow_#{params[:user_id]}", partial: "users/follow_status", locals: { user_id: params[:user_id] }) }
      format.turbo_stream { render :follow }
      format.html { redirect_to users_url }
    end
  end

  private

  def set_follow_target
    @user = User.find(params[:user_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:name, :phone, :email, :avatar)
  end

  def update_password_params
    params.require(:user).permit(:old_password, :new_password, :new_password_confirmation)
  end
end
