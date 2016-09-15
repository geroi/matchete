class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :type_id
      t.integer :player_id

      t.timestamps null: false
    end
    add_index :teams, :type_id
    add_index :teams, :player_id
  end
end
