class RenamePlayerTeamToPlayersTeams < ActiveRecord::Migration
  def change
    rename_table :player_team, :player_teams
  end
end
