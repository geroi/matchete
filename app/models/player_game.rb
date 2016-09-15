class PlayerGame < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  def approve
    self.update(approved: true)
  end

  def reject
    self.delete
  end
end
