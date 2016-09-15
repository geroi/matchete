class AddFirstSecondTeamIndexesToGame < ActiveRecord::Migration
  def change
    add_index :games, :first_team_id
    add_index :games, :second_team_id
  end
end
