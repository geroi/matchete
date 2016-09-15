class TeamsController < ApplicationController
  before_action :check_for_host, only: :edit

  def get_team_messages
    @messages = current_team.time_ordered_messages.limit(10).reverse
    puts @messages
    render json: @messages.to_json(include: :author)
  end
  
  def index
    @user_teams = current_player.owned_teams
    @participated_teams = current_player.participated_teams
  end

  def approve_teammate_claim
    current_team.approve_teammate_claim passed_player
    redirect_to edit_team_path(current_team)
  end

  def approve_team_invitation
    current_team.approve_team_invitation passed_player
    redirect_to edit_team_path(current_team)
  end

  def become_teammate
    current_player.claim_for_team current_team
    redirect_to request.referer
  end

  def invite_teammate
    current_team.invite_teammate passed_player
    redirect_to edit_team_path(current_team)
  end

  def delete_teammate
    current_team.delete_teammate passed_player
    redirect_to edit_team_path(current_team)
  end

  def create
    @team = Team.new(team_params.merge(host_id: current_player.id))
    if @team.save
      redirect_to teams_path
    end
  end

  def new
    @types = Type.all
    @team = Team.new
  end

  def edit
    @team = current_team
    @types = Type.all
  end

  def show
    @team = current_team
    @current_player = current_player
    if @team.host == @current_player
      @action_partial = render_to_string partial: 'teams/host_actions'
    elsif @team.players.include? @current_player
      @action_partial = render_to_string partial: 'teams/player_actions'
    else
      @action_partial = render_to_string partial: 'teams/spectator_actions'
    end
  end

  def update
    team = current_team
    team.update_attributes(team_params)
    if params[:colors]
      params[:colors].each do |id, color|
        TeamColor.find(id).update(color: color)
      end
    end
    redirect_to edit_team_path
  end

  def destroy
    current_team.delete
    redirect_to request.referer
  end

  def invitations
  end

  def claims
  end

  def search
    @types = Type.all
  end

  def look_for_teams
    if params[:type] == ""
      teams = Team.where('name LIKE ?',"%#{params[:name]}%")
    else
      teams = Team.where('name LIKE ? and type_id = ?',"%#{params[:name]}%", params[:type])
    end
    
    if teams.empty?
      render json: []
    else
      render json: teams.to_json({include: { type: {methods: [:logo, :name]}, players: {methods: [:avatar, :name, :id]} }, methods: :logo })
    end
  end

  def search_players_for_team
    @players = Player.all.where('name LIKE ?',"%#{params[:name]}%") - current_team.player_and_claimers
    render json: @players
  end

private
  def check_for_host
    unless current_team.host == current_player
      redirect_to current_team
    end
  end

  def current_team
    Team.find_by(id: params[:id])
  end

  def passed_player
    Player.find_by(id: params[:player_id])
  end

  def team_params
    params.require(:team).permit(:id,:name,:player_id,:type_id,:host_id,:logo, :address)
  end
end