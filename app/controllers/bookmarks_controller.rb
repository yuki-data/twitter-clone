class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    return if Bookmark.find_by(bookmark_params)
    bookmark = Bookmark.create(bookmark_params)
    if bookmark.errors.empty?
      flash[:notice] = "ブックマークしました"
    else
      flash[:alert] = "ブックマークに失敗しました"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(post_id: params[:post_id])
    if bookmark
      bookmark.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  def bookmark_params
    params.permit(:post_id).merge(user_id: current_user.id)
  end
end
