$(document).ready(function(){
	
	var map;
	ymaps.ready(init);

	function init () {

	playground = JSON.parse($('#playground').val());
    
    playgroundsMap = new ymaps.Map('map', {
        center: [playground.latitude, playground.longitude], // Москва
        zoom: 16,
        controls: []
    }, {
        searchControlProvider: 'yandex#search'
    });
  		playgroundsMap.geoObjects.add(create_placemark(playground));
	};

    function create_placemark(playground){
        var lat = playground.latitude,
            lng = playground.longitude,
            game_placemark;

         game_placemark = new ymaps.Placemark([lat,lng], null,{
                    preset: 'islands#dotIcon'
                });

          return game_placemark;
  		}
});
