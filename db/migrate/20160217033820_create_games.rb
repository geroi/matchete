class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :name
      t.integer :host_id
      t.integer :sport_id
      t.string :address
      t.integer :first_team_id
      t.integer :second_team_id
      t.integer :first_team_score, default: 0
      t.integer :second_team_score, default: 0
      t.datetime :game_date_time
      t.timestamps null: false
    end
  end
end
