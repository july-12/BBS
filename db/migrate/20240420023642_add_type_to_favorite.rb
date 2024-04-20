class AddTypeToFavorite < ActiveRecord::Migration[7.1]
  def change
    rename_table :favorites, :post_actions
    add_column :post_actions, :type, :string
  end
end
