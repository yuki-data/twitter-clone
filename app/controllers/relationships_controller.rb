class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:followers, :followings]

  def followers
  end

  def followings
  end

  def create
    return if Relationship.find_by(relationship_params)
    relationship = Relationship.create(relationship_params)
    if relationship.errors.empty?
      flash[:notice] = "フォローしました"
    else
      flash[:alert] = "フォローに失敗しました"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    relationship = current_user.reverse_relationships.find_by(user_id: params[:user_id])

    if relationship && relationship.destroy
      flash[:notice] = "フォローを外しました"
    else
      flash[:alert] = "フォローを外せませんでした。"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def relationship_params
    params.permit(:user_id).merge(fan_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
