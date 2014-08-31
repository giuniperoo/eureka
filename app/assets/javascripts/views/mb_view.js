App.MbView = Em.View.extend({
  supports: function(bool, suffix) {
    var s = "Your browser ";
    if (bool) {
      s += "supports " + suffix + ".";
    } else {
      s += "does not support " + suffix + ". :(";
    }
    return s;
  },

  lookupLocation: function() {
    geoPosition.getCurrentPosition(this.showMap, this.showMapError);
  },

  showMap: function(loc) {
    L.mapbox.accessToken = 'pk.eyJ1IjoiZ2l1bmlwZXJvbyIsImEiOiJ5QldHbVlvIn0.gBOtqy71Pjhf2gwVsTnP9A';

    var map = L.mapbox.map('map', 'examples.map-i86l3621')
      .setView([loc.coords.latitude, loc.coords.longitude], 15);

    var marker = new L.Marker(new L.LatLng(loc.coords.latitude, loc.coords.longitude))
      .bindPopup('You are here (more or less)');

    map.addLayer(marker);
  },

  showMapError: function() {
    $("#live-geolocation").html('Unable to determine your location.');
  },

  click: function (evt) {
    evt.preventDefault();
    if ($(evt.target).is('#look-up-location')) {
      this.lookupLocation();
    }
  },

  didInsertElement: function () {
    if (geoPosition.init()) {
      $("#live-geolocation").html(this.supports(true, 'geolocation') + ' <a href="#" id="look-up-location">Click to look up your location</a>.');
    } else {
      $("#live-geolocation").html(this.supports(false, "geolocation"));
    }
  }
});
