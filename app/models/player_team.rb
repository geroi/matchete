class PlayerTeam < ActiveRecord::Base
  belongs_to :player
  belongs_to :team

  def approve
    self.update(approved: true, position_name: 'Полузащитник', position_number: rand(100))
  end

  def reject
    self.delete
  end
end
