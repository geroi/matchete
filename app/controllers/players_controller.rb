class PlayersController < ApplicationController
  layout 'inspinia', only: [:test]

  def send_game_message
    current_player.send_game_message(params[:text], params[:game_id])
    render nothing: true, status: :ok
  end

  def send_team_message
    current_player.send_team_message(params[:text], params[:team_id])
    render nothing: true, status: :ok
  end

  def profile
  end

  def look_for_players
    @players = Player.not_participated_in(Game.find(params[:game_id])).where('name LIKE ?',"%#{params[:name]}%")
    render json: @players
  end

  def test
    @game = Game.first
  end

  def test_search
    @players = Player.not_participated_in(Game.find(params[:game_id])).where('name LIKE ?',"%#{params[:name]}%")
    render json: @players
  end
end
