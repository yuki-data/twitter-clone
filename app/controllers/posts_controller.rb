class PostsController < ApplicationController
  before_action :set_new_post, only: [:new, :create]
  before_action :set_post, only: [:edit, :update]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def new
  end

  def create
    post = Post.create(post_params)
    if post.errors.empty?
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    if @post.errors.empty?
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    Post.destroy(params[:id])
    redirect_back(fallback_location: root_path)
  end

  private

  def set_new_post
    @post = Post.new
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image).merge(user_id: current_user.id)
  end
end
