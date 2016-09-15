class AddHashIdToPlaygrounds < ActiveRecord::Migration
  def change
    add_column :playgrounds, :hash_id, :string
  end
end
