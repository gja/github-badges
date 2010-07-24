     // Create a Map that will be placed in the "map" div.  
      var map = new YMap(document.getElementById('map'));   
      // Create an array to contain the points of our polyline  
      polylinePoints = [];  
      function startMap(){  
          // Add the ability to change between Sat, Hybrid, and Regular Maps  
          map.addTypeControl();     
          // Add the zoom control. Long specifies a Slider versus a "+" and "-" zoom control  
          map.addZoomLong();            
          // Add the Pan control to have North, South, East and West directional control  
          map.addPanControl();    
          // Specifying the Map starting location and zoom level  
          map.drawZoomAndCenter("San Francisco", 3);  
          // Add an event to report to our Logger  
          YEvent.Capture(map, EventsList.MouseClick, myCallback);  
    
          function myCallback(_e, _c){  
              /*   
                 It is optional to specify the location of the Logger.   
                 Do so by sending a YCoordPoint to the initPos function.  
               */  
              var mapCoordCenter = map.convertLatLonXY(map.getCenterLatLon());  
              currentGeoPoint = new YGeoPoint( _c.Lat, _c.Lon);  
              placeMarker(currentGeoPoint);  
              displayPolyLines(currentGeoPoint);    
          }  
    
          function placeMarker(geoPoint){  
            var newMarker= new YMarker(geoPoint);  
            // newMarker.addAutoExpand("Add a Label to a Marker for this Effect");  
            newMarker.addLabel("Foo Woo boo");  
						var markerMarkup = "<span class='question'><b>You can add markup this?</b> <input type='text' class='answer'><a class='submit'>submit</a></span>";  
						newMarker.openSmartWindow(markerMarkup);
						// YEvent.Capture(newMarker, EventsList.MouseClick, function(){ newMarker.openSmartWindow(markerMarkup); });
            map.addOverlay(newMarker);
						var context = "#" + newMarker.id;
						$(context + " .answer").click(function(){console.log( $(context + " input").focus());})
            $(context + " .submit").click(function(){console.log( $(context + " input").val());});
          }  
    
          function displayPolyLines(g_point){  
              polylinePoints.push(g_point);  
              if (canDisplayPolyLines){  
                  map.addOverlay(new YPolyline(polylinePoints, 'black',7,0.7));  
              }  
          }  
    
          this.canDisplayPolyLines = function() {  
              // Check to make sure we have at least 2 points to connect  
              return (polylinePoints.length > 1);  
          }  
      }