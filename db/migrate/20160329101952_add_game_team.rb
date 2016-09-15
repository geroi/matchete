class AddGameTeam < ActiveRecord::Migration
  def change
  	create_table :game_teams do |t|
  		t.integer :team_id, null: false
  		t.integer :game_id, null: false
  		t.boolean :approved, default: false
  		t.boolean :host, default: false
  		t.timestamps null: false
  	end

  	add_index :game_teams, :team_id
  	add_index :game_teams, :game_id
  end
end
