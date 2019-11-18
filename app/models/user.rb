class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true
  has_many :posts
  has_many :bookmarks, dependent: :destroy
  has_many :favposts, through: :bookmarks, source: :post
  has_many :relationships
  has_many :followers, through: :relationships, source: :fan
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "fan_id"
  has_many :followings, through: :reverse_relationships, source: :user
end
