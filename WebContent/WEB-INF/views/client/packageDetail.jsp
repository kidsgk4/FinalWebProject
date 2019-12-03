<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

</script>
<style>
input[type=text], select {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input[type=submit] {
	width: 100%;
	background-color: #4CAF50;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}

div {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}

#div1{
	border:1px solid black;
	text-align: center;
}
</style>
<script>
	function turn() {
		history.back();
	}
</script>
</head>
<body>

	<h3>패키지 상세 내용</h3>

	<div id="#div1"><h3>${vmname} 님 ${detail.package_id} 번 패키지 상세 내용 입니다.</h3>
	
	</div>

		<table border="1" class="frt_tbl_type" style="width: 100%;">
			<thead class="thead-dark">
				<tr style="height: 39px">
					<th scope="col">메일 번호</th>
					<th scope="col">보내는 사람</th>
					<th scope="col">보내는 주소</th>
					<th scope="col">받는 사람</th>
					<th scope="col">받는 주소</th>
					<th scope="col">메일 무게</th>
				</tr>
			</thead>
			<c:forEach var="detail" items="${detail.mailList}" >
				<tr>
					<td>${detail.mail_id}</td>
					<td>${detail.from_name}</td>
					<td>${detail.from_address}</td>
					<td>${detail.to_name}</td>
					<td>${detail.to_address}</td>
					<td>${detail.mail_weight}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div>
		<input type="button" onClick="turn()" class="btn btn-danger" value="이전 페이지로"/>
	</div>
</body>
</html>