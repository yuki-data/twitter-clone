class Relationship < ApplicationRecord
  validates :user_id, uniqueness: { scope: :fan_id }
  validate :prevent_follow_myself
  belongs_to :user
  belongs_to :fan, class_name: "User"

  def prevent_follow_myself
    errors.add(:user, "自分自身のフォローはできません") if user_id == fan_id
  end
end
