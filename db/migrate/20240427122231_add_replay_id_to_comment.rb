class AddReplayIdToComment < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :reply, foreign_key: { to_table: :comments }
    add_reference :comments, :sub_reply, foreign_key: { to_table: :comments }
  end
end
