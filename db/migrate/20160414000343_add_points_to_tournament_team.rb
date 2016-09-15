class AddPointsToTournamentTeam < ActiveRecord::Migration
  def change
  	add_column :tournament_teams, :points, :integer, default: 0
  end
end
