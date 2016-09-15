module Profile
class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @friends = current_player.friends
  end

  def reject
    current_player.reject_invitation_from Player.find(params[:id])
    redirect_to request.referer
  end

  def delete
    current_player.delete_friend Player.find(params[:id])
    redirect_to request.referer
  end

  def approve
    current_player.approve_invitation_from Player.find(params[:id])
    redirect_to request.referer
  end

  def look_for
    @players = Player.where('name LIKE ?',"%#{params[:name]}%")
    render json: @players.to_json(methods: :avatar)
  end

  def invite
    if current_player.invite_friend Player.find_by(id: params[:id])
    redirect_to request.referer
    else
      redirect_to request.referer,  {notice: "Невозможно пригласить игрока"}
    end
  end


  def destroy
    current_player.friendships.find_by(friend_id: params[:id]).delete
    redirect_to request.referer
  end
end
end