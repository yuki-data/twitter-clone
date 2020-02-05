class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile, only: [:edit, :update]
  def edit
  end

  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html {redirect_to user_path(current_user), notice: "プロフィールを更新しました"}
        # format.js { @status = "success"}
      else
        format.html do
          flash.now[:alert] = "プロフィールの更新に失敗しました"
          render :edit
        end
        format.js do
          # @status = "fail"
          # @error_message = @post.errors.full_messages.join("\n")
        end
      end
    end
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find_by(user_id: current_user.id)
  end

  def user_profile_params
    params.require(:user_profile).permit(
      :profile, :thumbnail, :bg_image, :remove_thumbnail, :remove_bg_image
    )
  end
end
