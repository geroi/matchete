class AddLogosToType < ActiveRecord::Migration
  def change
      add_attachment :types, :logo
  end
end
