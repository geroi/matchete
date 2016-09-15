function MyLib(){

    this.lowerize = function(text){
      return(text.toLowerCase())
    }
}

var myLib = new MyLib();

var SearchForm = React.createClass({



  getInitialState: function(){
    return ( { 
      text: '',
      players: [],
      errors: [] // [{message: ''},{message: ''}]
  })},



  handleChange:function(e){
    this.setState( { text: e.target.value } )
  },



  submitForm: function(e){
    e.preventDefault();
    if ( this.validate() ) {
      this.setState ( { players: this.searchByName(this.refs.search_input.value) } )
    }
  },


  validate: function(){
    if (this.state.text == '') {
      this.setState( {errors: [{message:'Empty name field'}] } )
      return false
    } else {
      this.setState({errors: [] })
      return true
    }
  },

  fetchPlayers: function(){
    var $this = $(this)
    token = this.props.authenticity_token
    $.ajax({
      method: 'post',
      url: '/test-search',
      data:{
        name: this.refs.search_input.value,
        game_id: this.props.game_id
      },
      beforeSend: function (xhr)
            {
                xhr.setRequestHeader("X-CSRF-Token", token);
            },
      success: function(data) {
        this.setState({ players: data });
      }.bind(this),
    })
  },

  searchByName:function(name){
    var result_ary = [];
    this.fetchPlayers();
    this.state.players.map(function(player){
      if ( myLib.lowerize(player.name).includes(myLib.lowerize(name)) ) {
        result_ary.push(player)
      }
    });
    return(result_ary);
  },



  render: function(){
    var filteredPlayers = []

    this.state.players.map(function(player){
      filteredPlayers.push(
        <tr>
          <td className='col-sm-10'>
            <span className='pull-left'>
              {player.name}
            </span>
          </td>
          <td className='col-sm-1'>
            <ShowPlayerButton player={player}/>
          </td>
          <td className='col-sm-1'>
            <InvitePlayerButton player={player}/>
          </td>
        </tr>
        )
    })

    return (
      <div className='col-md-6'>
      <Notice errors={this.state.errors} />
      <form className='form-horizontal'>
        <div className='form-group'>
              <label htmlFor='search' className='control-label col-sm-2'>Поиск:</label>
              <div className='col-sm-10'>
                  <div className='col-xs-10'>
                  <input ref='search_input' type='text' name='search' onChange={this.handleChange} className='form-control'/>
                  <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
                  </div>
                  <button onClick={this.submitForm} className='btn btn-primary btn-md glyphicon glyphicon-search col-xs-2'> </button>
              </div>
        </div>
      </form>
          <table className='table table-hover'>
            <thead>
              </thead>
            <tbody>
              {filteredPlayers}
            </tbody>
          </table>
      </div>
    );
  }



})