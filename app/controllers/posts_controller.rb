class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :like, :unlike, :favorite, :unfavorite, :subscribe, :unsubscribe]
  before_action :set_post, only: %i[ show edit update destroy like unlike favorite unfavorite subscribe unsubscribe ]
  before_action :check_author, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @viewed_count = Ahoy::Event.post_viewed_count(@post.id)
    ahoy.track "ViewedPost", { id: @post.id, title: @post.title }
  end

  def new
    @categories = Category.all
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def favorite
    if current_user.favorites.create(operatable_id: params[:id], operatable_type: "Post")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_url, notice: "favorite post!" }
        format.json { head :no_content }
      end
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def unfavorite
    favorite = current_user.favorites.find_by(operatable_id: params[:id], operatable_type: "Post")
    favorite.destroy if favorite
    respond_to do |format|
      format.turbo_stream { render :favorite }
      format.html { redirect_to posts_url, notice: "unfavorite post!" }
      format.json { head :no_content }
    end
  end

  def like
    if current_user.likes.create(operatable_id: params[:id], operatable_type: "Post")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_url, notice: "like post!" }
        format.json { head :no_content }
      end
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def unlike
    liked = current_user.likes.find_by(operatable_id: params[:id], operatable_type: "Post")
    liked.destroy if liked
    respond_to do |format|
      format.turbo_stream { render :like }
      format.html { redirect_to posts_url, notice: "unlike post!" }
      format.json { head :no_content }
    end
  end

  def subscribe
    if current_user.subscribes.create(operatable_id: params[:id], operatable_type: "Post")
      # PostMailer.with(user: @post.author).subscribe.deliver_now
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_url, notice: "subscribe post!" }
        format.json { head :no_content }
      end
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def unsubscribe
    subscribed = current_user.subscribes.find_by(operatable_id: params[:id], operatable_type: "Post")
    subscribed.destroy if subscribed
    respond_to do |format|
      format.turbo_stream { render :subscribe }
      format.html { redirect_to posts_url, notice: "unsubscribe post!" }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.unscoped.preload(:comments).find(params[:id])
    if @post.block? && !(current_user && (current_user.admin? || current_user?(@post.author)))
      redirect_to root_path
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :context, :rawhtml, :category_id)
  end

  def check_author
    unless current_user.admin? || current_user?(@post.author)
      redirect_to root_path
    end
  end
end
