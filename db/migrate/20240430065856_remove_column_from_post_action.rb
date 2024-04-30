class RemoveColumnFromPostAction < ActiveRecord::Migration[7.1]
  def change
    remove_column :post_actions, :post_id
    add_reference :posts, :category, foreign_key: true
  end
end
