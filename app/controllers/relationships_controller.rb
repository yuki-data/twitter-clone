class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :destroy, :followers, :followings]
  before_action :redirect_if_user_nil, only: [:create, :destroy]

  def followers
  end

  def followings
  end

  def create
    relationship = current_user.follow(@user)

    respond_to do |format|
      format.html do
        if relationship.errors.empty?
          flash[:notice] = "フォローしました"
        else
          flash[:alert] = "フォローに失敗しました"
        end
        redirect_back(fallback_location: root_path)
      end
      format.js do
        if relationship.errors.empty?
          @status = "success"
        else
          @status = "fail"
        end
      end
    end
  end

  def destroy
    relationship = current_user.unfollow(@user)

    if relationship
      flash[:notice] = "フォローを外しました"
    else
      flash[:alert] = "フォローを外せませんでした。"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def redirect_if_user_nil
    redirect_back(fallback_location: root_path) and return unless @user
  end
end
