class Admin::PostsController < AdminController
  before_action :set_post, only: [:block, :unblock]

  def index
    @posts = Post.unscoped.order(created_at: "DESC")
  end

  def block
    @post.block!
  end

  def unblock
    @post.update!(status: nil)
    render :block
  end

  private

  def set_post
    @post = Post.unscoped.find(params[:id])
  end
end
