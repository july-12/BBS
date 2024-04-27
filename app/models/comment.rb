class Comment < ApplicationRecord
  # belongs_to :post
  belongs_to :commenter, class_name: :User, foreign_key: :author_id
  belongs_to :commentable, polymorphic: true

  has_many :replies, class_name: "Comment", foreign_key: :reply_id

  validates :author_id, presence: true
  validates :content, presence: true, length: { minimum: 2 }

  default_scope -> { where("commentable_type IS NOT NULL").order(created_at: "ASC") }

  scope :no_reply_comments, -> { where("reply_id IS NULL") }

  after_create_commit -> { broadcast_append_to commentable }
end
