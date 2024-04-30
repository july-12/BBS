class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  belongs_to :category
  has_many :comments, as: :commentable, dependent: :destroy
  # has_many :comments, -> { no_reply_comments }, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :author_id, presence: true

  has_many :favorites, class_name: "Favorite", as: :operatable, dependent: :destroy
  has_many :likes, class_name: "Like", as: :operatable, dependent: :destroy
  has_many :subscribes, class_name: "Subscribe", as: :operatable, dependent: :destroy

  visitable :ahoy_visit

  def repliers
    User.joins(:comments).where("comments.commentable_type = ? AND comments.commentable_id = ?", "Post", id).distinct
  end
end
