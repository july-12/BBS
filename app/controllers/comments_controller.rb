class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create_of_post
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.commenter = current_user
    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to post_url(@post), notice: "comment was successfully created." }
      else
        format.html { redirect_to post_url(@post), status: :unprocessable_entity }
      end
    end
  end

  def create_of_question
    @question = Question.find(params[:question_id])
    @comment = @question.comments.create(comment_params)
    @comment.commenter = current_user
    @comment.save
    # respond_to do |format|
    #   if @comment.save
    #     format.turbo_stream
    #     format.html { redirect_to question_url(@question), notice: "comment was successfully created." }
    #   else
    #     format.html { redirect_to question_url(@question), status: :unprocessable_entity }
    #   end
    # end
  end

  def update
  end

  def like
    @comment = Comment.find(params[:id])
    if current_user.likes.create(operatable_id: params[:id], operatable_type: "Comment")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_url(@comment.post), notice: "like comment!" }
        format.json { head :no_content }
      end
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def unlike
    @comment = Comment.find(params[:id])
    liked = current_user.likes.find_by(operatable_id: params[:id], operatable_type: "Comment")
    liked.destroy if liked
    respond_to do |format|
      format.turbo_stream { render :like }
      format.html { redirect_to post_url(@comment.post), notice: "unlike comment!" }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :reply_id, :sub_reply_id)
  end
end
