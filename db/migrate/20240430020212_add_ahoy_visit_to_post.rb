class AddAhoyVisitToPost < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :ahoy_visit, foreign_key: true
    add_reference :questions, :ahoy_visit, foreign_key: true
  end
end
