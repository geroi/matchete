$(document).ready(function(){
	function getRandomColor() {
	  var letters = '0123456789ABCDEF'.split('');
	  var color = '#';
	  for (var i = 0; i < 6; i++ ) {
	      color += letters[Math.floor(Math.random() * 16)];
	  }
	  return color;
	  }

	// карты
	playgrounds = JSON.parse($('#playgrounds').val());

	var playgroundsMap, playgroundsCollection;
	ymaps.ready(init);

	function init () {
    playgroundsMap = new ymaps.Map('map', {
        center: [55.76, 37.64], // Москва
        zoom: 11
    }, {
        searchControlProvider: 'yandex#search'
    });

    	playgroundsCollection = new ymaps.GeoObjectCollection();

  		playgrounds.map(function(playground){
  			playgroundsCollection.add(create_placemark(playground));
  		});


  		playgroundsMap.geoObjects.add(playgroundsCollection);
	};

    function create_placemark(playground){
        var lat = playground.latitude,
            lng = playground.longitude,
            game_placemark;

         game_placemark = new ymaps.Placemark([lat,lng], {
                    balloonContent: "<div class='row'>\
                    <div class='col-md-12'>\
                        <h4>"+playground.address+"\
                        </h4>\
                        <h4>"+playground.name+"\
                        </h4>\
                    </div>\
                    </div>",
                    balloonContentFooter: "<div class='row'>\
                        <div class='col-md-12'>\
                            <a href='/playgrounds/"+playground.id+"' class='btn btn-default pull-right'><span class='glyphicon glyphicon-eye-open'>Смотреть</span></a>\
                        </div>\
                    </div>"
                  },{
                    preset: 'islands#dotIcon', 
                    iconColor: getRandomColor()
                });
         game_placemark.events.add('click', function (e) {
			    $('.game-playground-select').first().val(playground.id);
			});

          return game_placemark;
  		}
});
