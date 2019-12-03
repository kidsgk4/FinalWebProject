<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
		<script type="text/javascript" src="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath() %>/resources/css/login.css">
		<script type="text/javascript">
			function check() {
				var result = true;
				if($("#lauthority").val() == "") {
					alert("*로그인 방법을 선택하세요.")
					result = false;
				} else if($("#lid").val() == "") {
					alert("*아이디를 입력하세요.")
					result = false;
				} else if($("#lpassword").val() == "") {
					alert("*비밀번호를 입력하세요.")
					result = false;
				} 
				return result;
			}
			
			function manager(){
				$("button").css("background", "white");
				$("button").css("color", "black");
				$("#manager").css("background", "#F32C28");
				$("#manager").css("color", "white");
				$("#lauthority").val("manager");
			}
			function client(){
				$("button").css("background", "white");
				$("button").css("color", "black");
				$("#client").css("background", "#F32C28");
				$("#client").css("color", "white");
				$("#lauthority").val("client");
			}
			function admin(){
				$("button").css("background", "white");
				$("button").css("color", "black");
				$("#admin").css("background", "#F32C28");
				$("#admin").css("color", "white");
				$("#lauthority").val("admin");
			}
			
			$(function() {
				var lidError = "<c:out value="${lidError}" />";
				var lpasswordError = "<c:out value="${lpasswordError}" />";
				var lauthorityError = "<c:out value="${lauthorityError}" />";
				if(lidError != "") {
					alert(lidError);
				} else if(lpasswordError != ""){
					alert(lpasswordError);
				} else if(lauthorityError != ""){
					alert(lauthorityError);					
				} 
			})
			
		</script>
	</head>
	<body>
		<jsp:include page="common/loginHeader.jsp"></jsp:include>
		<div class="login_wrapper">
			<div class="login_header">
				<h1>LOGIN</h1>
			</div>
			
			<div class="login_body">
				<div class="login_body_tag" style="width: 400px;">
					<ul>
						<li><button id="manager" onclick="manager()" style="width: 100%;">우체국 직원</button></li>
						<li><button id="client" onclick="client()" style="width: 100%;">마을 이장</button></li>
						<!-- <li><button id="admin" onclick="admin()">관리자</button></li> -->
					</ul>
				</div>
				<div class="loginForm">
						<form method="post" action="login" onsubmit="return check()">
							<div class="lid">
								<input id="lid" name="lid" type="text" placeholder="아이디">
							</div>
							<div class="lpassword">
								<input id="lpassword" name="lpassword" type="password" placeholder="비밀번호">
							</div>
							<div class="lbutton">
								<input type="submit" value="로그인">
							</div>
							<input type="hidden" id="lauthority" name="lauthority" value ="">
					
					</form>	 
					<div class="jbutton">
						<a href="join">회원가입</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>