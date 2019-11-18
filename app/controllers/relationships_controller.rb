class RelationshipsController < ApplicationController
  before_action :authenticate_user!

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
    relationship = current_user.relationships.find_by(user_id: params[:user_id])
    if relationship
      relationship.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  def relationship_params
    params.permit(:user_id).merge(fan_id: current_user.id)
  end
end
