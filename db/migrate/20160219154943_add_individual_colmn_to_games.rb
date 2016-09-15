class AddIndividualColmnToGames < ActiveRecord::Migration
  def change
    add_column :games, :individual, :boolean, default: true
  end
end
