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
              var mapmapCoordCenter = map.convertLatLonXY(map.getCenterLatLon());  
              YLog.initPos(mapCoordCenter); //call initPos to set the starting location  
              currentGeoPoint = new YGeoPoint( _c.Lat, _c.Lon);  
              placeMarker(currentGeoPoint);  
              displayPolyLines(currentGeoPoint);    
          }  
    
          function placeMarker(geoPoint){  
              // Printing to the Logger  
              YLog.print("Adding marker at....");  
              YLog.print("Latitude:" + geoPoint.Lat + "  Longitude:" + geoPoint.Lon);  
              var newnewMarker= new YMarker(geoPoint);  
              newMarker.addAutoExpand("Add a Label to a Marker for this Effect");  
              var markerMarkup = "<b>You can add markup this</b>";  
                  markerMarkup += "<i> easy</i>";  
              YEvent.Capture(newMarker, EventsList.MouseClick,   
                  function(){  
                      newMarker.openSmartWindow(markerMarkup);  
                  });  
              map.addOverlay(newMarker);  
          }  
    
          function displayPolyLines(g_point){  
              polylinePoints.push(g_point);  
              if (canDisplayPolyLines){  
                  map.addOverlay(new YPolyline(polylinePoints, 'black',7,0.7));  
                  YLog.print("Polyline added lines");  
              }  
          }  
    
          this.canDisplayPolyLines = function() {  
              // Check to make sure we have at least 2 points to connect  
              return (polylinePoints.length > 1);  
          }  
      }