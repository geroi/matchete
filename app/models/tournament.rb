class Tournament < ActiveRecord::Base
  belongs_to :host, foreign_key: :host_id, class_name: 'Player'

  has_many :team_records, foreign_key: :tournament_id, class_name: 'TournamentTeam'
  has_many :game_records, foreign_key: :tournament_id, class_name: 'TournamentGame'
  has_many :all_games, through: :game_records, source: :team_game
  has_many :teams, through: :team_records, source: :team

  def add_team team
    TournamentTeam.create(tournament_id: self.id, team_id: team.id)
  end

  def start_tournament
  	teams.each do |host_team|
  		(teams.to_a-[host_team]).each do |visitor_team|
  			create_game_between host_team, visitor_team
  		end
  	end 
  end
  
  def games
  	all_games.uniq
  end

  def played_games
  	games.where("game_date_time < ? ",Date.today.beginning_of_day)
  end
  
  def accept_team
  end

  def reject_team
  end

  def create_game_between team1, team2
  	game = TeamGame.create(player_id: host.id, name:"Tournament game #{team1} vs #{team2}", first_team_id: team1.id, second_team_id: team2.id, first_team_score: 0, second_team_score: 0, game_date_time: Date.tomorrow)
  	TournamentGame.create(team_id: team1.id, game_id: game.id, host: true, approved: true, score: 0, tournament_id: self.id)
  	TournamentGame.create(team_id: team2.id, game_id: game.id, host: false, approved: true, score: 0, tournament_id: self.id)
  end

  def refresh_points
  	team_records.each do |record|
  		record.update(points: 0)
  	end
  	
  	games.each do |game|
  		winner_team = game.winner
  		
  		if winner_team.kind_of? Team
  			tournament_team_record = team_records.find_by(team_id: winner_team.id)
  			points = tournament_team_record.points
  			tournament_team_record.update(points: points + 3)
  		elsif winner_team.kind_of? Array
  			draw_teams = winner_team
  			draw_teams.each do |team|
  				tournament_team_record = team_records.find_by(team_id: team.id)
	  			points = tournament_team_record.points
	  			tournament_team_record.update(points: points + 1)
  			end
  		end
  	end
  end

end