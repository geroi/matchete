class Player < ActiveRecord::Base
  include ActionView::Helpers

  # before_save :default_photo

  has_attached_file :avatar, styles: { '200': '200x200', medium: "300x300", thumb: "100x100", small: "50x50" }, default_url: "/images/:style/default_player_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :games
  has_many :owned_teams, class_name: 'Team', foreign_key: 'host_id'
  
  has_many :not_approved_game_claims, -> {where approved:false}, :class_name => "PlayerGame", :foreign_key => 'player_id'
  has_many :claimed_games, :through => :not_approved_game_claims, :source => :game 
  
  has_many :approved_game_claims, -> {where approved: true}, :class_name => "PlayerGame", :foreign_key => 'player_id'
  has_many :participated_with_hosted_games, :through => :approved_game_claims, :source => :game 
  
  has_many :created_games, class_name: 'Game', foreign_key: :player_id
  has_many :created_team_games, class_name: 'TeamGame', foreign_key: :player_id

  has_many :game_invitations, -> {where approved:false, host_initiated: true}, class_name: 'PlayerGame', foreign_key: :player_id
  has_many :game_claims, -> {where approved:false, host_initiated: false}, class_name: 'PlayerGame', foreign_key: :player_id
  has_many :approved_tickets, -> {where approved: true}, class_name: 'PlayerGame', foreign_key: :player_id

  has_many :games_claimed_for, through: :game_claims, source: :game
  has_many :games_invitated_to, through: :game_invitations, source: :game
  has_many :full_participated_games, through: :approved_tickets, source: :game

  has_many :occurances_as_friend, :class_name => "Friendship", :foreign_key => "friend_id"
  
  has_many :approved_incoming_friendships, -> {where approved: true }, class_name: "Friendship", :foreign_key => "friend_id"
  has_many :approved_outgoing_friendships, -> {where approved: true }, class_name: "Friendship", :foreign_key => "player_id"
  has_many :incoming_friendship_claims, -> {where approved: false }, class_name: "Friendship", :foreign_key => "friend_id"
  has_many :outgoing_friendship_claims, -> {where approved: false }, class_name: "Friendship", :foreign_key => "player_id"

  has_many :outgoing_friends, through: :approved_outgoing_friendships, source: :friend
  has_many :incoming_friends, through: :approved_incoming_friendships, source: :player
  # has_many :incoming_friendship_claims, class_name: "Friendship", :foreign_key => "friend_id"
  # has_many :friendship_claims, -> {where approved: true}, :foreign_key => "player_id"
  # has_many :invitations,  -> {where approved: false}, :class_name => "Friendship", :foreign_key => "player_id"

  has_many :team_invitations, -> {where approved:false, host_initiated: true}, class_name: 'PlayerTeam', foreign_key: :player_id
  has_many :team_claims, -> {where approved:false, host_initiated: false}, class_name: 'PlayerTeam', foreign_key: :player_id
  has_many :approved_tickets, -> {where approved: true}, class_name: 'PlayerTeam', foreign_key: :player_id

  has_many :teams_claimed_for, through: :team_claims, source: :team
  has_many :teams_invitated_to, through: :team_invitations, source: :team
  has_many :full_participated_teams, through: :approved_tickets, source: :team

  has_many :teams, through: :approved_tickets, source: :team
  
  def accept_all_friends
    incoming_friendship_claims.each do |claim|
      claim.update(approved: true)
    end
  end
  
  def position_in_team team
    approved_tickets.find_by(team_id: team.id).position_name
  end

  def number_in_team team
    approved_tickets.find_by(team_id: team.id).position_number
  end

  def participated_games
    participated_with_hosted_games - created_games
  end

  def self.not_participated_in game
    player_ids_ary = game.players.ids
    Player.where('id NOT IN (?)',player_ids_ary)
  end

  def participated_teams
    full_participated_teams.to_a - owned_teams.to_a
  end

  def claim_for_game game
    game.become_participant self
  end

  def claim_for_team team
    team.create_claim_from self
  end

  def reject_team_invitation_from team
    team.delete_teammate self
  end

  def approve_team_invitation_from team
    team.approve_team_invitation self
  end

  def friends_with? person
    friends.include? person
  end

  def delete_friend person
    Friendship.where('(player_id = ? AND friend_id = ?) OR (player_id = ? AND friend_id = ?)', self.id, person.id, person.id, self.id).each do |f|
        f.delete
    end
  end

  def approve_invitation_from player
    if invitation_exists_from? player
      incoming_invitations.find_by(player_id: player.id).update(approved:true)
    else
      false
    end
  end

  def reject_invitation_from player
    if invitation_exists_from? player
      incoming_invitations.find_by(player_id: player.id).delete
    else
      false
    end
  end

  def invite_friend player
    if self.invitation_exists_to?(player) || self.invitation_exists_from?(player) || self.friends.include?(player)
      false
    else
      Friendship.create(player_id: self.id, friend_id: player.id)
    end
  end

  def delete_invitation_for player
    if invitation_exists_to? player    
      outgoing_invitations.find_by(friend_id: player.id).delete
    end
  end

  def invitation_exists_to? player
    !outgoing_invitations.where(friend_id: player.id).empty?
  end

  def invitation_exists_from? player
    !incoming_invitations.where(player_id: player.id).empty?
  end

  def outgoing_invitations
    self.outgoing_friendship_claims
  end

  def incoming_invitations
    self.incoming_friendship_claims
  end

  def friends
    incoming_friends + outgoing_friends
  end

    # MESSAGING 
  def send_game_message(text, game_id)
    Comment.create(text: text, messagable_id: game_id, messagable_type: 'Game', author_id: self.id)
  end

  def send_team_message(text, team_id)
    Comment.create(text: text, messagable_id: team_id, messagable_type: 'Team', author_id: self.id)
  end
    # MESSAGING_END 

  def types
    types_ary = []
    self.games.each do |game|
      types_ary.push(game.type)
    end
    types_ary.uniq
  end
  
private

  def default_photo
    self.photo = image_url('player.jpg')
  end
end
