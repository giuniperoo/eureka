App.IndexView = Em.View.extend({
  showMap: function(position) {
    var map = new L.Map('map', {
          center: new L.LatLng(position.coords.latitude, position.coords.longitude),
          zoom: 16,
          zoomControl: false,
          attributionControl: false,
          minZoom: 12
        }),
        layer = new L.StamenTileLayer('toner'),
        marker = new L.Marker(new L.LatLng(position.coords.latitude, position.coords.longitude))
            .bindPopup('You are here (more or less)'),

        finishLoading = function() {
          $('.loader').fadeOut();

          $('.note').addClass('active');
          editor = new EpicEditor({
            theme: {
              base: '/base.css',
              preview: '/preview.css',
              editor: '/editor.css'
            },
            button: { fullscreen: false }
          }).load();
        };

    map.addLayer(layer);
    map.addLayer(marker);

    map.dragging.disable();
    map.touchZoom.disable();
    map.doubleClickZoom.disable();
    map.scrollWheelZoom.disable();

    // Calculate the offset
    var offset = map.getSize().x * 0.333;
    // Then move the map
    map.panBy(new L.Point(offset, 0), {animate: false});

    layer.on('load', finishLoading);
  },

  showMapError: function(positionError) {
    $('.loader').fadeOut();
    $('.geolocation').html('<span class="no-location">Unable to determine your location.');
    console.error('Unable to determine location: ' + positionError);

    $('.note').addClass('active');
    editor = new EpicEditor({
      theme: {
        base: '/base.css',
        preview: '/preview.css',
        editor: '/editor.css'
      },
      button: { fullscreen: false }
    }).load();
  },

  displayNote: function() {
    $('.note').addClass('active');
    editor = new EpicEditor({
      theme: {
        base: '/base.css',
        preview: '/preview.css',
        editor: '/editor.css'
      },
      button: { fullscreen: false }
    }).load();
  },

  didInsertElement: function () {
    $('.loader').fadeIn();
    if (geoPosition.init()) {
      geoPosition.getCurrentPosition(this.showMap, this.showMapError);
    } else {
      this.showMapError();
      this.displayNote();
    }
  }
});
