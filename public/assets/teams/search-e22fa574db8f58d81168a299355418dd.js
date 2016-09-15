$(document).ready(function(){
  $(document).on('ajax:success','#teams_search',function(e,data,status,xhr){
    var teams = JSON.parse(xhr.responseText);
    $('#search-results > table > tbody > tr').remove();
    teams.map(function(team){
      team_line = "<tr>TEAM</tr>"
      $('#search-results > table > tbody').append(team_line)
    })
  }).on('ajax:error',function(e,data,status,xhr){
    $('#search-results').html("<p>ERROR</p>")
  })
});
