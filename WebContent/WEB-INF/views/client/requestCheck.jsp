<%@page import="com.postoffice.web.dto.BoardDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css" />
<script
	src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
<style>

#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 8px;
}

#customers tr:nth-child(even) {
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #4CAF50;
	color: white;
}

#img {
	width:150px;
	height:35px;
	
}

#checkHead{
	width:100%;
	height:50px;
	background-color:red;
}
#checkSession{
	text-align:center;
}

.client_content_content{
	margin:10px;
	border:solid 1px black;
}

#btn2{
	position: absolute;
	right:10px;
}
</style>
<script>
	function main() {
		location.href = "client_index";
		
	}
	
 	/* function btnRegister(){
		$.ajax({
			url:"stateCheck",
			data:{"state_id":"s001"},
			success:function(result){
				console.log(result);
				console.log(result.state_id)
				var var1=JSON.parse(result);
				console.log(var1.json.state_name);
				
			}
		
		});
	
	} */
	
 	function check(state_id,mail_id){
		var result=confirm("요청 하시겠습니까?");
		if(result==true){
	 		location.href = "stateCheck?state_id=" + state_id + "&mail_id=" + mail_id;
	 		alert("요청완료");
	 		 
		}else{
			alert("취소하셨습니다.");
		} 
		
		/* var result=confirm("요청 하시겠습니까?");
		if(result==true){
		$.ajax({
			url:"stateCheck",
			data:{
					"state_id":state_id,
					"mail_id":mail_id	
					},
		success:function(){
			$("#btn").hide();
			
				alert("요쳥완료");
			$("#td").text("접수 요청 완료!!");
			}

		});
		
		}else{
			alert("취소하셨습니다.");
		} */
		  	
	}
	/* function change(){
		$("#td1").text("ㅇ");
		$("#btn").hide();
	} */

	function beforeCheckList(){
		location.href="beforeCheckList";
	}
	
</script>
</head>
<body>
<jsp:include page="../common/manageHeader.jsp"></jsp:include>
	
	
		
		<div id="checkHead">
		
			<div id="checkSession" class="alert alert-danger">${vmname} 님 요청 확인 페이지 입니다.
				
			</div>
		
		 <table id="customers" class="table">
			<thead class="thead-dark">
		<tr>
			<th>요청 번호</th>
			<th>보내는 사람</th>
			<th>보내는 주소</th>
			<th>받는 사람</th>
			<th>받는 주소</th>
			<th>메일 무게</th>
			<th>마을 이름</th>
			<th>요청 상태</th>
			<th>요청 확인</th>
			<th>접수 요청</th>
		</tr>
		</thead>
		<tbody>
		<tr>
		
		<c:forEach items="${CheckList}" var="check">
				<c:if test="${vid eq check.vid}">
					<td>${check.mail_id}</td>
					<td>${check.from_name}</td>
					<td>${check.from_address}</td>
					<td>${check.to_name}</td>
					<td>${check.to_address}</td>
					<td>${check.mail_weight}</td>
					<td>${check.village_name}</td>
					<td>${check.state_id}</td>
					<td>${check.state_name}</td>
				
				<c:if test="${check.state_id eq 's005' or check.state_id eq 's002'}">
					<td>접수 요청완료!</td>
				</c:if>
						
				<c:if test="${check.state_id ne 's005' or check.state_id eq 's002'}">
					<td><input id="btn" type="button"  value="접수 요청하기" onClick="check('s005','${check.mail_id}')"/></td>
				</c:if>
				<c:if test="${check.state_id ne 's005' or check.state_id eq 's002'}">
					<td><input id="img" type="image"  value="접수 요청하기" onClick="check('s005','${check.mail_id}')" img src="./resources/images/message.png"/></td>
				</c:if>
				
				</c:if>
				 <select name="state"> 
					<c:forEach items="${stateList }" var="state">
						<option value="${state.state_id}">${state.state_name }</option>
					</c:forEach>
				</select>
			</tr>
				</c:forEach>	
			</tbody>
		</table>
	</div> 
	
	<div id="checkFooter">
	<input id="btn1" type="button"  value="메인으로" onClick="main()" class="btn btn-primary " />
	<input id="btn2" type="button" value="이전 요청 내역" onClick="beforeCheckList()" class="btn btn-danger"/>
	</div>
	
	
	</body>
	</html>
