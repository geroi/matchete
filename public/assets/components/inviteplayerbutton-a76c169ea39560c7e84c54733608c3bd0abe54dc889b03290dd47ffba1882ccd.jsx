//props: Player
var InvitePlayerButton = React.createClass({
  render: function(){
    return(
    <form method="get" action={"/profile/friends/" + this.props.player.id + "/invite"}>
    <button type="submit" className="btn btn-default glyphicon glyphicon-plus"/>
    </form>
    )
  }
})