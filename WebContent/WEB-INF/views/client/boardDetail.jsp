 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
			<script type= "text/javascript" src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
			<link rel="stylesheet" type = "text/css" href ="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css"/>
			<script type= "text/javascript" src ="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
	<style>
		.mailWrite{
			width:100%;
			height:800px;
			border:solid 1px black;
			float:left;
		}
	</style>
	</head>
	<body>
	<form action="updateBoard" method="post">
	<div class="mailWrite">
		 <div class="form-group">
		    <label for="formGroupExampleInput2">메일 고유값</label>
		    <input type="text" class="form-control" id="mail_id" name="mail_id" value="${board.mail_id}" readonly="readonly">
		  </div>
		   <div class="form-group">
		    <label for="formGroupExampleInput">보내는 사람 이름</label>
		    <input type="text" class="form-control" id="from_name" name="from_name" placeholder="보내는 이름을 입력하세요" value="${board.from_name}">

		  </div>
		  <div class="form-group">
		    <label for="formGroupExampleInput2">보내는 사람 주소</label>
		    <input type="text" class="form-control" name="from_address" id="to_name" placeholder="받는 사람이름을 입력하세요" value="${board.from_address}">

		  </div>
		 
		  <div class="form-group">
		    <label for="formGroupExampleInput2">받는 사람이름</label>
		    <input type="text" class="form-control" name="to_name" id="to_name" placeholder="보내는 사람주소를 입력하세요" value="${board.to_name}">

		  </div>
		  <div class="form-group">
		    <label for="formGroupExampleInput2">받는 사람주소</label>
		    <input type="text" class="form-control" name="to_address" id="to_address" placeholder="받는 사람주소 입력하세요" value="${board.to_address}">

		  </div>
		   <div class="form-group">
		    <label for="formGroupExampleInput">우편물 무게</label>
		    <input type="text" class="form-control" name="mail_weight" id="mail_weight" placeholder="우편물 무게를 입력하세요" value="${board.mail_weight}">
		  </div>
		   <div class="form-group">
		    <label for="formGroupExampleInput">배송 상태</label>
		    ${board.stateList.get(0).state_name }
		  </div>
		  <input type="submit" class="btn btn-success" value="수정하기">
		  <a href="requestBoarderList" class="btn btn-secondary">뒤로가기</a>
	</div>
	</form>
	</body>
</html>