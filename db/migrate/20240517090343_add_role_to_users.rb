class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer
    add_column :posts, :status, :integer
    add_column :comments, :status, :integer
  end
end
