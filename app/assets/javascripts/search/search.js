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
      float: 'none',
      position: {
        top: 100,
        right: 10
      }
    })
    .add("typeSelector", {
        float: "right"
    });
    
    $(document).on('click','a.show-game-on-map-btn',function(e){
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

  function create_game_block(game){
      var result = "";
      console.log(game)
      result += "\
      <div class='ibox-content'>\
        <div class='row'>\
            <div class=' col-md-1 col-lg-1 col-sm-1 col-xs-1'>\
                "+moment(game.game_date_time,'YYYY-MM-DDTHH:mm:SS.sssZ').format('DD.MM.YYYY')+"\
            </div>\
            <div class=' col-md-1 col-lg-1 col-sm-1 col-xs-1'>\
                "+game.type.name+"\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
              <a href='/"+game.host.id+"'><img class='img img-circle' src='"+game.host.avatar+"' style='width: 50px;'/><div>"+game.host.name+"</div></a>\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
              <a href='/playgrounds/"+game.playground.id+"'>"+game.playground.name+"</a>\
              <div class='hidden' data-lat='"+game.playground.latitude+"' data-lng='"+game.playground.longitude+"'></div>\
            </div>\
            <div class=' col-md-4 col-lg-4 col-sm-4 col-xs-4'>\
                "+players_images_line(game.players)+"\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
            <a href='#' class='btn btn-default btn-block show-game-on-map-btn' data-latitude='"+game.playground.latitude+"' data-longitude='"+game.playground.longitude+"'><span class='glyphicon glyphicon-map-marker'></span>На карте</a>\
            <a href='/games/"+game.id+"' class='btn btn-default btn-block'><span class='glyphicon glyphicon-eye-open'></span>Смотреть</a>\
            </div>\
          </div>\
      </div>"

      return result
  }

  function create_team_game_block(game){
      var result = "";

      result += "\
      <div class='ibox-content'>\
        <div class='row'>\
            <div class=' col-md-1 col-lg-1 col-sm-1 col-xs-1'>\
                "+moment(game.game_date_time,'YYYY-MM-DDTHH:mm:SS.sssZ').format('DD.MM.YYYY')+"\
            </div>\
            <div class=' col-md-1 col-lg-1 col-sm-1 col-xs-1'>\
                "+game.type.name+"\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
              <a href='/"+game.host.id+"'><img class='img img-circle' src='"+game.host.avatar+"' style='width: 50px;'/><div>"+game.host.name+"</div></a>\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
              <a href='/playgrounds/"+game.playground.id+"'>"+game.playground.name+"</a>\
              <div class='hidden' data-lat='"+game.playground.latitude+"' data-lng='"+game.playground.longitude+"'></div>\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
                "+game.host_team.name+"\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
                "+game.visitor_team.name+"\
            </div>\
            <div class=' col-md-2 col-lg-2 col-sm-2 col-xs-2'>\
            <a href='#' class='btn btn-default btn-block show-game-on-map-btn' data-latitude='"+game.playground.latitude+"' data-longitude='"+game.playground.longitude+"'><span class='glyphicon glyphicon-map-marker'></span>На карте</a>\
            <a href='/games/"+game.id+"' class='btn btn-default btn-block'><span class='glyphicon glyphicon-eye-open'></span>Смотреть</a>\
            </div>\
          </div>\
      </div>"

      return result
  }

  function create_game_placemark(game){
        var lat = game.playground.latitude,
            lng = game.playground.longitude,
            game_placemark;

         game_placemark = new ymaps.Placemark([lat,lng], {
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
                        <h4>"+moment(game.game_date_time,'YYYY-MM-DDTHH:mm:SS.sssZ').format('DD.MM.YYYY')+"\
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
                        <h4>"+moment(game.game_date_time,'YYYY-MM-DDTHH:mm:SS.sssZ').format('DD.MM.YYYY')+"\
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

  function resultsHeader(){
    return ("\
<div class='ibox-content'>\
<div class='row'>\
  <div class='col-md-1 col-lg-1 col-sm-1 col-xs-1'>Дата</div>\
  <div class='col-md-1 col-lg-1 col-sm-1 col-xs-1'>Спорт</div>\
  <div class='col-md-2 col-lg-2 col-sm-2 col-xs-2'>Создатель</div>\
  <div class='col-md-2 col-lg-2 col-sm-2 col-xs-2'>Площадка</div>\
  <div class='col-md-4 col-lg-4 col-sm-4 col-xs-4'>Состав</div>\
  <div class='col-md-2 col-lg-2 col-sm-2 col-xs-2'>Действия</div>\
</div>\
</div>");
  }
  
  $(document).on('ajax:success','#search-form',function(e, data, status, xhr){
    // $('#results_table > tbody > tr:not(:first-child)').remove();
    // $('#results_table > tbody').append(xhr.responseText);
      var gamesCollection = new ymaps.GeoObjectCollection(),
          gamesRows = [],
          games = JSON.parse(xhr.responseText);
      

        games.map(function(game){
          if (game.individual == true) {
          gamesCollection.add(create_game_placemark(game))
          gamesRows.push(create_game_block(game));
          } else  {
            gamesCollection.add(create_team_game_placemark(game))
            gamesRows.push(create_team_game_block(game));
          };

        });

      console.log(games.length);
      if (games.length == 0) {
        $('#results .ibox-content').remove()
        $('#results .ibox').append("<div class='ibox-content'><div class='center-text'><p>К сожалению, игр не найдено.</p></div></div>");
      } else {
      refill(myMap,gamesCollection);
      objects = gamesCollection;
      $('#results .ibox-content').remove()
      $('#results .ibox').append(resultsHeader());
      $('#results .ibox').append(gamesRows.join(''));
      };
  })

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
   $('#map').width($(this).width()*1.6);
  });
});