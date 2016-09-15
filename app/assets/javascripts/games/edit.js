$(document).ready(function(){
  
    function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
    }

  ymaps.ready(init);

  function init () {
    var playgroundsMap = new ymaps.Map('map', {
        center: [55.753559, 37.609218],
        zoom: 16,
        controls: []
    }, {
        searchControlProvider: 'yandex#search'
    });

    playgroundsMap.controls
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
    
    playgroundsMap.geoObjects.add(loadingObjectManager)

    function onObjectEvent (e) {
        var obj = e.get('target');
        var objectId = e.get('objectId')
        $('#game_playground_id').val(objectId)
      }

// Назначаем обработчик событий для коллекции объектов менеджера.   
    loadingObjectManager.objects.events.add(['click'], onObjectEvent);

  };

      $('#datepicker').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        "startDate": moment().format('MM/DD/YYYY'),
        "endDate": moment().add(1,'year').format('MM/DD/YYYY')
      }); 


      $('#timepicker').timepicker();
      $('#timepicker').timepicker('setTime', '00:00');
      $('#timepicker').timepicker('option','timeFormat', 'H:i');

      $('.datetime-input').on('change',function(){
        currentDate = moment($('#datepicker').val(),'MM/DD/YYYY').format('YYYY-MM-DD');
        currentTime = $('#timepicker').val();

        dateAndTime = currentDate + 'T' + currentTime;
        $('#game_date_time').val(dateAndTime);
        console.log(dateAndTime);
      })

});