class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.create(comment_params)
    comment.commenter = current_user
    if comment.save
      redirect_to post_url(@post), notice: "comment was successfully created."
    else
      redirect_to post_url(@post), status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
