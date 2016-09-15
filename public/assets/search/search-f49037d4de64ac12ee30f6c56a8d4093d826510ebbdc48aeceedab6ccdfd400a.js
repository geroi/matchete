$(document).ready(function(){
  
  var myMap;
  ymaps.ready(init);

  function init () {
    myMap = new ymaps.Map('map', {
        center: [55.76, 37.64], // Москва
        zoom: 11
    }, {
        searchControlProvider: 'yandex#search'
    })};

  function fill (map, coords) {
        map.geoObjects.add(new ymaps.Placemark([coords.lat,coords.lng], {
          balloonContent: coords.name
        }, { preset: 'islands#icon',iconColor: '#0095b6'}))
  }


  $('#submit').on('click',function(event){
    event.preventDefault();

    $.post('/search', $('#search-form').serialize(), function(response){
      $('#results_table > tbody > tr:not(:first-child)').remove();
      response.forEach(function(game){
        game = $.parseJSON(game)
        var results =""
        var name = game.name
        var playground = game.playground.name
        var quantity = game.players.length
        var type = game.type.name
        var host = game.host.name
        var date_time = game.game_date_time
        var id = game.id
        show_button = "<td><a href='/game/show/"+id+"'class='btn btn-primary'>Просмотр</a></td>"
        results =  $('<tr><td></td><td>'+name+'</td><td>'+playground+'</td><td>'+quantity+'</td><td>'+host+'</td><td>'+type+'</td><td>'+date_time+'</td>'+show_button+'</tr>')
        $('#results_table > tbody').append(results);

        var lat = game.playground.latitude
        var lng = game.playground.longitude
        var coords = {'lat':lat,'lng':lng, 'name':game.name}
        fill(myMap, coords);
      })      
    })
  })

});
