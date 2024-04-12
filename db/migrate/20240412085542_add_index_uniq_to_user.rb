class AddIndexUniqToUser < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :name, unique: true
    add_index :users, :phone, unique: true
    remove_index :users, :email
    add_index :users, :email, unique: false
  end
end
