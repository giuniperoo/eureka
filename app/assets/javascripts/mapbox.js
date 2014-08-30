
$( document ).ready(function() {
  // Replace this accessToken with you own.
  L.mapbox.accessToken = 'pk.eyJ1IjoidHJpc3RlbiIsImEiOiJuZ2E5MG5BIn0.39lpfFC5Nxyqck1qbTNquQ';
  // Replace 'examples.map-i80bb8p3' with your own Map ID
  var map = L.mapbox.map('map', 'examples.map-i80bb8p3')
        .setView([38.909671288923, -77.034084142948], 16);

  var listings = document.getElementById('listings');
  var locations = L.mapbox.featureLayer().addTo(map);

  locations.loadURL('sweetgreen.geojson');

  function setActive(el) {
    var siblings = listings.getElementsByTagName('div');
    for (var i = 0; i < siblings.length; i++) {
      siblings[i].className = siblings[i].className
        .replace(/active/, '').replace(/\s\s*$/, '');
    }

    el.className += ' active';
  }

  locations.on('ready', function() {
    locations.eachLayer(function(locale) {

      // Shorten locale.feature.properties to just `prop` so we're not
      // writing this long form over and over again.
      var prop = locale.feature.properties;

      // Each marker on the map.
      var popup = '<h3>Sweetgreen</h3><div>' + prop.address;

      var listing = listings.appendChild(document.createElement('div'));
          listing.className = 'item';

      var link = listing.appendChild(document.createElement('a'));
          link.href = '#';
          link.className = 'title';

      link.innerHTML = prop.address;
      if (prop.crossStreet) {
        link.innerHTML += '<br /><small class="quiet">' + prop.crossStreet + '</small>';
        popup += '<br /><small class="quiet">' + prop.crossStreet + '</small>';
      }

      var details = listing.appendChild(document.createElement('div'));
      details.innerHTML = prop.city;
      if (prop.phone) {
        details.innerHTML += ' &middot; ' + prop.phoneFormatted;
      }

      link.onclick = function() {
        setActive(listing);

        // When a menu item is clicked, animate the map to center
        // its associated locale and open its popup.
        map.setView(locale.getLatLng(), 16);
        locale.openPopup();
        return false;
      };

      // Marker interaction
      locale.on('click', function(e) {
          // 1. center the map on the selected marker.
          map.panTo(locale.getLatLng());

          // 2. Set active the markers associated listing.
          setActive(listing);
      });

      popup += '</div>';
      locale.bindPopup(popup);
    });
  });

  locations.on('layeradd', function(e) {
    var marker = e.layer;
    marker.setIcon(L.icon({
      iconUrl: 'marker.png',
      iconSize: [56, 56],
      iconAnchor: [28, 28],
      popupAnchor: [0, -34]
    }));
  });
});