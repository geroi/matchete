class AddScoreToGameTeam < ActiveRecord::Migration
  def change
  	add_column :game_teams, :score, :integer, default: 0
  end
end
