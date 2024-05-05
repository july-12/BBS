class AddHtmlToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :rawhtml, :string
    add_column :questions, :rawhtml, :string
    add_column :comments, :rawhtml, :string
  end
end
