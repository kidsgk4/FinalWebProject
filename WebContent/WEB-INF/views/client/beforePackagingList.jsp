<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css"/>
		<script src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>	
		<link rel="stylesheet" type="text/css" href="resources/css/notice.css">
	
	<script>
		function cancel(package_id){
			var result=confirm("삭제하시겠습니까?");
			if(result==true){
				location.href = "cancel?package_id=" + package_id;
				alert("삭제되었습니다.");
			}else{
				alert("취소하셨습니다.");
			}
			
		}
		
		function regist(package_id){
			var result=confirm("접수 요청 하시겠습니까?");
			if(result==true){
				location.href="registRequest?package_id="+package_id;
				alert("접수요청 되었습니다.");
			}else{
				alert("취소 하셨습니다.");
			}
		}

		
		function back(){
			history.back();
		}
		function registList(){
			location.href="registList";
		}
	</script>
	<style>
		#checkHead{
			text-align:center;
		}
		#checkSession{
			font-size: 20px;
			text-align:left;
		}
		
		.thead-dark{
			font-size:15px;
		}
		.tr{
			font-size:15px;
		}
		
	</style>
	</head>
	<body>	
	<jsp:include page="../common/ClienetRequestheader.jsp"></jsp:include>
				
			<div id="checkHead" class="alert alert-dnager">
				<div id="checkSession" class="alert alert-danger">${vmname} 님 이전 우편 수령 내역 입니다. 패키지 클릭시 상세 확인</div>
			</div>
				
				<table border="1" class="frt_tbl_type" style="width:100%;">	
				
								<thead class="thead-dark">
											  <tr style="height: 39px;">
											     <th scope="col">패키지 번호</th>
											     <th scope="col">패키지 무게</th>
											     <th scope="col">요청 날짜</th>
											     <th scope="col">요청 상태</th>
											     <th scope="col">마을 이름</th>
											   </tr>
								</thead>
											<c:forEach items="${packageList}" var="pack">
											<c:if test="${vid eq pack.villageList.get(0).vid and pack.stateList.get(0).state_id eq 's004'}">
											<tr class="tr" onclick="location.href='packageDetail?package_id=${pack.package_id}'"  style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#DDDDDD';" onMouseOut="this.style.backgroundColor='white'"/>
													<td>${pack.package_id}</td>
													<td>${pack.package_weight}</td>
													<td>${pack.arrival_date}</td>
													<td>${pack.stateList.get(0).state_name}</td>
													<td>${pack.villageList.get(0).vname}</td>
													<c:if test="${pack.stateList.get(0).state_id eq 's001'}">
														<td>
															<input type="button" value="접수 요청" onClick="regist(${pack.package_id})"/>
														</td>
													</c:if>
													<c:if test="${pack.stateList.get(0).state_id eq 's005'}">
														<td>접수 완료!!!</td>
													</c:if>
													
													<c:if test="${pack.stateList.get(0).state_id ne 's004'}">
														<td>
															<input type="button"  value="요청취소" onclick="cancel(${pack.package_id})"/>
														</td>
													</c:if>
												<tr>
											</c:if>
											</c:forEach>
									</table>
								
								<div>
									<input id="btn_back" type="button" value="이전 페이지로" class="btn btn-danger" onclick="back()" style="margin-top:10px; float:left;"/>
								</div>
					
	</body>
</html>