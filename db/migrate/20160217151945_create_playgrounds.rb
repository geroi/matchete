class CreatePlaygrounds < ActiveRecord::Migration
  def change
    create_table :playgrounds do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
