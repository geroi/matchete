//требует authencicity_token

var TeamInputBox = React.createClass({
  submitForm: function(e){
    e.preventDefault();

    var $this = $(this)
    token = this.props.authenticity_token
    $.ajax({
      method: 'post',
      url: '/send_team_message',
      data:{
        text: this.refs.message_text.value,
        team_id: this.props.team.id
      },
      beforeSend: function (xhr)
            {
                xhr.setRequestHeader("X-CSRF-Token", token);
            },
      success: function(data) {
        this.refs.message_text.value = ""
      }.bind(this),
    })

  },
  render: function(){
    return (
      <div className='row'>
          <div className='col-md-2'>
              <AuthorPic author={this.props.player}/>
          </div>
          <div className='col-md-8'>
              <div className='row'>
                  <form className='input-box form-horizontal'>
                      <div className='col-md-10'>
                          <div className='form-group'>
                              <input ref='message_text' type='text' name='message_text' placeholder='Введите текст сообщения' className='form-control'/>
                              <input type='hidden' name='authenticity_token' value={this.props.authenticity_token}/>
                          </div>
                      </div>
                      <div className='col-md-2'>
                          <button onClick={this.submitForm} className='btn btn-primary btn-md glyphicon glyphicon-envelope'></button>
                      </div>
                  </form>
              </div>
          </div>
      </div>
    )
  }
})