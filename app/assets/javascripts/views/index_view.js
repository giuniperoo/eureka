App.IndexView = Em.View.extend({
  showMap: function(loc) {
    var map = new L.Map('map', {
          center: new L.LatLng(loc.coords.latitude, loc.coords.longitude + 0.009),
          zoom: 16,
          minZoom: 12
        }),
        layer = new L.StamenTileLayer('watercolor'),
        marker = new L.Marker(new L.LatLng(loc.coords.latitude, loc.coords.longitude))
            .bindPopup('You are here (more or less)'),

        finishLoading = function() {
          loader = $('.loader');
          loader.fadeOut();
        };

    map.addLayer(layer);
    map.addLayer(marker);
    layer.on('load', finishLoading);
  },

  showMapError: function() {
    this.finishLoading();
    $('#live-geolocation').html('Unable to determine your location.');
  },

  startLoading: function() {
    loader = $('.loader');
    loader.fadeIn();
  },

  finishLoading: function() {
    loader = $('.loader');
    loader.fadeOut();
  },

  didInsertElement: function () {
    this.startLoading();

    if (geoPosition.init()) {
      geoPosition.getCurrentPosition(this.showMap, this.showMapError);
    } else {
      this.finishLoading();
      $('#live-geolocation').html('Your browser does not support geolocation. :(');
    }
  }
});
