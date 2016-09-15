class Team < ActiveRecord::Base
  after_create :add_host_to_players

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>", small: "50x50>" }, default_url: "/images/:style/default_team_logo.gif"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  belongs_to :type 
  belongs_to :host, class_name: "Player", foreign_key: "host_id"
  # has_one :player_team
  has_many :comments, as: :messagable

  has_many :colors, class_name:'TeamColor', foreign_key: :team_id

  has_many :all_claims, class_name:'PlayerTeam', foreign_key: :team_id
  has_many :claims, -> {where host_initiated: false, approved: false }, class_name:'PlayerTeam', foreign_key: :team_id
  has_many :invitations, -> {where host_initiated: true, approved: false }, class_name:'PlayerTeam', foreign_key: :team_id
  
  has_many :approved_claims, -> {where approved: true, host_initiated: false }, class_name:'PlayerTeam', foreign_key: :team_id
  has_many :approved_invitations, -> {where approved: true, host_initiated: true }, class_name:'PlayerTeam', foreign_key: :team_id

  has_many :all_approved_tickets, -> {where approved: true}, class_name:'PlayerTeam', foreign_key: :team_id

  has_many :players_with_host, through: :all_approved_tickets, source: :player
  has_many :players, ->(host){ where.not id:host.id}, through: :all_approved_tickets, source: :player
  has_many :player_and_claimers, through: :all_claims, source: :player

  has_many :claimers, through: :claims, source: :player
  has_many :invited, through: :invitations, source: :player

  has_many :game_records, -> {where host: false }, foreign_key: :team_id, class_name: 'GameTeam'
  has_many :host_game_records, -> {where host: true }, foreign_key: :team_id, class_name: 'GameTeam'
  has_many :approved_game_records, -> {where host: false, approved: true}, foreign_key: :team_id, class_name: 'GameTeam'
  has_many :game_invitations, -> {where host: false, approved: false}, foreign_key: :team_id, class_name: 'GameTeam'
  has_many :not_approved_game_records, -> {where  host: false, approved: false}, foreign_key: :team_id, class_name: 'GameTeam'

  has_many :invited_and_played_games, through: :game_records, source: :team_game
  has_many :hosted_games, through: :host_game_records, source: :team_game
  has_many :played_games, through: :approved_game_records, source: :team_game
  has_many :not_approved_games, through: :not_approved_game_records, source: :team_game
  has_many :invited_games, through: :game_invitations, source: :team_game


  def games
    played_games + hosted_games
  end

  def time_ordered_messages
    self.comments.order(created_at: :desc)
  end

  def approve_teammate_claim player
    if find_claim_from player
      find_claim_from(player).approve
    end
  end

  def approve_team_invitation player
    if find_invitation_for player
      find_invitation_for(player).approve
    end
  end

  def invite_teammate player
    unless player_and_claimers.include? player
      PlayerTeam.create(player_id: player.id, team_id: self.id, host_initiated: true)
    end
  end

  def create_claim_from player
    unless player_and_claimers.include? player
      PlayerTeam.create(player_id: player.id, team_id: self.id, host_initiated: false)
    end
  end

  def delete_teammate player
    find_claim_or_invitation(player).delete
  end

  def find_invitation_for player
    invitations.find_by(player_id: player.id)
  end

  def find_claim_from player
    claims.find_by(player_id: player.id)
  end

  def find_claim_or_invitation player
    all_claims.find_by(player_id: player.id)
  end

  def add_color color
    TeamColor.create(team_id: self.id, color: color)
  end

private
  def add_host_to_players
    invite_teammate self.host
    approve_team_invitation self.host
  end
end
