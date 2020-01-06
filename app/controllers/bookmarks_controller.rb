class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.favposts.order(created_at: :desc)
  end

  def create
    return if Bookmark.find_by(bookmark_params)
    @bookmark = Bookmark.create(bookmark_params)
    respond_to do |format|
      format.html do
        if @bookmark.errors.empty?
          flash[:notice] = "ブックマークしました"
        else
          flash[:alert] = "ブックマークに失敗しました"
        end
        redirect_back(fallback_location: root_path)
      end
      format.js do
        if @bookmark.errors.empty?
          @post = Post.find(bookmark_params[:post_id])
          @status = "success"
        else
          @status = "fail"
        end
      end
    end
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(post_id: params[:post_id])

    respond_to do |format|
      format.html do
        unless bookmark && bookmark.destroy
          flash[:alert] = "ブックマーク削除に失敗しました"
        end
        redirect_back(fallback_location: root_path)
      end
      format.js do
        if bookmark && bookmark.destroy
          @post = Post.find(bookmark_params[:post_id])
          @status = "success"
        else
          @status = "fail"
        end
      end
    end
  end

  def bookmark_params
    params.permit(:post_id).merge(user_id: current_user.id)
  end
end
