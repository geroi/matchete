//props: player, team
var InvitePlayerToTeamButton = React.createClass({
  render: function(){
    return(
    <form method="post" action={"/teams/"+this.props.team.id+"/invite_teammate/" + this.props.player.id}>
    <button type="submit" className="btn btn-default">
    	<span className=' glyphicon glyphicon-plus'></span> Пригласить
    </button>
    <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
    </form>
    )
  }
})