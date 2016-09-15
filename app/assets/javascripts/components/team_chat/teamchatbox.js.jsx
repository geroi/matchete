var TeamChatBox = React.createClass({

  mixins: [Polling],

  getInitialState: function(){
    return ({
      messages: [],
      team: this.props.team,
      player: this.props.player
    })
  },

  componentDidMount:function(){
    this.startPolling();
  },
  componentDidUpdate:function(){
    $('.messages-list').first().scrollTop(1000);
    console.log('moved')
  },
  render: function(){
    return (
      <div className='team-chat-box' className='col-md-12'>
        <MessagesList ref='messages_list' messages={this.state.messages}/>
        <TeamInputBox authenticity_token={this.props.authenticity_token} player={this.props.player} team={this.props.team}/>
      </div>
    );
  }
})