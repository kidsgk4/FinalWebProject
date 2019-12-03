<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/paho-mqtt-min.js"></script>
<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<div id="map" style="width:500px;height:400px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05852697430c6a36aa2521201b5d17b6">
</script>
<script>
		var container = document.getElementById('map');
		var options = {
		   center: new kakao.maps.LatLng(33.450701, 126.570667),
		   level: 3
		};
		
		var map = new kakao.maps.Map(container, options);
		
		var positions = [
		    {
		        latlng: newmaps2.jsp kakao.maps.LatLng(33.450705, 126.570677)
		    },
		    {
		        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
		    },
		    {
		        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
		    },
		    {
		        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
		    }
		];
		
		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		}
		console.log(positions);
		clickLine = new kakao.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [positions], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
          
		//mqtt broker와 연결
		$(function() {
			//MQTT Broker와 연결하기
			client = new Paho.MQTT.Client(location.hostname, 61623, "clientId"); //location.hostname: 자동으로 호스트네임 가져옴
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
			var obj = JSON.parse(json);
			if(obj.msgid=="GLOBAL_POSITION_INT") {
				var currLat = obj.currLat;
				var currLng = obj.currLng;
				
			}	
			if(obj.msgid == "MISSION_ITEMS"){
				var items = [];
				items.push(obj.items);
				console.log(items);
				
			}
		}
		
	
	</script>
</body>
</html>