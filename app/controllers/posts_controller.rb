class PostsController < ApplicationController
  before_action :set_new_post, only: [:new, :create]
  before_action :set_post, only: [:edit, :update]

  def index
    timeline = Post.timeline(current_user)
    @posts = if timeline
               timeline.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
             else
               Kaminari.paginate_array([]).page(1)
             end
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
        format.js do
          @status = "fail"
          @error_message = @post_latest.errors.full_messages.join("\n")
        end
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

    respond_to do |format|
      if @post.errors.empty?
        format.html {redirect_to user_path(current_user.id), notice: "メッセージを更新しました"}
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

  def destroy
    @post_destroyed = Post.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js do
        if @post_destroyed.destroyed?
          @status = "success"
        else
          @status = "fail"
        end
      end
    end
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
