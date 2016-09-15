class AddHostInitiated < ActiveRecord::Migration
  def change
    add_column :player_teams, :host_initiated, :boolean, default: false
    add_column :player_teams, :approved, :boolean, default: false
  end
end
