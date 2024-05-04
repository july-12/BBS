class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, uniqueness: true, presence: true

  has_many :posts
end
