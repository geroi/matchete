class AddPositionAndRoleToTeam < ActiveRecord::Migration
  def change
    add_column :player_teams, :position_name, :string
    add_column :player_teams, :position_number, :integer
  end
end
