class Ahoy::Event < ApplicationRecord
  include Ahoy::QueryMethods

  self.table_name = "ahoy_events"

  belongs_to :visit
  belongs_to :user, optional: true

  scope :post_viewed_count, ->(post_id) { where(name: "ViewedPost").where("properties->>'id' = '?'", post_id).count }
end
