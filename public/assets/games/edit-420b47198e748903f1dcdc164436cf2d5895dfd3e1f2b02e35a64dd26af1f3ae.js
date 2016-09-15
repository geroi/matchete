$(document).ready(function(){
  $(document).on('ajax:success','#search_result',function(e,data,status,xhr){
    alert("dsd")
    $('#search_result').html(xhr.responseText)
  });
});
