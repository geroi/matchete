class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :name
      t.timestamps null: false
    end
  end
end