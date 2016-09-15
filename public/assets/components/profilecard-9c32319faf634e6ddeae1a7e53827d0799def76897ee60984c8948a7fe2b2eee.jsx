var ProfileCard = React.createClass({
  render:function(){
    return(
      <div className="col-md-6">
        <div className="col-sm-6">
          <img src={this.props.player.photo} className='img-thumbnail' />
        </div>
        <div className="col-sm-6">
          {this.props.player.name}
        </div>
      </div>
    )
  }
})
