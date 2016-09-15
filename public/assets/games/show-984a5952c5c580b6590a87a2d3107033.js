$(document).ready(function(){
	$('#lightgallery').lightGallery();
  
  ymaps.ready(function(){
    var lat = $('[data-playground]').data('playground')['latitude']
    var lng = $('[data-playground]').data('playground')['longitude']
    
    var playground_placemark = new ymaps.Placemark([lat,lng], {
                    },{
                      // Опции.
                      // Необходимо указать данный тип макета.
                      iconLayout: 'default#image',
                      // Своё изображение иконки метки.
                      iconImageHref: '/assets/running-126002f79e3a719dceb166d6a1284b1b.png',
                      // Размеры метки.
                      iconImageSize: [30, 42],
                      // Смещение левого верхнего угла иконки относительно
                      // её "ножки" (точки привязки).
                      iconImageOffset: [-3, -42]
                  });
    var playgroundsCollection = new ymaps.GeoObjectCollection()
    
    playgroundsCollection.add(playground_placemark);
    currentMap.geoObjects.add(playgroundsCollection);
    currentMap.setCenter([lat,lng]);
    currentMap.setZoom(16);
  })
  
});
