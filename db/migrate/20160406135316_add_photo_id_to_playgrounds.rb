class AddPhotoIdToPlaygrounds < ActiveRecord::Migration
  def change
  	add_column :playgrounds, :photo, :string
  end
end
