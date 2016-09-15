function MyLib(){

    this.lowerize = function(text){
      return(text.toLowerCase())
    }
}

var myLib = new MyLib();

var SearchFriendsForm = React.createClass({



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
      this.setState( {errors: [{message:'Введите имя'}] } )
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
      url: this.props.source,
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
    authenticity_token = this.props.authenticity_token
    this.state.players.map(function(player){
      filteredPlayers.push(
            <tr>
                <td>
                  <img className='client-avatar' src={player.avatar} />
                </td>
                <td>
                  <span>
                    {player.name}
                  </span>
                </td>
                <td>
                  <ShowPlayerButton player={player} authenticity_token={authenticity_token}/>
                </td>
                <td>
                  <InviteFriendButton player={player} authenticity_token={authenticity_token}/>
                </td>
            </tr>
        )
    })

    return (
      <div id="search-box" className='row'>
          <div className='row'>
              <div className='col-md-12'>
                  <form className='form-horizontal'>
                      <div className="input-group">
                          <input type='hidden' name='authenticity_token' value={this.props.authenticity_token}/>
                          <input ref='search_input' type="text" name='search' placeholder="Введите имя" className="input form-control" onChange={this.handleChange} />
                          <span className="input-group-btn">
                                  <button type="button" className="btn btn btn-primary" onClick={this.submitForm}>
                                    <i className="fa fa-search"></i> Найти
                                  </button>
                          </span>
                      </div>
                  </form>
              </div>
          </div>
          <div className='row'>
            <div className='col-md-12'>
              <Notice errors={this.state.errors} />
            </div>
          </div>
          <div className='row'>
            <div className='col-md-12'>
              <div className='clients-list' style={{'overflowY':'scroll', 'maxHeight':'250px'}}>
                  <div className="table-responsive">
                    <table className="table table-striped table-hover">
                      <tbody>
                        {filteredPlayers}
                      </tbody>
                    </table>
                  </div>
              </div>
            </div>
          </div>
      </div>
    );
  }



})
{/*
                      // <div className='form-group' id="search-line">
                      //     <div className='col-md-2'>
                      //         <label htmlFor='search' className='control-label'>Поиск:</label>
                      //     </div>
                      //     <div className='col-md-10'>
                      //         <div className='row'>
                      //             <div className='col-md-10'>
                      //                 <input ref='search_input' type='text' name='search' onChange={this.handleChange} className='form-control'/>
                      //                 <input type='hidden' name='authenticity_token' value={this.props.authenticity_token}/>
                      //             </div>
                      //             <div className='col-md-2'>
                      //                 <button onClick={this.submitForm} className='btn btn-primary btn-md glyphicon glyphicon-search'></button>
                      //             </div>
                      //         </div>
                      //     </div>
                      // </div>


                      // <div className='row'>
                      //   <div className='col-md-12'>
                      //       <div className='row'>
                      //           <div className='col-md-8'>
                      //             <span>
                      //               {player.name}
                      //             </span>
                      //           </div>
                      //           <div className='col-md-2'>
                      //             <ShowPlayerButton player={player} authenticity_token={authenticity_token}/>
                      //           </div>
                      //           <div className='col-md-2'>
                      //             <InviteFriendButton player={player} authenticity_token={authenticity_token}/>
                      //           </div>
                      //       </div>
                      //   </div>
                      // </div>
*/}