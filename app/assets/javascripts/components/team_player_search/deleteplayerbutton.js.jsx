//props: Player
var DeletePlayerButton = React.createClass({
  render: function(){
    return(
    <form method="post" action={"/profile/friends/" + this.props.player.id + "/invite"}>
    <button type="submit" className="btn btn-default glyphicon glyphicon-remove"/>
    <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
    </form>
    )
  }
})