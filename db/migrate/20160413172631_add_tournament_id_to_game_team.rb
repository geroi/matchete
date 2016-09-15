class AddTournamentIdToGameTeam < ActiveRecord::Migration
  def change
  	add_column :game_teams, :tournament_id, :integer
  	
  	add_index :game_teams, :tournament_id
  end
end
