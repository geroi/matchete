class GamesController < ApplicationController

  def index #show games
    @actual_games = Game.actual.order(:game_date_time => :asc).first(10)
    @actual_team_games = TeamGame.actual.order(:game_date_time => :asc).first(10)
    @last_week_games = Game.last_week + TeamGame.last_week
  end

  def create # post game data
    @game = Game.new(game_params.merge({player_id: current_player.id}))
    puts game_params.merge({player_id: current_player.id})
    if @game.save
      if params[:players_to_invite]
          params[:players_to_invite].each do |player_id|
            @game.add_participant(Player.find(player_id))
          end
      end
      redirect_to user_games_url
    else
      flash[:notice] = 'Игра не создана'
      render 'new'
    end
  end

  def create_team_game # post game data
    clean_params = game_params.dup
    clean_params.delete(:second_team_id)
    puts clean_params
    @game = TeamGame.new(clean_params.merge({individual: false}))
    if @game.save
      
      unless game_params[:second_team_id].empty?
        @game.invite_team Team.find(game_params[:second_team_id])
      end

      redirect_to game_path(@game)
    else
      flash[:notice] = 'Игра не создана'
      render 'new'
    end
  end

  def new #new game
    @types = Type.all
    
    Rails.cache.fetch('all_playgrounds') do
      @playgrounds = Playground.all
    end
    
    @game = Game.new()
  end

  def edit #edit game
    @types = Type.all
    @playgrounds = Playground.all
    @current_player = current_player
    @game = current_player.created_games.find_by(id: params[:id])
    @friends = current_player.friends
  end

  def new_team_game #new game
    unless current_player.owned_teams.empty?
      @game = Game.new()
      @current_player = current_player
      @types = Type.all
  
      Rails.cache.fetch('all_playgrounds') do
        @playgrounds = Playground.all
      end
  
      @owned_teams = current_player.owned_teams
      @teams = Team.all - @owned_teams
    else
      flash[:notice] = "У вас нет ни одной команды"
      redirect_to teams_path
    end
  end

  def edit_team_game #edit game
    @types = Type.all
    @playgrounds = Playground.all
    @game = current_player.created_team_games.find_by_id(params[:id])
    render 'edit_team_game'
  end
  
  def show #id
    @game = Game.find_by_id(params[:id]) ? Game.find_by_id(params[:id]) : TeamGame.find_by_id(params[:id])
    if @game.individual == false
      render 'show_team_game'
    else
      render 'show'
    end
  end
  
  def update #PUT game data
    @game = Game.find(params[:id])
    @game.update(game_params.to_hash.except(:players))
    if game_params[:players]
      game_params[:players].each {|player|
        PlayerGame.create(game_id: game_params[:id], player_id: game_params[:players][1])
      }
    end
    redirect_to action: :edit
  end  

  def update_team_game #PUT game data
    @game = TeamGame.find_by_id(params[:id])
    puts "------------------"
    puts team_game_params
    @game.update(team_game_params)
    redirect_to action: :edit_team_game
  end
  
  def destroy #DELETE game
    game = Game.find_by_id(params[:id]) ? Game.find_by_id(params[:id]) : TeamGame.find_by_id(params[:id])
    game.destroy
    redirect_to request.referer
  end
####################################################
  
  def get_messages
    @messages = game.time_ordered_messages.limit(5).reverse
    puts @messages
    render json: @messages.to_json({include: {author: {methods: :avatar}}})
  end

#########################################PARTICIPANTS
  def add_participant
    game.add_participant Player.find_by(id: params[:player_id])
    redirect_to request.referer
  end

  def become_participant
    game.become_participant Player.find_by(id: params[:player_id])
    redirect_to request.referer
  end

  def approve_participant
    game.approve_participant Player.find_by(id: params[:player_id])
    redirect_to request.referer
  end

  def deny_participant
    game.deny_participant Player.find_by(id: params[:player_id])
    redirect_to request.referer
  end
####################################################

  def approve_team
    team_game.approve_team passed_team
    redirect_to request.referer
  end

  def reject_team
    team_game.reject_team passed_team
    redirect_to request.referer
  end

####################################################
  def user_games
    @created_games = current_player.created_games
    @created_team_games = current_player.created_team_games
    @participated_games = current_player.participated_games
    @claimed_games = current_player.claimed_games
  end

  private
  def passed_team
    Team.find_by(id: params[:team_id])
  end

  def game
    Game.find_by(id: params[:id])
  end

  def team_game
    TeamGame.find_by(id: params[:id])
  end
  
  def param_player
    Player.find_by(id: params[:player_id])
  end
  
  def game_params
    params.require(:game).permit(:id,:name,:player_id,:type_id,:playground_id,:first_team_id,:second_team_id,:first_team_score,:second_team_score,:game_date_time)
  end

  def team_game_params
    params.require(:team_game).permit(:id,:name,:player_id,:type_id,:playground_id,:first_team_id,:second_team_id,:first_team_score,:second_team_score,:game_date_time)
  end

  def host_game_params
    params.require(:game).permit(:id,:name,:player_id,:type_id,:playground_id,:first_team_id,:game_date_time)
  end
end