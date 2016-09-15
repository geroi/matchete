class AddFriendsRelationsTable < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :player1_id, index:true
      t.integer :player2_id, index:true
      t.boolean :approved, default: false
      t.timestamps null: false
    end
  end
end
