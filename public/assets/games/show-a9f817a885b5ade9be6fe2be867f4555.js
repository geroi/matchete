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
                      iconImageHref: '/assets/sports_icons/running-2af785e0921b746af3f929decb666f8f.png',
                      // Размеры метки.
                      iconImageSize: [64, 64],
                      // Смещение левого верхнего угла иконки относительно
                      // её "ножки" (точки привязки).
                      iconImageOffset: [-32, -32]
                  });
    var playgroundsCollection = new ymaps.GeoObjectCollection()
    
    playgroundsCollection.add(playground_placemark);
    currentMap.geoObjects.add(playgroundsCollection);
    currentMap.setCenter([lat,lng]);
    currentMap.setZoom(16);
  })
  
});
