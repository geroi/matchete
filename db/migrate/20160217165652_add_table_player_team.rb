class AddTablePlayerTeam < ActiveRecord::Migration
  def change
    create_table :player_team do |t|
      t.belongs_to :player, index: true
      t.belongs_to :team, index: true
    end
  end
end
