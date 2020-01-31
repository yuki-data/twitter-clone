class ProfileThumbnailUploader < BaseUploader::BaseUploader
  process resize_to_limit: [
    (Settings.carrierwave.profile_thumbnail&.resize_limit_x || 100),
    (Settings.carrierwave.profile_thumbnail&.resize_limit_y || 100)
  ]
end
