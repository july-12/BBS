class PostAction < ApplicationRecord
  # belongs_to :post
  belongs_to :user

  belongs_to :operatable, polymorphic: true
end
