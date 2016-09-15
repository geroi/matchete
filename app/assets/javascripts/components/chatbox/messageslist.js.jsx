var MessagesList = React.createClass({
  align: function(prev_align,same_bool){
    var prev_align_bool, prev_same_bool;
    prev_align_bool = (prev_align == 'left') ? true : false
    result = same_bool ? prev_align_bool : !prev_align_bool
    return result ? 'left' : 'right'
  },
  render: function(){
    var self = this;
    var messages_list = [];
    var previous_author_id;
    var alignment = 'right';
    var same;
    this.props.messages.map(function(message){
      if ( previous_author_id == message.author_id ){
        same = true;
        messages_list.push(<MessageEntity message={message} alignment={self.align(alignment, same)} />)
      } else {
        same = false;
        messages_list.push(<MessageEntity message={message} alignment={self.align(alignment, same)} />)
      }
      previous_author_id = message.author_id;
      alignment = self.align(alignment, same);
    });

    return (
        <div className="chat-discussion" style={{height:'300px', 'overflowY':'scroll', 'overflowX':'hidden'}}>
            {messages_list}
        </div>
    )
  }
})