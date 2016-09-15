$(document).ready(function(){
console.log('gotcha');  
$(".dropdown-menu .color-panel").click(function(){
  $(this).children('input').prop('checked', true);
  color = $(this).css('background-color');
  $('#preview').css({'background-color':color});
});
});
