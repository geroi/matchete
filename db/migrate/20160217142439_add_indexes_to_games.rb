class AddIndexesToGames < ActiveRecord::Migration
  def change

    rename_column :games, :host_id, :player_id

    add_index :games, :player_id

  end
end
