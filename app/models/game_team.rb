class GameTeam < ActiveRecord::Base #ЗАПИСИ ОБ ИГРАХ и КОМНАДНАХ
  belongs_to :team
  belongs_to :game
  belongs_to :team_game, class_name: 'TeamGame', foreign_key: :game_id

  def approve
    self.update(approved: true)
  end

  def reject
    self.delete
  end
end
