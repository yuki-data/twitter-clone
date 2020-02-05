class UserProfile < ApplicationRecord
  mount_uploader :thumbnail, ProfileThumbnailUploader
  mount_uploader :bg_image, ProfileBackgroundUploader
  belongs_to :user
  validates :user_id, uniqueness: true
end
