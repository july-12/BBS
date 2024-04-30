class PostAction < ApplicationRecord
  # belongs_to :post
  belongs_to :user

  belongs_to :operatable, polymorphic: true

  validates_uniqueness_of :user_id, scope: [:type, :operatable_id, :operatable_type]
end
