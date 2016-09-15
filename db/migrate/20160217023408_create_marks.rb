class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end
