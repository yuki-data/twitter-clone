class PostsController < ApplicationController
  before_action :set_new_post, only: [:new, :create]

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

  private

  def set_new_post
    @post = Post.new
  end

  def post_params
    params.require(:post).permit(:content, :image).merge(user_id: current_user.id)
  end
end
