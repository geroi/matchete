$(document).ready(function(){
  $('.hidden[data-game-id]').slice(0,5).removeClass('hidden');
  
  $('#more_games_btn').click(function(){
      $('.hidden[data-game-id]').removeClass('hidden');
      self.hide();
  })
});