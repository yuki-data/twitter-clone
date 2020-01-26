class UserProfilesController < ApplicationController
  def edit
    @user_profile = UserProfile.new
  end
end
