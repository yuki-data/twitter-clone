class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    bookmark = Bookmark.create(post_id: params[:post_id], user_id: current_user.id)
    if bookmark.errors.empty?
      flash[:notice] = "ブックマークしました"
    else
      flash[:alert] = "ブックマークに失敗しました"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.bookmarks.find_by(post_id: params[:post_id]).destroy
    redirect_back(fallback_location: root_path)
  end
end
