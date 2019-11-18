class Relationship < ApplicationRecord
  validates :user_id, uniqueness: { scope: :fan_id }
  belongs_to :user
  belongs_to :fan, class_name: "User"
end
