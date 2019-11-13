class Post < ApplicationRecord
  validates :content, presence: true, unless: :image?
  belongs_to :user
end
