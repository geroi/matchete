class RenameRelation < ActiveRecord::Migration
  def change
    rename_table :relations, :friendships
    rename_column :friendships, :player1_id, :player_id
    rename_column :friendships, :player2_id, :friend_id
  end
end
