$(document).ready(function(){
  $(document).on('ajax:success', 'form[data-remote]', function(e,data,status,xhr){
    $(this).find('[data-type=delete]').attr('value','Удалено').attr('disabled',"disabled")
  })
});
