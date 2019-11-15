class PostsController < ApplicationController
  before_action :set_new_post, only: [:new, :create]
  before_action :set_post, only: [:edit, :update]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post_latest = Post.create(post_params)
    respond_to do |format|
      if @post_latest.errors.empty?
        format.html { redirect_to user_path(current_user.id), notice: "メッセージを投稿しました" }
        format.js { @status = "success"}
      else
        format.html do
          flash.now[:alert] = "メッセージが入力されていません"
          render :new
        end
        format.js { @status = "fail" }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @post.update(post_params)
    if @post.errors.empty?
      redirect_to user_path(current_user.id), notice: "メッセージを更新しました"
    else
      flash.now[:alert] = "メッセージが入力されていません"
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
