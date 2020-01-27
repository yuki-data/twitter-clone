class ProfileBackgroundUploader < BaseUploader::BaseUploader
  process resize_to_limit: [
    (Settings.carrierwave&.resize_limit_x || 200),
    (Settings.carrierwave&.resize_limit_y || 200)
  ]
end
