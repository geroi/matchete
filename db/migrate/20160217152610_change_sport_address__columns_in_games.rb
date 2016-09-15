class ChangeSportAddressColumnsInGames < ActiveRecord::Migration
  def change
    rename_column :games, :address, :playground_id
    add_index :games, :playground_id
    rename_column :games, :sport_id, :type_id
    change_column :games, :name, :string
  end
end
