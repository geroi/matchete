var ProfileCard = React.createClass({
  render:function(){
    return(
      <div className="col-md-6">
        <div className="col-sm-6">
          <img src={"/assets/player-f4c8721b8773f798dbbcf7c6e1e5183e13edac237ebab610bb049aee959d23f4.jpg"} className="img-thumbnail"/>
        </div>
        <div className="col-sm-6">
          {this.props.player.name}
        </div>
      </div>
    )
  }
})
