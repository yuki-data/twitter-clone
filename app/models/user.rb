class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favposts, through: :bookmarks, source: :post
  has_many :relationships, dependent: :destroy
  has_many :followers, through: :relationships, source: :fan
  has_many :reverse_relationships, class_name: "Relationship",
                                   foreign_key: "fan_id",
                                   dependent: :destroy
  has_many :followings, through: :reverse_relationships, source: :user
  has_one :user_profile, dependent: :destroy

  after_create :create_profile

  def is_followed(user)
    followers.include?(user)
  end

  def is_following(user)
    followings.include?(user)
  end

  def follow(user)
    reverse_relationships.create(user_id: user.id)
  end

  def unfollow(user)
    reverse_relationships.find_by(user_id: user.id)&.destroy
  end

  def create_profile
    UserProfile.create(user_id: id)
  end
end
