class Bookmark < ApplicationRecord
  validates :user_id, uniqueness: { scope: :post_id }
  belongs_to :user
  belongs_to :post
  counter_culture :post
end
