$(function(){if(0!==$("#map").length){var n=Gmaps.build("Google");n.buildMap({provider:{},internal:{id:"map"}},function(){var a=n.addMarkers([{lat:-33.969736,lng:151.127809,infowindow:"Little Start Early Learning Centre"}]);n.bounds.extendWith(a),n.fitMapToBounds(),n.getMap().setZoom(16)})}});