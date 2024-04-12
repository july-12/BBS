class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  has_many :comments

  validates :title, presence: true
  validates :author_id, presence: true
end
