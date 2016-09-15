$(document).ready(function(){
console.log('gotcha');  
$(".dropdown-menu .color-panel").click(function(){
  $(this).children('input').prop('checked', true);
  color = $(this).css('background-color');
  $(this).closest('.dropdown').find('a').css({'background-color':color});
});
});