class AddHostInitiatedToPlayerGames < ActiveRecord::Migration
  def change
	add_column :player_games, :host_initiated, :boolean, default: false
  end
end
