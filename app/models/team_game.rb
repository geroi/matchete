class TeamGame < ActiveRecord::Base #КОМНАДНАЯ ИГРА
  # validates :name, length: { :in => 4..32 }
  # validates :name, :type_id, :playground_id, :game_date_time, presence: true, on:[:create, :update]
  after_create :add_host_team_record
  
  self.table_name = 'games'
  default_scope -> {where individual: false}
  has_many :comments, as: :messagable

  belongs_to :host, class_name:'Player', foreign_key:'player_id'
  belongs_to :type
  belongs_to :playground
  belongs_to :first_team, class_name:'Team',foreign_key:'first_team_id'
  # belongs_to :second_team, class_name:'Team',foreign_key:'second_team_id'

  has_many :claims, -> {where host: false, approved: false, host_initiated: false}, foreign_key: :game_id, class_name: 'GameTeam'
  has_many :teams_claimed_for, through: :claims,  source: :team  
  has_many :invitations, -> {where host: false, approved: false, host_initiated: true}, foreign_key: :game_id, class_name: 'GameTeam'
  has_many :teams_invited_to, through: :invitations,  source: :team
  
  has_one :approved_claim, -> {where approved: true, host: false}, foreign_key: :game_id, class_name: 'GameTeam'
  has_one :visitor_team_record, -> {where approved: true, host: false}, foreign_key: :game_id, class_name: 'GameTeam'
  has_one :visitor_team, through: :approved_claim, source: :team
  has_one :second_team, through: :approved_claim, source: :team
  
  has_one :host_team_record, -> {where host: true}, foreign_key: :game_id, class_name: 'GameTeam'
  has_one :host_team, through: :host_team_record, source: :team
  # has_many :approved_claims, -> {where approved: true}, class_name: 'PlayerGame', foreign_key: :game_id
  # has_many :players, through: :approved_claims, source: :player
  
  # has_many :claims, -> {where approved: false}, class_name: "PlayerGame", foreign_key: :game_id
  # has_many :potential_participants, through: :claims, source: :player
  
  # has_many :all_claims, class_name: "PlayerGame",foreign_key: :game_id
  # has_many :claimers_and_players, through: :all_claims, source: :player
  
  scope :actual, -> { where('game_date_time > ?', Date.today.beginning_of_day) }
  scope :last_week, -> { where('game_date_time > ? and game_date_time < ?', (Date.today-1.week), Date.today) }

  def add_host_team_record
  	GameTeam.create(game_id: self.id, team_id: first_team.id, host: true, approved: true)
  end

  def invite_team team
    if team != self.host_team && !self.teams_claimed_for.include?(team) && self.visitor_team != team
       GameTeam.create(game_id: self.id, team_id: team.id, approved: false)
    else
      false
    end
  end

  def approve_team team
    if team != self.host_team && self.teams_claimed_for.include?(team) && !self.visitor_team
    	approving_team = GameTeam.find_by(game_id: self.id, team_id: team.id);
      	if approving_team
      		approving_team.update(approved:true)
        else
          false
      	end
    end
  end

  def reject_team team
  	rejecting_team = GameTeam.find_by(game_id: self.id, team_id: team.id);
  	if rejecting_team
      rejecting_team.delete
    else
  		false
  	end
  end

  def reject_all_teams
  	GameTeam.where(game_id: self.id, team_id: team.id).delete_all
  end
  # def add_self_to_players
  #   PlayerGame.create(player_id: self.host.id, game_id: self.id, approved: true)
  # end

  # def teams
  #   Team.where("id = ? OR id = ?",self.first_team_id, self.second_team_id)
  # end

  # def approve_participant player
  #   if potential_participant_exists? player
  #     self.claims.find_by(player_id:player.id).approve
  #   end
  # end

  # def add_participant player
  #   unless potential_participant_exists?(player) && not_host?(player)
  #     PlayerGame.create(player_id: player.id, game_id: self.id)
  #   end
  # end

  # def deny_participant player
  #   if not_host?(player)
  #     self.all_claims.find_by(player_id:player.id).reject
  #   end
  # end
  
  # def potential_participant_exists? player
  #   potential_participants.include? player
  # end

  def winner
    if first_team_score < second_team_score
      visitor_team
    elsif second_team_score < first_team_score
      host_team
    else
      [host_team,visitor_team]
    end
  end

  def not_host? player
    self.host != player
  end
  
  # MESSAGING
  def time_ordered_messages
    self.comments.order(created_at: :desc)
  end
  # MESSAGING_END

end
