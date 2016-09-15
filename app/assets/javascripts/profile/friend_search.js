$(document).ready(function(){
  $(document).on('ajax:success', '#search' ,function(e,data,status,xhr){
    $('#search_results').html(xhr.responseText)
  }).on('ajax:error',function(e,data,status,xhr){
    $('#search_results').html("<p>ERROR</p>")
  })

  $(document).on('ajax:success', 'form[data-remote]', function(e,data,status,xhr){
    $(this).find('[data-type=invite]').attr('value','Отправлено').attr('disabled',"disabled")
  })
});