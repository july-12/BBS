class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy, :favorite, :unfavorite]
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
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
    @post_id = params[:id]
    favorited = current_user.favorites.find_by(post_id: @post_id)
    unless favorited
      current_user.favorites.create(post_id: @post_id)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_url, notice: "favorite post!" }
      format.json { head :no_content }
    end
  end

  def unfavorite
    favorited = current_user.favorites.find_by(post_id: params[:id])
    if favorited
      favorited.destroy
    end
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite", partial: "posts/favorite", locals: { post_id: params[:id] }) }
      format.html { redirect_to posts_url, notice: "unfavorite post!" }
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
