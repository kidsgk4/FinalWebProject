<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
	<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/paho-mqtt-min.js"></script>
	<script type="text/javascript"
		src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" type="text/css"
		href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
	<script type="text/javascript"
		src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
	<link href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css" rel="stylesheet">
	<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="resources/css/droneManagement.css">
	
	<script type="text/javascript">
		
		function drone_info(){
			var url = 'delivery_Popup';
			window.open(url,"","width=800,height=700,right=300")
		}
		
		
	</script>
	
	<style type="text/css">
		.droneList tr:hover{
                background-color: chocolate;
            }
	</style>
</head>
<body>
	<jsp:include page = "../common/manageHeader.jsp"/>
	<div class="body">
		<div class="body_sub">
			<div class="left">
				<div class="drone_left">
					<div class="bor_title">
						<div class="subject">드론 현황</div>
					</div>
					<div class = "mail_list" style="border-bottom:1px solid #999;">
						<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
							<colgroup>
								<col width="100" /><col width="*" /><col width="100"/><col width="15">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">드론명</th>
									<th scope="col">상태</th>
									<th scope="col">배터리</th>
									<th scope="col"></th>
								</tr>
							</thead>
						</table>
						<div style="max-height:500px; width:100%; overflow-x:hidden; overflow-y:scroll;">
							<table cellspacing="0" border="1" class="frt_tbl_type" style="border-top:0px;">
							
								<colgroup>
									<col width="100" /><col width="*" /><col width="100" />
								</colgroup>
								<tbody id = "droneList">		
									<c:forEach items="${droneList}" var="drone">										
										<tr id="${drone.drone_id},${drone.state_id}" onclick="drone_click(id)" style="cursor: pointer;">
											<td class="num">${drone.drone_id}</td>
											<td class="title">${drone.stateList.get(0).state_name}</td>
											<td class="title">100%</td> 
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="dron_left_down">
					
				</div>
			</div>
				<div class="drone_center">
					<div class="bor_title">
						<div class="subject">드론 현재 위치</div>
					</div>
					<div class = "mail_list" style="border-bottom:1px solid #999;">
						<div id="map" style="width:100%;height:500px;">
						
						</div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05852697430c6a36aa2521201b5d17b6">
					</script>
					<script type="text/javascript">
						var path_X = [];
						var path_Y = [];
						
						function drone_click(id){
							var sp = id.split(',');
							var drone_id = sp[0];
							var state_id = sp[1];
							$.ajax({
								url:'droneState?drone_id='+drone_id+'&state_id='+state_id,
								success:function(data){
									$('.dron_left_down').html(data);
								}
							});
							
							$.ajax({
								url:'droneLog?drone_id='+drone_id,
								success:function(data){
									$('.drone_right').html(data);
								}
							});
							
							
							$.ajax({
								url:'selectDroneDeliveryState?drone_id='+drone_id+'&state_id='+state_id,
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
									    var imageSize = new kakao.maps.Size(24, 35); 
									    
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
									    strokeWeight: 5, // 선의 두께 입니다
									    strokeColor: '#FFAE00', // 선의 색깔입니다
									    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
									    strokeStyle: 'solid' // 선의 스타일입니다
									});
									
									polyline.setMap(map);
									
									var total_length = Math.floor(polyline.getLength());
									$('#total_length').text(total_length+'m'); 
									
								}		
							});
						}
					
					
						var container = document.getElementById('map');
					    var options = {
					       center: new kakao.maps.LatLng(37.5475225, 127.119988),
					       level: 2
					    };
					
					    var map = new kakao.maps.Map(container, options); 
					   
					    var marker = null;
				          
					  	
				          
					    //mqtt broker와 연결
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
					          
					         
					          
						      // 마커가 표시될 위치입니다 
					          markerPosition  = new kakao.maps.LatLng(currLat, currLng); 
						
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
						          
					          $('#currLat').text(currLat);
					          $('#currLng').text(currLng);
					          $('#alt').text(alt+'m');
					          
					          
					         
					       }   
					          
					       if(obj.msgid == "ATTITUDE") {
					          var roll = obj.roll;
					          var pitch = obj.pitch;
					          var yaw = obj.yaw
					          
					          $('#roll').text(roll);
					          $('#pitch').text(pitch);
					       }
					       if(obj.msgid == "VFR_HUD"){
					          var groundSpeed = obj.groundSpeed;
					          $("#speed").text(groundSpeed+'m/s');
					         	console.log(groundSpeed);	
					          //예상 시간 구하기
					          var len = parseFloat($('#total_length').text());
					          var speed = parseFloat(groundSpeed);
					          
					          
					          console.log('len :' + len);
					          console.log('speed :' + speed);
					         
					          if(groundSpeed == 0){
					        	  $('#expectancy_time').text('속력 측정 불가');
					        	  $('#expectancy_time').css('color','red');
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
						          $('#expectancy_time').text(minutes+'분'+seconds+'초');
						         // $('#expectancy_time').text('예상 시간 ' + finalCho);
						          $('#expectancy_time').css('color','black');
					          }
					          
					       }
					       if(obj.msgid == "SYS_STATUS"){
					          var battery = obj.batteryRemaining;
					          $("#battery").text(battery+'%');
					       }
					       
					       if(obj.msgid == "HEARTBEAT"){
					          var arm = obj.arm;
					          if(arm == true){
					             $("#arm").text('정상');
					          }else if(arm == false){
					             $("#arm").text('시동 꺼짐');
					          }
					       }
					    }
					    
					    
					</script>		
							
						
							
					</div>
				</div>
				<div class="drone_right">
					
				</div>
		</div>
	</div>
</body>
</html>