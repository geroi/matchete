class GameSearchController < ApplicationController
  def main
    @types = Type.all
    # render layout: 'fluid'
  end

  def fetch_games
    start_time = translate_date params[:game][:start_time]
    end_time = translate_date params[:game][:end_time]
  	if params[:game][:team_game] == 'false'
    	@games = Game.where("game_date_time > ? AND game_date_time < ? AND type_id = ?",start_time, end_time, params[:game][:type_id]) 
	    puts @games
	    render json: @games.to_json(include: {type:{},playground:{}, players: {methods: :avatar}, host: {methods: :avatar}})
    else
    	@games = TeamGame.where("game_date_time > ? AND game_date_time < ? AND type_id = ?",start_time, end_time, params[:game][:type_id]) 
	    puts @games
	    render json: @games.to_json(include: {type:{},playground:{}, host_team: {methods: :logo}, visitor_team: {methods: :logo}, host: {methods: :avatar}})
    end
  end

  def translate_date date
    DateTime.strptime(date,'%d.%m.%Y')
  end
end