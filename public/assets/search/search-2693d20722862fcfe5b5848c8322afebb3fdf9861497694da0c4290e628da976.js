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

  $(document).on('ajax:success','#search-form',function(e, data, status, xhr){
    $('#results_table > tbody > tr:not(:first-child)').remove();
    $('#results_table > tbody').append(xhr.responseText);
  })

        // Дописать получение ДЖСОН координат площадок и залить ими карту
        // var lat = game.playground.latitude
        // var lng = game.playground.longitude
        // var coords = {'lat':lat,'lng':lng, 'name':game.name}
        // fill(myMap, coords);
 
});
