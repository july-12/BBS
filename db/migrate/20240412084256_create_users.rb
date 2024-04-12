class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.boolean :gender
      t.integer :age

      t.timestamps
    end
  end
end
