//props: player, team
var InviteFriendButton = React.createClass({
  render: function(){
    return(
    <form method="post" action={"/profile/friends/"+this.props.player.id+"/invite"}>
    <button type="submit" className="btn btn-default">
    	<span className=' glyphicon glyphicon-plus'></span> Пригласить
    </button>
    <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
    </form>
    )
  }
})