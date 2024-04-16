class AddPolymorphicToComment < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :commentable, polymorphic: true
    change_column :comments, :post_id, :bigint, null: true
  end
end
