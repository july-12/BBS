class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :author_id, presence: true
end
