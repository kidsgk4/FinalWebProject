<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/paho-mqtt-min.js"></script>
<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/jquery-3.4.1.min.js"></script>
<style type="text/css">
	#map{
		width : 100%;
		height : 400px;
		background-color : grey;
	}
</style>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDk-2Ib9S8b23dAzsXgw_Z4rq3IbPZcDzM&callback=initMap"></script>
<script type="text/javascript">
	//mqtt broker와 연결
	$(function() {
		//MQTT Broker와 연결하기
		client = new Paho.MQTT.Client(location.hostname, 61614, "clientId"); //location.hostname: 자동으로 호스트네임 가져옴
		client.onMessageArrived = onMessageArrived;
		client.connect({onSuccess:onConnect});
	});
	
	//연결이 완료되었을 때 자동으로 실행(콜백)되는 함수
	function onConnect() {
		console.log("Connect");
		client.subscribe("/drone/fc/pub");
	}
	
	var currLat = 0;
	var currLng = 0;
	
	//메시지를 수신했을 때 자동으로 실행(콜백)되는 함수
	function onMessageArrived(message) {
		var json = message.payloadString;
		var obj = JSON.parse(json);
		if(obj.msgid=="GLOBAL_POSITION_INT") {
			currLat = obj.currLat;
			currLng = obj.currLng;
		}	
	}
	
	function initMap(){
		var location = {lat:currLat, lng:currLng};
		var map = new google.maps.Map(document.getElementById('map'),{
			zoom:18,
			center:location
		});
		var marker = new google.maps.Marker({
			position : location,
			map : map
		});
	}
	
</script>
</head>
<body>
	<div id = "map"></div>
	<div id = "lat"></div>
	<div id = "lng"></div>
</body>
</html>