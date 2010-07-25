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
				var first = questions[0].question;
        map.drawZoomAndCenter(new YGeoPoint(first.latitude, first.longitude), 11);  
          // Add an event to report to our Logger

        function createMarker(question){  
          //var mapCoordCenter = map.convertLatLonXY(map.getCenterLatLon());  
          currentGeoPoint = new YGeoPoint(question.latitude, question.longitude);
          var newMarker= new YMarker(currentGeoPoint);  
          // newMarker.addAutoExpand("Add a Label to a Marker for this Effect");  
					var markerMarkup = "<span class='question'><b>"+ question.text  +"</b> <input type='text' class='answer'><a class='submit'>submit</a></span>";  
					newMarker.openSmartWindow(markerMarkup);
					return newMarker;
				}  
    
        function placeMarker(map, newMarker){
					// YEvent.Capture(newMarker, EventsList.MouseClick, function(){ newMarker.openSmartWindow(markerMarkup); });
          map.addOverlay(newMarker);
					var context = "#" + newMarker.id;
					$(context + " .answer").click(function(){console.log( $(context + " input").focus());})
          $(context + " .submit").click(function(){console.log( $(context + " input").val());});
					displayPolyLines(newMarker.YGeoPoint);
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
				
				
				var markers = $.map(questions, function(question, i){
					return createMarker(map, question.question, question.question);
				}); 

				$.each(markers, function(i, marker){
					placeMarker(map, marker);
				});     
      }