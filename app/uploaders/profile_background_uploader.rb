class ProfileBackgroundUploader < BaseUploader::BaseUploader
  process resize_to_limit: [
    (Settings.carrierwave.profile_background&.resize_limit_x || 400),
    (Settings.carrierwave.profile_background&.resize_limit_y || 200)
  ]
  def extension_whitelist
    %w(jpg jpeg png)
  end
end
