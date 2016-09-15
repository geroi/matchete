class AddHostInitiatedToGameTeams < ActiveRecord::Migration
  def change
  	add_column :game_teams, :host_initiated, :boolean, default: false
  end
end
