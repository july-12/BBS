class AddPolyMorphicToPostAction < ActiveRecord::Migration[7.1]
  def change
    add_reference :post_actions, :operatable, polymorphic: true
    change_column :post_actions, :post_id, :bigint, null: true
  end
end
