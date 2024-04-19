class Comment < ApplicationRecord
  # belongs_to :post
  belongs_to :commenter, class_name: :User, foreign_key: :author_id
  belongs_to :commentable, polymorphic: true

  validates :author_id, presence: true
  validates :content, presence: true, length: { minimum: 2 }

  after_create_commit -> { broadcast_append_to commentable }
end
