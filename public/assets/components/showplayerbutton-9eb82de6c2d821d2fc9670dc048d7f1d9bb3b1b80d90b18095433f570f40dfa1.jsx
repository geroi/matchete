//props: Player
var ShowPlayerButton = React.createClass({
  render: function(){
    return(
    <form method="get" action={"player/" + this.props.player.id}>
      <button type="submit" className="btn btn-default glyphicon glyphicon-eye-open"/>
      <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
    </form>
    )
  }
})