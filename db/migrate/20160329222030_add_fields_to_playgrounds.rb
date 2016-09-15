class AddFieldsToPlaygrounds < ActiveRecord::Migration
  def change
  	add_column :playgrounds, :lighting, :string
  	add_column :playgrounds, :adm_area, :string
  	add_column :playgrounds, :email, :string
  	add_column :playgrounds, :facility_type, :string
  	add_column :playgrounds, :district, :string
  	add_column :playgrounds, :website, :string
  	add_column :playgrounds, :phone, :string
  	add_column :playgrounds, :has_rental, :boolean, default: false
  	add_column :playgrounds, :has_dressing_room, :boolean, default: false
  	add_column :playgrounds, :has_toilet, :boolean, default: false
  	add_column :playgrounds, :has_first_aid, :boolean, default: false
  end
end
