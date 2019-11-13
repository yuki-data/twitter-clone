class Post < ApplicationRecord
  mount_uploader :image, PictureUploader
  validates :content, presence: true, unless: :image?
  belongs_to :user
end
