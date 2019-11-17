class Post < ApplicationRecord
  mount_uploader :image, PictureUploader
  validates :content, presence: true, unless: :image?
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :favusers, through: :bookmarks, source: :user
end
