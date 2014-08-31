App.BlahView = Em.View.extend({
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
    // Create an array of styles.
    var styles = [
      {
        stylers: [
          { hue: "#00ffe6" },
          { saturation: -20 }
        ]
      },{
        featureType: "road",
        elementType: "geometry",
        stylers: [
          { lightness: 100 },
          { visibility: "simplified" }
        ]
      },{
        featureType: "road",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      }
    ];

    // Create a new StyledMapType object, passing it the array of styles,
    // as well as the name to be displayed on the map type control.
    var styledMap = new google.maps.StyledMapType(styles, {name: 'Styled Map'});

    var center = new google.maps.LatLng(loc.coords.latitude, loc.coords.longitude);

    // Create a map object, and include the MapTypeId to add
    // to the map type control.
    var mapOptions = {
      zoom: 15,
      center: center,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
      }
    };

    var map = new google.maps.Map(document.getElementById('map'), mapOptions);

    //Associate the styled map with the MapTypeId and set it to display.
    map.mapTypes.set('map_style', styledMap);
    map.setMapTypeId('map_style');

    var marker = new google.maps.Marker({map: map, position: center, draggable: false, title: 'You are here (more or less)'});
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
