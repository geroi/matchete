//props: player, game
var InvitePlayerToGameButton = React.createClass({
  render: function(){
    return(
    <form method="post" action={"/games/"+this.props.game.id+"/add_participant/" + this.props.player.id}>
    <button type="submit" className="btn btn-default glyphicon glyphicon-plus"/>
    <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
    </form>
    )
  }
})