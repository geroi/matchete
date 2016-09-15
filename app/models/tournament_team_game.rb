class TournamentTeamGame < TeamGame #ТУРНИРНЫЕ ИГРЫ
	has_one :visitor_team_record, -> {where host: false}, foreign_key: :game_id, class_name: 'TournamentGame'
  	has_one :visitor_team, through: :visitor_team_record, source: :team
  
  	has_one :host_team_record, -> {where host: true}, foreign_key: :game_id, class_name: 'TournamentGame'
  	has_one :host_team, through: :host_team_record, source: :team

end
