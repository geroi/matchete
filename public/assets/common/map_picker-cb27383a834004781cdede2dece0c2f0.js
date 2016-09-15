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
	ymaps.ready(init);

  function init () {
    var playgroundsMap = new ymaps.Map('map', {
        center: [55.76, 37.64], // Москва
        zoom: 11
    }, {
        searchControlProvider: 'yandex#search'
    });

    var loadingObjectManager = new ymaps.LoadingObjectManager('/get_playgrounds?tiles=%t&bbox=%b&zoom=%z',
      {   
        // Включаем кластеризацию.
        clusterize: true,
        // Опции кластеров задаются с префиксом cluster.
        clusterHasBalloon: false,
        // Опции объектов задаются с префиксом geoObject
        geoObjectOpenBalloonOnClick: true,
        paddingTemplate: 'fetchPlaygrounds'
      });

    loadingObjectManager.objects.options.set('preset', 'islands#blueDotIcon');

    playgroundsMap.geoObjects.add(loadingObjectManager);

    function onObjectEvent (e) {
        var obj = e.get('target');
        var objectId = e.get('objectId')
        $('#game_playground_id').val(objectId)
      }

// Назначаем обработчик событий для коллекции объектов менеджера.   
    loadingObjectManager.objects.events.add(['click'], onObjectEvent);

  };
});
