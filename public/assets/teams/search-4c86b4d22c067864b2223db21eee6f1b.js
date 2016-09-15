$(document).ready(function(){
  $(document).on('ajax:success','#teams_search',function(e,data,status,xhr){
    var teams = JSON.parse(xhr.responseText);
    $('#search-results > table > tbody > tr').remove();
    teams.map(function(team){

      players_line = ""
      team.players.map(function(player){
        players_line += "<img src='" + player.avatar + "' style='width: 50px; height: 50px'/>"
      })

      team_line = "\
      <tr>\
        <td>\
          <img src='"+ team.type.logo +"'  style='width: 50px; height: 50px'/>\
        </td>\
        <td>\
          <img src='"+ team.logo +"'/>\
        </td>\
        <td>\
          <h4>\
           "+ team.name +"\
          </h4>\
        </td>\
        <td>\
           "+ players_line +"\
        </td>\
      </tr>\
      "
      $('#search-results > table > tbody').append(team_line)
    })
  }).on('ajax:error',function(e,data,status,xhr){
    $('#search-results').html("<p>ERROR</p>")
  })
});
