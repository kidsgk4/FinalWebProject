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
		<style type="text/css">
			#lphoto{
				input:-webkit-autofill {
				   -webkit-box-shadow: 0 0 0 1000px white inset;
				}
			}
			.form-group {
			    margin-bottom: 1rem;
			    margin: auto;
			    margin-bottom: 20px;
			    width:35%;
			}
			
			element.style {
			display:inline-block;
			width: 301px;
			margin:auto;
		    }
		    div.filebox{
		    	display: inline-block;
    			margin-left: 93px;
		    }
		}
		
		</style>
		<script type="text/javascript">
			function checkFrom(){
				var result=true;
				$(".error").text("");
				
				if($("#name").val()==""){
					$("#fromnameError").text("*이름을 입력하세요.");
					result = false;
				}
				if($("#name").val().length > 3){
					$("#fromnameError").text("*이름만 입력하세요.");
					result = false;
				}
				return result;
			}
		</script>
	</head>
	<body>
	<jsp:include page = "../common/ClienetRequestheader.jsp"/>
			<div class="body">
				<div class="body_sub">
				<div class="mailWrite">
					<div class="alert alert-danger" role="alert" style="width: 600px;margin: auto;">
						<h4 class="alert-heading">회원정보 수정 페이지 입니다!</h4>
						<p>해당 순서에 맞게 개인의 정보중 수정하고자 하는 부분을 수정하시면 됩니다.</p>
						<hr>
						<p class="mb-0">불편사항은 연락부탁드립니다.</p>
					</div>
					<form action="clientAfterWrite" method="post" enctype="multipart/form-data" onsubmit="return checkFrom()">
					<c:forEach items="${vmemberList}" var="vmemberList">
					  <div class="form-group">
					    <!-- <label for="exampleInputEmail1">아이디</label> 아이디 정보 -->
					    <input type="hidden" name="vmid" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value="${vmemberList.vmid }" readonly="readonly">
					  </div>
					  <div class="form-group">
					    <label for="exampleInputEmail1">이장님 성함</label>
					    <input type="text" name="vmname" class="form-control" id="name" aria-describedby="emailHelp" value="${vmemberList.vmname }">
					  	<span id="fromnameError" class="error" style="color:red">${fromnameError}</span>
					  </div>
					  <div class="form-group">
					    <label for="exampleInputEmail1">계정 비밀번호</label>
					    <input type="text" name="vmpassword" class="form-control" id="password" aria-describedby="emailHelp" value="${vmemberList.vmpassword }">
					  </div>
					  <div class="form-group">
					    <label for="exampleInputEmail1">전화 번호</label>
					    <input type="text" name="vmtel" class="form-control" id="callNumber" aria-describedby="emailHelp" value="${vmemberList.vmtel }">
					  </div>
					  <div class="filebox">
					  <label for="exampleInputEmail1" style="margin-left:472px">사진 수정</label>
					  <br>
							<input class="upload_name" name="vmphoto" value="${vmemberList.vmphoto }" style="width: px;margin-left: 472px;" readonly="readonly">
							<input id="lphoto" name="lphoto" type="file" value="파일 추가하기">
					  </div>
					  <div class="form-group">
					    <label for="exampleInputEmail1">마을 정보</label>
					    <input type="text" name="vid" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value="${vmemberList.vid }" readonly="readonly">
					  </div>
					</c:forEach>
					<button type="submit" class="btn btn-danger" style="display:block;margin: auto;width: 600px;">수정하기</button>
				</form>
				</div>
			</div>
		</div>
	</body>
</html>