class PictureUploader < BaseUploader::BaseUploader
  process resize_to_limit: [
    (Settings.carrierwave.post_image&.resize_limit_x || 200),
    (Settings.carrierwave.post_image&.resize_limit_y || 200)
  ]
end
