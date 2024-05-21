class Admin::UsersController < AdminController
  before_action :set_user, only: [:silence, :unsilence]

  def index
    @users = User.unscoped.order(created_at: "ASC")
  end

  def silence
    @user.silence!
  end

  def unsilence
    @user.update!(status: nil)
    render :silence
  end

  private

  def set_user
    @user = User.unscoped.find(params[:id])
  end
end
