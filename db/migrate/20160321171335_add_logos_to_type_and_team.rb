class AddLogosToTypeAndTeam < ActiveRecord::Migration
  def change
    add_attachment :teams, :logo
  end
end
