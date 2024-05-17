class Admin::DashboardController < AdminController
  def index
    @user_total = User.unscoped.count
    @post_total = Post.unscoped.count
    @comment_total = Comment.unscoped.count
  end
end
