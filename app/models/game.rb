class Game < ActiveRecord::Base
  # validates :name, length: { :in => 4..32 }
  # validates :name, :type_id, :playground_id, :game_date_time, presence: true, on:[:create, :update]
  after_create :add_self_to_players, :set_individual_true
  default_scope -> {where individual: true}

  belongs_to :host, class_name:'Player', foreign_key:'player_id'
  belongs_to :type
  belongs_to :playground
  belongs_to :first_team, class_name:'Team',foreign_key:'first_team_id'
  belongs_to :second_team, class_name:'Team',foreign_key:'second_team_id'

  has_many :comments, as: :messagable

  has_many :approved_claims, -> {where approved: true}, class_name: 'PlayerGame', foreign_key: :game_id
  has_many :players, through: :approved_claims, source: :player
  
  has_many :claims, -> {where approved: false, host_initiated: false}, class_name: "PlayerGame", foreign_key: :game_id
  has_many :potential_participants, through: :claims, source: :player

  has_many :invitations, -> {where approved: false, host_initiated: true}, class_name: "PlayerGame", foreign_key: :game_id
  has_many :invited_potential_participants, through: :invitations, source: :player
  
  has_many :all_claims, class_name: "PlayerGame",foreign_key: :game_id
  has_many :claimers_and_players, through: :all_claims, source: :player
  
  scope :actual, -> { where('game_date_time > ?', Date.today.beginning_of_day) }
  scope :last_week, -> { where('game_date_time > ? and game_date_time < ?', (Date.today-1.week), Date.today) }

  def teams
    Team.where("id = ? OR id = ?",self.first_team_id, self.second_team_id)
  end

  def approve_participant player
    if potential_participant_exists? player
      self.claims.find_by(player_id:player.id).approve
    end
  end

  def add_participant player
    unless potential_participant_exists?(player) && not_host?(player)
      PlayerGame.create(player_id: player.id, game_id: self.id, host_initiated: true)
    end
  end  

  def become_participant player
    unless potential_participant_exists?(player) && not_host?(player)
      PlayerGame.create(player_id: player.id, game_id: self.id, host_initiated: false)
    end
  end

  def deny_participant player
    if not_host?(player)
      self.all_claims.find_by(player_id:player.id).reject
    end
  end
  
  def potential_participant_exists? player
    potential_participants.include? player
  end

  def not_host? player
    self.host != player
  end
  
  # MESSAGING
  def time_ordered_messages
    self.comments.order(created_at: :desc)
  end
  # MESSAGING_END
  # seeding
private
  def add_self_to_players
    PlayerGame.create(player_id: self.host.id, game_id: self.id, approved: true)
  end

  def set_individual_true
    self.update(individual: true)
  end
end
