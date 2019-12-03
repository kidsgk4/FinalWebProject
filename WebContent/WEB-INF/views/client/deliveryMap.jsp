<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;width: 183px;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>

<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/paho-mqtt-min.js"></script>
<script type="text/javascript"
		src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
</head>
<body>
	<input type="hidden" id="dis" value="">
	<div id="map2" style="width: 750px; height: 500px;"></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05852697430c6a36aa2521201b5d17b6">
		</script>

	<script type="text/javascript">
			var mapContainer = document.getElementById('map2'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
	
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
			var marker = null;
			var customOverlay = null;
			
			var path_X = [];
			var path_Y = [];

			$.ajax({
				url:'villageSendPath',
				success:function(data){
	
					x = data.x;
					y = data.y;

					for(var i = 0; i < x.length; i++){
						path_X.push(x[i]);
					}
					for(var i = 0; i < y.length; i++){
						path_Y.push(y[i]);
					}
					
					for(var i = 0; i < path_Y.length; i++){
						console.log(path_Y[i]);
					}
					
					var positions = [];
					
				    for(var i = 0; i < path_X.length; i++){
				    	positions.push({
					        latlng: new kakao.maps.LatLng(path_X[i], path_Y[i])
					    })
				    }
				    
					console.log(positions);
					var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
				    
					for (var i = 0; i < positions.length; i ++) {
					    
					    // 마커 이미지의 이미지 크기 입니다
					    var imageSize = new kakao.maps.Size(0, 0); 
					    
					    // 마커 이미지를 생성합니다    
					    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
					    var markerPosition = null;
					    // 마커를 생성합니다
					    var marker = new kakao.maps.Marker({
					        map: map, // 마커를 표시할 지도
					        position: positions[i].latlng, // 마커를 표시할 위치
					        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
					        image : markerImage // 마커 이미지 
					    });
					}
					var linePath = [];
					
					for(var i = 0; i < path_X.length; i++){
						linePath.push(new kakao.maps.LatLng(path_X[i], path_Y[i]))
				    }
					
			          
					var polyline = new kakao.maps.Polyline({
					    path: linePath, // 선을 구성하는 좌표배열 입니다
					    strokeWeight: 1, // 선의 두께 입니다
					    strokeColor: '#FFAE00', // 선의 색깔입니다
					    strokeOpacity: 0, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					    strokeStyle: 'solid' // 선의 스타일입니다
					});
					
					polyline.setMap(map);
					
					var total_length = Math.floor(polyline.getLength());
					$('#dis').val(total_length+'m'); 
					
				}		
			});

			
		 $(function() {
	       //MQTT Broker와 연결하기
	       client = new Paho.MQTT.Client("106.253.56.124", 61623, "clientId"+new Date().getTime()); //location.hostname: 자동으로 호스트네임 가져옴
	       client.onMessageArrived = onMessageArrived;
	       client.connect({onSuccess:onConnect});
	    });
		 
		//연결이 완료되었을 때 자동으로 실행(콜백)되는 함수
		    function onConnect() {
		       console.log("Connect");
		       client.subscribe("/drone/fc/pub");
		    }
		    
		    
		    //메시지를 수신했을 때 자동으로 실행(콜백)되는 함수
		    function onMessageArrived(message) {
		       var json = message.payloadString;
				console.log(json);
		       var obj = JSON.parse(json);
		      
		       if(obj.msgid=="GLOBAL_POSITION_INT") {
			          var currLat = obj.currLat;
			          var currLng = obj.currLng;
			          var alt = obj.alt;
						
			          
			          //var markerPosition = new kakao.maps.LatLng(currLat, currLng); // 마커가 표시될 위치입니다 
			          var markerPosition = new kakao.maps.LatLng(currLat, currLng);
					  
			          
			          var imageSrc = './resources/box.png', // 마커이미지의 주소입니다    
					    imageSize = new kakao.maps.Size(34, 35), // 마커이미지의 크기입니다
					    imageOption = {offset: new kakao.maps.Point(15, 10)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
					      
					    
						// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
						   
						
			         
			          if(marker != null) {
			              marker.setMap(null);
			              marker.setPosition(markerPosition);
			           } else {
			          	// 마커를 생성합니다
			   			marker = new kakao.maps.Marker({
			   			    position: markerPosition, 
			   			    image: markerImage // 마커이미지 설정 
			   			});
		
			           }
			          
			          
			          // 마커가 지도 위에 표시되도록 설정합니다
			          marker.setMap(map);
			          map.setCenter(markerPosition);
			          
			          
			          //var total_length = Math.floor(polyline.getLength());
						//$('#distance').text('남은 거리 ' + total_length+'m'); 
						
						
				      // 커스텀 오버레이에 표시할 내용입니다     
				      // HTML 문자열 또는 Dom Element 입니다 
				      var content = '<div class="customoverlay">' +
			   		   '    <a href="">' +
			          '    <span class="title" id="time"></span>' +
			          '    <span class="" id="distance">'+$('#dis').val()+'</span>' +
			          '    <a>' +
			          '</div>';
	
				      // 커스텀 오버레이가 표시될 위치입니다 
				      var position = new kakao.maps.LatLng(currLat, currLng);  
	
				      
				      if(customOverlay != null) {
				    	  customOverlay.setMap(null);
				    	  customOverlay.setPosition(position);
			           } else {
			        	// 커스텀 오버레이를 생성합니다
						      customOverlay = new kakao.maps.CustomOverlay({
						          position: position,
						          content: content,
						          xAnchor: 0.5,
						       	  yAnchor: 0
						      });
			           }
				      
				      
	
				      // 커스텀 오버레이를 지도에 표시합니다
				      customOverlay.setMap(map);
				          
			
			  		 
			              
			     }
		       
		       if(obj.msgid == "VFR_HUD"){
			          var groundSpeed = obj.groundSpeed;
			          $("#speed").text(groundSpeed+'m/s');
			         	console.log(groundSpeed);	
			          //예상 시간 구하기
			          var len = parseFloat($('#distance').text());
			          var speed = parseFloat(groundSpeed);
			          
			          
			          console.log('len :' + len);
			          console.log('speed :' + speed);
			         
			          if(groundSpeed == 0){
			        	  $('#time').text('속력 측정 불가');
			        	  $('#time').css('color','red');
			          } else {
				          //var expectancy_time = (len/speed)/60;
				          var expectancy_time = len/speed;
				          var MathFloor = Math.floor(expectancy_time);
				          
				          var myNum = MathFloor;
					      var hours   = Math.floor(myNum / 3600);
					      var minutes = Math.floor((myNum - (hours * 3600)) / 60);
					      var seconds = myNum - (hours * 3600) - (minutes * 60);

					      if (hours   < 10) {hours   = "0"+hours;}
					      if (minutes < 10) {minutes = "0"+minutes;}
					      if (seconds < 10) {seconds = "0"+seconds;}
						    
						    
				          //var cho = expectancy_time - MathFloor;
				          //var banalo = cho.toFixed(2);
				          //var finalCho = banalo*100;
				          
				          //var finalCho = Math.Floor.toHHMMSS();
				          $('#time').text('남은 시간 : ' + minutes+'분'+seconds+'초');
				         // $('#expectancy_time').text('예상 시간 ' + finalCho);
				          $('#time').css('color','black');
			          }
			          
			       }
		       	
		       }
		    
		       
		</script>
</body>
</html>