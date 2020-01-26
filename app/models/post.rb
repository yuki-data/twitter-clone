class Post < ApplicationRecord
  mount_uploader :image, PictureUploader
  validates :content, presence: true, unless: :image?
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :favusers, through: :bookmarks, source: :user

  def is_bookmarked(user_id)
    favuser_ids.include?(user_id)
  end

  def self.timeline(user)
    if user
      Post.where(user_id: [user.id] + user.following_ids)
    end
  end

  def self.search_by_content(keyword)
    return if keyword.size == 0
    Post.where("content like ?", "%#{keyword}%")
  end

  def remove_image=(val)
    if val == "1"
      self.image = nil
    end
  end
end
