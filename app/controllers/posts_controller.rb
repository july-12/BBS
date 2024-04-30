class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy, :favorite, :unfavorite]
  before_action :set_post, only: %i[ show edit update destroy like unlike favorite unfavorite subscribe unsubscribe ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    ahoy.track "ViewedPost", { id: @post.id, title: @post.title }
    @viewed_count = Ahoy::Event.post_viewed_count(@post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
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

  # PATCH/PUT /posts/1 or /posts/1.json
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

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def favorite
    # @post = Post.find(params[:id])
    favorited = current_user.favorite_post_ids.include?(params[:id].to_i)
    # favorited = @post.favorites.exists?(user_id: current_user.id)
    unless favorited
      current_user.favorites.create(user_id: current_user.id, operatable_id: params[:id], operatable_type: "Post")
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_url, notice: "favorite post!" }
      format.json { head :no_content }
    end
  end

  def unfavorite
    favorite = current_user.favorites.find_by(operatable_type: "Post", operatable_id: params[:id])
    if favorite
      favorite.destroy
    end
    respond_to do |format|
      format.turbo_stream { render :favorite }
      format.html { redirect_to posts_url, notice: "unfavorite post!" }
      format.json { head :no_content }
    end
  end

  def like
    liked = current_user.likes.find_by(post_id: @post.id)
    unless liked
      current_user.likes.create(post_id: @post.id)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_url, notice: "like post!" }
      format.json { head :no_content }
    end
  end

  def unlike
    liked = current_user.likes.find_by(post_id: params[:id])
    if liked
      liked.destroy
    end
    respond_to do |format|
      format.turbo_stream { render :like }
      format.html { redirect_to posts_url, notice: "unlike post!" }
      format.json { head :no_content }
    end
  end

  def subscribe
    @post_id = params[:id]
    subscribed = current_user.subscribes.find_by(post_id: @post_id)
    unless subscribed
      current_user.subscribes.create(post_id: @post_id)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_url, notice: "subscribe post!" }
      format.json { head :no_content }
    end
  end

  def unsubscribe
    subscribed = current_user.subscribes.find_by(post_id: params[:id])
    if subscribed
      subscribed.destroy
    end
    respond_to do |format|
      format.turbo_stream { render :subscribe }
      format.html { redirect_to posts_url, notice: "unsubscribe post!" }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.preload(:comments).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :context)
  end
end
