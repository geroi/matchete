class PlayerController < ApplicationController

  def show
    @player = passed_player
    if @player == current_player
    	redirect_to profile_path
    end
  end

private
  def passed_player
    Player.find(params[:id])
  end
end