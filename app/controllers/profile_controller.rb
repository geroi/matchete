class ProfileController < ApplicationController
  def index
    @player = current_player
  end
  
  def search
    @players = Player.all
    render :template => 'profile/_search'
  end

  def invitations
    @incoming_invitations = current_player.incoming_invitations
    @outgoing_invitations = current_player.outgoing_invitations
    render :template => 'profile/_invitations'
  end

  def edit
    @player = current_player
  end

  def update
    current_player.update_attributes(player_params)
    render nothing: true# redirect_to profile_path
  end

private
  def player_params
    params.require(:player).permit(:name,:avatar)
  end
end