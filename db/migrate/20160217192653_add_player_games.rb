class AddPlayerGames < ActiveRecord::Migration
  def change
    create_table :player_games do |t|
      t.belongs_to :player, index: true
      t.belongs_to :game, index: true
    end
  end
end
