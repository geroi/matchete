var TextBox = React.createClass({
  render: function(){
    return (
      <div className='col-md-11'>
          <div className='panel panel-default'>
              <p>
                  {this.props.message.text}
              </p>
              <p className='text-right'>
                  <h6>
                    <small>
                      {this.props.message.author.name}
                    </small>
                  </h6>
              </p>
          </div>
      </div>
      )
  }
})