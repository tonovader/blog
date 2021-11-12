class PostsController < ApplicationController
  before_action :set_post, only: %i[show]
  before_action :set_user_post, only: %i[edit update destroy create]

  # GET /posts or /posts.json
  def index
    @posts = current_user.followed_posts
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    respond_to do |format|
      if can? :update, @post
        format.html { redirect_to @post, notice:"Post was succesfully edited" }
        format.json { head :no_content }
      else
        format.html { redirect_to posts_path, notice: "You dont have enough permissions" }
        format.json { head :no_content }
      end
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if can?(:create, @post) && @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if can? :update, @post
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if can? :delete, @post
      @post.destroy
      
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to posts_url, alert: 'You don\t have enough permissions.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_user_post
    @post = current_user.posts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.fetch(:post, {})
  end
end