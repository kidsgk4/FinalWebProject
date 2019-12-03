<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript"
		src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" type="text/css"
		href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
	<script type="text/javascript"
		src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
	<link href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css" rel="stylesheet">
	<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="resources/css/droneManagement.css">
	
	<style type="text/css">

		body {
			background:#17181B;
		}
		.frt_tbl_type td {
			font-size: 13px;
			color : #9e9595;
		}
		.frt_tbl_type th {
			font-size: 13px;
			background:#7d7d86;
		}
		.frt_tbl_type {
			border-top: 2px solid #1d32ca;
		}
		.drone{
			width: 100%;
			height: 230px;
			margin-top: 15px;
		}
		#droneList tr {
			cursor: pointer;
		}
		#droneList tr:hover{
            background-color: rgb(61, 104, 199);
        }
        #droneList tr:visited{
        	background-color: rgb(61, 104, 199);
        }
        .drone_log{
        	width: 100%;
		    margin-top: 35px;
		    max-height: 300px;
		    min-height: 100px;
        }
        .ok_button{
        	float: right;
        	margin-top:20px;
		    margin-right: 30px;
		    background: #F32C28;
		    border: 0;
		    color: white;
		    width: 65px;
		    font-size: 14px;
		    border-radius: 9px;
        }
	</style>
	
	<script type="text/javascript">

		$(function(){
			var len = $('input#hidden_state').length;
			for(var i = 0; i < len; i++){
				if($('input#hidden_state').eq(i).val() == 'sd001'){
					$('td#droneStateName').eq(i).css('color','green');
				}else if($('input#hidden_state').eq(i).val() == 'sd002'){
					$('td#droneStateName').eq(i).css('color','blue');
				}else if($('input#hidden_state').eq(i).val() == 'sd003'){
					$('td#droneStateName').eq(i).css('color','gray');
				}else if($('input#hidden_state').eq(i).val() == 'sd004'){
					$('td#droneStateName').eq(i).css('color','red');
				}else if($('input#hidden_state').eq(i).val() == 'sd005'){
					$('td#droneStateName').eq(i).css('color','yellow');
				}
			}
		})

		var package_id = ${package_id};

		
		function drone_click(data){
			var sp = data.split(',');
			var drone_id = sp[0];
			var state_id = sp[1];
			console.log(state_id);
			var len = ('tr#droneTr').length;
			var indexTr;
			
			for(var i = 0; i < len; i++){
				if($('tr td#droneId').eq(i).text() == drone_id){
					var indexTr = i;
				}
			}
			
			$('tr.droneTr').css('background','none');
			$('tr.droneTr').eq(indexTr).css('background','rgb(61, 104, 199)');
			
			if(state_id == 'sd001'){
				$('#ok').prop('disabled',false);
				$('#ok').css('background','#F32C28');
			}else{
				$('#ok').prop('disabled',true);
				$('#ok').css('background','#ffc3c1');
			}
			
			$.ajax({
				url:'delivery_Popup_Ajax?drone_id='+drone_id,
				success:function(data){
					$('#droneLog').html(data);
				}
			});
			
			$('#ok').attr('value',drone_id+','+state_id);
		}
		
		function drone_ok(value){
			
			var sp = value.split(',');
			var drone_id = sp[0];
			var state_id = sp[1];
			
			var index = ${index};
			//value 는 drone_id
			//package_id

			console.log(index);
			//$('.delivery',opener.document).eq(index).prop("disabled",false);
			//$( "#drone_id",opener.document).val(value);
			$('.delivery').eq(index).prop("disabled",false);
			$("input#droneId").attr('value',drone_id);
			$("input#stateId").attr('value',state_id);
			$('button#drone').eq(index).text(drone_id);
			$('.pack_droneList').hide();
			//$('').hide();
			//window.self.close();
		}
	</script>
</head>
<body>
	<div class="drone">
		<div class="bor_title">
			<div class="subject" style="color:#ada8a8;">드론 목록</div>
		</div>
		<div class = "mail_list" style="border-bottom:1px solid #999;">
			<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
				<colgroup>
					<col width="100" /><col width="*" /><col width="100"/><col width="120"><col width="15">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">드론명</th>
						<th scope="col">상태</th>
						<th scope="col">배터리</th>
						<th scope="col">최근 운용 일자</th>
						<th scope="col"></th>
					</tr>
				</thead>
			</table>
			<div style="max-height:333px; width:100%; overflow-x:hidden; overflow-y:scroll;">
				<table cellspacing="0" border="1" class="frt_tbl_type" style="border-top:0px;">
				
					<colgroup>
						<col width="100" /><col width="*" /><col width="100"/><col width="120">
					</colgroup>
					<tbody id = "droneList">		
						<c:forEach items="${droneInfo}" var="drone">										
							<input type="hidden" id = "hidden_state" value="${drone.state_id}">
							<tr id="${drone.drone_id},${drone.state_id}" class="droneTr" onclick="drone_click(id)">
								<td class="num" id="droneId">${drone.drone_id}</td>
								<td class="title" id="droneStateName">${drone.stateList.get(0).state_name}</td>
								<td class="title">100%</td> 
								<td class="title">2018-04-12 14:22</td> 
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="drone_log" id="droneLog">
	
	</div>
	<div>
		<button type="button" class="ok_button" id="ok" onclick="drone_ok(value)" disabled="disabled">선택</button>
	</div>
</body>
</html>