class AddApprovedFieldToGameInvitation < ActiveRecord::Migration
  def change
    add_column :player_games, :approved, :boolean, default: false
  end
end
