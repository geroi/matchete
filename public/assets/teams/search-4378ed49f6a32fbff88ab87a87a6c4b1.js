$(document).ready(function(){
  $(document).on('ajax:success','#teams_search',function(e,data,status,xhr){
    var teams = JSON.parse(xhr.responseText);
    $('#search-results > table > tbody > tr').remove();
    teams.map(function(team){

      players_line = ""
      team.players.map(function(player){
        players_line += "<a href='/"+player.id+"'><img src='" + player.avatar + "' style='width: 50px; height: 50px' class='img-circle'/></a>"
      })

      team_line = "\
      <tr>\
        <td>\
          <img src='"+ team.type.logo +"'  style='width: 50px; height: 50px'  class='img'/>\
        </td>\
        <td>\
          <a href='/teams/"+team.id+"'>\
          <img src='"+ team.logo +"'  style='width: 50px; height: 50px'  class='img'/>\
          </a>\
        </td>\
        <td>\
          <a href='/teams/"+team.id+"'>\
          <h4>\
           "+ team.name +"\
          </h4>\
          </a>\
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
