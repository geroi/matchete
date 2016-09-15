$(document).ready(function(){
  
  var myMap;
  var objects;
  ymaps.ready(init);
  // myMap.behaviors.disable([ruler]);

  function getRandomColor() {
      var letters = '0123456789ABCDEF'.split('');
      var color = '#';
      for (var i = 0; i < 6; i++ ) {
          color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
  }


  function init () {
    $('#map').width(document.body.clientWidth * 1.6)
    myMap = new ymaps.Map('map', {
        center: [55.753559, 37.609218], // Москва
        zoom: 11,
        controls: []
    }, {
        searchControlProvider: 'yandex#search'
    })

    myMap.controls
    .add('zoomControl', {
      float: 'right',
      position: {
        top: 100,
        left: $(window).width() -  40
      }
    })
    .add("typeSelector", {
        float: "right",
        position: {
        top: 60,
        left: $(window).width() - 40
      }
    });
    
    setPlacemarksFromPage();
    

    $('a.show-game-on-map-btn').click(function(e){
        e.preventDefault();
        clickGoto(e.target);
    });
  

  };



  function refill (map, collection) {
        map.geoObjects.removeAll();
        map.geoObjects.add(collection);
  }

  function players_images_line(players) {
      var line = '';

      players.map(function(player){
        console.log(player)
        line+= "<img src='"+ player['avatar'] +"' class='img-circle' style='width: 50px;'>"
      })
      return line;
  }


  function create_game_placemark(game){
        var lat = game.playground.latitude,
            lng = game.playground.longitude,
            game_placemark;

         game_placemark = new ymaps.Placemark([lat,lng], {
                    id: game.id,
                    balloonContentHeader: "<div class='row'>\
                        <div class='col-md-4'>\
                            <a href='/"+ game.host.id +"'>\
                                <img src='"+ game.host.avatar +"' class='img-circle' style='width: 50px;'>\
                            </a>\
                        </div>\
                        <div class='col-md-8'>\
                            <a href='/"+ game.host.id +"'>\
                                <p>\
                                    <strong>"+ game.host.name +"</strong>\
                                </p>\
                            </a>\
                        </div>\
                    </div>",
                    balloonContent: "<div class='row'>\
                    <div class='col-md-12'>\
                        <h4>"+game.playground.address+"\
                        </h4>\
                        <h4>"+game.playground.name+"\
                        </h4>\
                        <h4>"+moment(game.game_date_time,'YYYY-MM-DDTHH:mm:ss').format('DD.MM.YYYY')+"\
                        </h4>\
                    </div>\
                    </div>",
                    balloonContentFooter: "<div class='row'>\
                        <div class='col-md-12'>\
                            <a href='/games/"+game.id+"' class='btn btn-default pull-right'><span class='glyphicon glyphicon-eye-open'>Смотреть</span></a>\
                        </div>\
                    </div>"
                  },{
                    preset: 'islands#dotIcon', 
                    iconColor: getRandomColor()
                });
          game_placemark.events.add('click', function(e){
            placemark = e.get('target')
            coords_ary = placemark.geometry.getCoordinates();
            $placemark_box = $("[data-lat='"+coords_ary[0]+"']").parents().closest('.ibox-content')
            $placemark_box.effect("highlight", {}, 3000);

            $('body').animate({
              scrollTop: $placemark_box.offset().top
            }, 300);
          })
          return game_placemark;
  }

  function create_team_game_placemark(game){
        var lat = game.playground.latitude,
            lng = game.playground.longitude,
            game_placemark;

         game_placemark = new ymaps.Placemark([lat,lng], {
                    id: game.id,
                    balloonContentHeader: "<div class='row'>\
                        <div class='col-md-4'>\
                            <a href='/"+ game.host.id +"'>\
                                <img src='"+ game.host.avatar +"' class='img-circle' style='width: 50px;'>\
                            </a>\
                        </div>\
                        <div class='col-md-8'>\
                            <a href='/"+ game.host.id +"'>\
                                <p>\
                                    <strong>"+ game.host.name +"</strong>\
                                </p>\
                            </a>\
                        </div>\
                    </div>",
                    balloonContent: "<div class='row'>\
                    <div class='col-md-12'>\
                        <h4>"+game.playground.address+"\
                        </h4>\
                        <h4>"+game.playground.name+"\
                        </h4>\
                        <h4>"+moment(game.game_date_time,'YYYY-MM-DDTHH:mm:ss').format('DD.MM.YYYY')+"\
                        </h4>\
                        <div class='col-md-12'>\
                        <div class='row'>\
                            <div class='col-md-6'>\
                                <div class='row'>\
                                    <div class='col-md-8'>\
                                        <span>"+ game.host_team.name +"</span>\
                                    </div>\
                                    <div class='col-md-4'>\
                                        <img src='"+ game.host_team.logo +"' class='img-circle' style='width: 50px;'>\
                                    </div>\
                                </div>\
                            </div>\
                            <div class='col-md-6'>\
                                <div class='row'>\
                                    <div class='col-md-4'>\
                                        <img src='"+ game.visitor_team.logo +"' class='img-circle' style='width: 50px;'>\
                                    </div>\
                                    <div class='col-md-8'>\
                                        <span>"+ game.visitor_team.name +"</span>\
                                    </div>\
                                </div>\
                            </div>\
                        </div>\
                        </div>\
                    </div>\
                    </div>",
                    balloonContentFooter: "<div class='row'>\
                        <div class='col-md-12'>\
                            <a href='/games/"+game.id+"' class='btn btn-default pull-right'><span class='glyphicon glyphicon-eye-open'>Смотреть</span></a>\
                        </div>\
                    </div>"
                  },{
                    preset: 'islands#dotIcon', 
                    iconColor: getRandomColor()
                });
          game_placemark.events.add('click', function(e){
            placemark = e.get('target')
            coords_ary = placemark.geometry.getCoordinates();
            $placemark_box = $("[data-lat='"+coords_ary[0]+"']").parents().closest('.ibox-content')
            $placemark_box.effect("highlight", {}, 3000);

            $('body').animate({
              scrollTop: $placemark_box.offset().top
            }, 300);
          })
          return game_placemark;
  }
  
  
  function setPlacemarksFromPage(){

  var gamesCollection = new ymaps.GeoObjectCollection()

  $('[data-game]').map(function(){

    game = $(this).data('game')
    
    if (game.individual == true) {
            gamesCollection.add(create_game_placemark(game))
          } else  {
            gamesCollection.add(create_team_game_placemark(game))
          };

  });

  refill(myMap,gamesCollection);
  objects = gamesCollection;

  };

  function clickGoto(elem) {
        e = $(elem).closest('a')
        console.log(e)

        var lat = $(e).data('latitude');
        var lng = $(e).data('longitude');


        myMap.panTo([lat, lng], {
            flying: false,
            duration: 200
        })
        ymaps.geoQuery(objects).getClosestTo([lat, lng]).balloon.open();
        // myMap.setZoom(16, {duration: 100});

        return false;
    }

 $(window).resize(function(){
   new_width = $(this).width()
   $('#map').width(new_width*1.6);

   myMap.controls.remove('zoomControl')
   myMap.controls.remove('typeSelector')
   myMap.controls
    .add('zoomControl', {
      float: 'right',
      position: {
        top: 100,
        left: new_width - 40
      }
    })
    .add("typeSelector", {
      float: 'right',      
      position:{
        top: 60,
        left: new_width - 40
      }
    });
  });
});
