var Notice = React.createClass({
  render: function(){
    if ( this.props.errors.length != 0 ) {

    var errors_spans = []

    this.props.errors.map(function(error){
      errors_spans.push(<li>{error.message}</li>)
    })

    return (
        <div className="alert alert-danger" role="alert">
        {errors_spans}
        </div>
    )
  } else {
        return(null)
      }
  }
})
