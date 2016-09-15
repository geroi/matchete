class RenamePlayerIndexInTeams < ActiveRecord::Migration
  def change
    rename_column :teams, :player_id, :host_id
  end
end
