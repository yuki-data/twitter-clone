class UserProfilesController < ApplicationController
  def edit
    @user_profile = UserProfile.find_by(user_id: current_user.id)
  end

  def update
    binding.pry
  end
end
