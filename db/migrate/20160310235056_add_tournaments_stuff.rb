class AddTournamentsStuff < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :host_id, index: true, null: false
      t.timestamps null: false
    end

    create_table :tournament_teams do |t|
      t.integer :tournament_id, index: true, null: false
      t.integer :team_id, index: true, null: false
      t.integer :position
      t.timestamps null: false
    end
  end
end
