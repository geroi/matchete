class RemoveMarksPlaces < ActiveRecord::Migration
  def change
    drop_table :marks
    drop_table :places
  end
end
