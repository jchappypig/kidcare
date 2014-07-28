$(function() {
  if($('#map').length !== 0) {
    var handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
      var markers = handler.addMarkers([
        {
          "lat": -33.969736,
          "lng": 151.127809,
          "infowindow": "Little Start Early Learning Centre"
        }
      ]);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setZoom(16);
    });
  }
});
