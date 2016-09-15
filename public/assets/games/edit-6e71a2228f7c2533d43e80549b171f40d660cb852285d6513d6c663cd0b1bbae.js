$(document).ready(function(){
  $(document).on('ajax:success','#players_search',function(e,data,status,xhr){
    $('#search_result').html(xhr.responseText)
  })
  ;
});
