class AddTeamColors < ActiveRecord::Migration
  def change
    create_table :team_colors do |t|
      t.integer :team_id, null:false
      t.string :color, default: '#ffffff'
    end

  add_index :team_colors, :team_id
  end
end
