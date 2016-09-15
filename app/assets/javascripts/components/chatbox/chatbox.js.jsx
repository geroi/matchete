var Polling = {

    startPolling: function() {
        var self = this;

        setTimeout(function() {
            self.poll();

            if (!self.isMounted()) {
                return;
            }

            self._timer = setInterval(self.poll, 1000);
        }, 1000);
    },

    poll: function() {
        if (!this.isMounted()) {
            return;
        }
        
        token = this.props.authenticity_token;
        var self = this;
        $.post( this.props.source,
                null,
                function(data) {
                        self.setState({
                          messages: data
                        });
                }
            )

        }

    }

var ChatBox = React.createClass({

  mixins: [Polling],

  getInitialState: function(){
    return ({
      messages: [],
      game: this.props.game,
      player: this.props.player
    })
  },

  getLastMessageDate: function(){
    $messages = $(this.state.messages)
    if ( $messages.size() != 0 ) {
      return $messages.last().created_at
    } else {
      return false
    };
},

  componentDidMount:function(){
    this.startPolling();
  },

  componentDidUpdate:function(){
    $('.chat-discussion').scrollTop(9999);
  },

  render: function(){
    var lastMessageDate;
    if ( this.getLastMessageDate() ) {
      lastMessageDate = "<small className='pull-right text-muted'>последнее сообщение отправлено {moment(this.getLastMessageDate()).fromNow()}</small>"
    }
    return (
      <div className='ibox chat-view'>
        <div className='ibox-title'>
          {lastMessageDate}
          Игровой чат
        </div>
        <div className='ibox-content'>
          <MessagesList messages={this.state.messages}/>
          <InputBox authenticity_token={this.props.authenticity_token} player={this.props.player} game={this.props.game}/>
        </div>
      </div>
    );
  }
})