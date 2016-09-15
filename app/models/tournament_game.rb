class TournamentGame < GameTeam #ЗАПИСИ ОБ ТУРНИРНЫХ ИГРАХ

	after_update :update_game_score

	default_scope -> {where.not tournament_id: nil}

	belongs_to :team_game, class_name: 'TournamentTeamGame', foreign_key: :game_id

	def update_game_score
		if team_game.first_team_id == self.team_id
			team_game.update(first_team_score: self.score)
		else
			team_game.update(second_team_score: self.score)
		end
	end
end
