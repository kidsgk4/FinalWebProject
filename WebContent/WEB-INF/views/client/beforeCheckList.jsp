<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css"/>
		<script src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>	
	<script>
		function back(){
			history.back();
		}
	</script>
	</head>
	<body>
	<div>
		${vmname} 님의 이전 우펴 내역 입니다.
		
			<table id="customers" class="table">
			<thead class="thead-dark">
		<tr>
			<th>패키지 번호</th>
			<th>보내는 사람</th>
			<th>마을 이름</th>
			<th>받는 주소</th>
			<th>우편 총 무게</th>
			<th>요청 상태</th>
		</tr>
		
		<tr>
			<td>${beforeList.package_id}</td>
			<td>ㅇ</td>
			<td>ㅇ</td>
			<td>ㅇ</td>
			<td>ㅇ</td>
		</tr>
		</thead>
		<tbody>
		
		</table>
	</div>
		<button onclick="back()" class="btn btn-danger">이전 페이지로 돌아가기</button>
	</body>
</html>