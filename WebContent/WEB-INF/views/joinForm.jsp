<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
		<script type="text/javascript" src="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath() %>/resources/css/join.css">
		<script type="text/javascript">
			var idCheck = true;
			var passwordCheck = true;
			
			function check() {
				var result = true;
				if($("#lauthority").val() == "") {
					alert("*가입 방법을 먼저 선택하세요.");
					result = false;
				} else if($("#lid").val() == ""){
					alert("*아이디를 입력하세요.");
					result = false;
				} else if(idCheck){
					alert("*중복체크를 해주세요.")
					result = false;
				} else if($("#lname").val() == "") {
					alert("*이름을 입력하세요.")
					result = false;
				} else if($("#lpassword").val() == "") {
					alert("*비밀번호를 입력하세요.")
					result = false;
				} else if(passwordCheck) {
					alert("*비밀번호가 일치하지 않습니다.")
					result = false;
				} else if($("#ltel").val() == "") {
					alert("*전화번호를 입력하세요.")
					result = false;
				}
				return result;
			}	
			
			function lidCheck() {
				if($("#lauthority").val() == "") {
					alert("*가입 방법을 먼저 선택하세요.");
					$("#lidCheckMsg").html("")
				} else if($("#lid").val() == "") {
					alert("*아이디를 입력하세요.");
					$("#lidCheckMsg").html("")
				} else {
					$.ajax({
						url: "lidCheck",
						data: {lid : $("#lid").val(), lauthority : $("#lauthority").val()},
						success: function(data) {
							if(data.result) {
								$("#lidCheckMsg").html("*사용할 수 있는 아이디 입니다.")
								$("#lidCheckMsg").css("color", "green");
								idCheck = false;
							} else {
								$("#lidCheckMsg").html("*사용할 수 없는 아이디 입니다.")
								$("#lidCheckMsg").css("color", "red");
								idCheck = true;
							}
						}
					});
				}
			}
			
			function manager() {
				$("button").css("background", "white");
				$("button").css("color", "black");
				$("#manager").css("background", "#F32C28");
				$("#manager").css("color", "white");
				$("#lauthority").val("manager");
				$("#vname").hide();
				$("#deptName").show();
			}
			
			function client() {
				$("button").css("background", "white");
				$("button").css("color", "black");
				$("#client").css("background", "#F32C28");
				$("#client").css("color", "white");
				$("#lauthority").val("client");
				$("#deptName").hide();
				$("#vname").show();
			}
			
			function admin() {
				$("button").css("background", "white");
				$("button").css("color", "black");
				$("#admin").css("background", "#F32C28");
				$("#admin").css("color", "white");
				$("#lauthority").val("admin");
				$("#vname").hide();
				$("#deptName").show();
			}
			
			$(function() {
				$("#vname").hide();
				$("#deptName").hide();
				
				/* 비밀번호 일치 또는 불일치 하는 지 확인하는 코드 */
				$("input").keyup(function(){ 
					if($("#lpassword").val() != ""){
						if($("#lpasswordCheck").val() != ""){
							if($("#lpassword").val() == $("#lpasswordCheck").val()){
								$("#lpasswordCheckError").html("*비밀번호가 일치합니다.")
								$("#lpasswordCheckError").css("color","green")
								passwordCheck = false;
							} else{
								$("#lpasswordCheckError").html("*비밀번호가 불일치합니다.")
								$("#lpasswordCheckError").css("color", "red")
								passwordCheck = true;
							}
						} else {
							$("#lpasswordCheckError").html("")
						}
					}else {
						$("#lpasswordCheckError").html("")
					}
				})
				
				/* 파일 선택하면 파일 이름만 따서 input 태그 값에 넣어주는 코드 */
				$(".filebox").ready(function(){
					var fileTarget = $(".filebox #lphoto");
					
					fileTarget.on('change', function(){
						if(window.FileReader) {
							var filename = $(this)[0].files[0].name;
						} else {
							var filename = $(this).val().split('/').pop().split('\\').pop();
						}
						$(".upload_name").val(filename);
					})
				})
			})
		</script>
		
		<!-- 사진 업로드 했을떄 즉 버튼 눌렀을때 -->
		<script type="text/javascript">
	        function uploadclick() {
				
			}
		</script>
	</head>
	<body>
		<jsp:include page="common/loginHeader.jsp"></jsp:include>
		<div class="wrapper">
			<div class="join_header">
				<h1>회원가입</h1>
			</div>
			
			<div class="join_body">
				<div class="join_body_tag" style="width: 400px;">
					<ul>
						<li><button id="manager" onclick="manager()" style="width: 100%">우체국 직원</button></li>
						<li><button id="client" onclick="client()"style="width: 100%;">마을 이장</button></li>
						<!-- <li><button id="admin" onclick="admin()">관리자</button></li> -->
					</ul>
				</div>	
				<div class="joinForm">
					<form method="post" action="join" enctype="multipart/form-data" onsubmit="return check()">
						<div>
							<input id="lid" name="lid" type="text" placeholder="아이디">
							<input onclick="lidCheck()" id="overlap" type="button" value="중복체크">
						</div>
						<span id="lidCheckMsg" class="error" style="color: red"></span>
						<div>
							<input id="lname" name="lname" type="text" placeholder="이름">
						</div>
						<div>
							<input id="lpassword" name="lpassword" type="password" placeholder="비밀번호">
						</div>
						<div>
							<input id="lpasswordCheck" name="lpasswordCheck" type="password" placeholder="비밀번호 확인">
						</div>
						<span id="lpasswordCheckError" class="error" style="color: red"></span>
						<div>
							<input id="ltel" name="ltel" type="text" placeholder="전화번호">
						</div>
						
						<div class="filebox">
							<input class="upload_name" value="파일선택" disabled="disabled">
							<label for="lphoto" onclick="uploadclick()">사진업로드</label>
							<input id="lphoto" name="lphoto" type="file">
							<div class="upload_picture">
							</div>
						</div>
						
						<div>
							<input id="lauthority" name="lauthority" type="hidden" value="">
						</div>
						<div>
							<select id="vname" name="vname">
								<c:forEach items="${vlist}" var="vlliageList">
									<option value="${vlliageList.vid}">${vlliageList.vname }</option>
								</c:forEach>
							</select>
						</div>
						<div>
							<select id="deptName" name="deptName">
								<c:forEach items="${dlist }" var="deptList">
									<option value="${deptList.dept_id }">${deptList.dept_name }</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="joinButton">
							<input type="submit" value="회원가입">
						</div>
					</form>	
				</div>
			</div>
		</div>
	</body>
</html>