class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create_of_post, :create_of_question, :update]

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

  private

  def comment_params
    params.require(:comment).permit(:content, :reply_id, :sub_reply_id)
  end
end
