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
				alert("삭제되었습니다.")
			}else{
				alert("취소하셨습니다.")
			}
			
		}
		
		
		function regist(package_id){
			var result=confirm("수령 하셨습니까?");
			if(result==true){
				location.href="registRequest?package_id="+package_id;
				alert("요청되었습니다.");
			}else{
				alert("취소 하셨습니다.")
			}
		}
		
		function regist2(package_id){
			var result=confirm("부착 하셨습니까?");
			if(result==true){
				location.href="registRequest?package_id="+package_id;
				alert("요청되었습니다.");
			}else{
				alert("취소 하셨습니다.")
			}
		}
		
		function back(){
			history.back();
		}
		function registList(){
			location.href="registList";
		}
		
		function villageArrive(package_id){
			var result=confirm("우편 수령 하시겠습니까?");
			if(result==true){
				location.href="villageArrive?package_id="+package_id;
				alert("수령 되었습니다.")
			}else{
				alert("우편 수령 후 클릭해 주세요.")
			}
			
		}
		function current(){
			window.open("deliveryMap" , width=750, height=500);
		}
	</script>
	<style>
		#checkHead{
			text-align:center;
		}
		.frt_tbl_type{
			font-size:15px;
		}
		
	</style>
	</head>
	<body>	
	<jsp:include page="../common/ClienetRequestheader.jsp"></jsp:include>
				
			<div id="checkHead">
				<div id="checkSession" class="alert alert-danger">${vmname} 님 요청 확인 페이지 입니다.</div>
			</div>
				
				<div style="width:100%; height:500px; overflow:auto">
				<table border="1" class="frt_tbl_type" style="width:100%;">	
				
								<thead class="thead-dark">
											  <tr style="height: 39px">
											     <th scope="col">패키지 번호</th>
											     <th scope="col">패키지 무게</th>
											     <th scope="col">마을 이름</th>
											     <th scope="col">요청 상태</th>
											     <th scope="col">배송 현황</th>
											     <th scope="col">접수 요청</th>
											     <th scope="col">요청 취소</th>
											     
											   </tr>
								</thead>
								
											<c:forEach items="${packageList}" var="pack">
											<c:if test="${vid eq pack.villageList.get(0).vid and pack.stateList.get(0).state_id ne 's004' and pack.stateList.get(0).state_id ne 's002'}">
											<tr class="tr" <%-- onclick="location.href='packageDetail?package_id=${pack.package_id}'"  style="cursor:pointer;"--%> onMouseOver="this.style.backgroundColor='#DDDDDD';" onMouseOut="this.style.backgroundColor='white'"/>
													<td><a href="packageDetail?package_id=${pack.package_id}" style="font-size:15px;">${pack.package_id}</a></td>
													<td>${pack.package_weight}</td>
													<td>${pack.villageList.get(0).vname}</td>
													<td>${pack.stateList.get(0).state_name}</td>
													<c:if test="${pack.stateList.get(0).state_id eq 's003'}">
														<td><input type="button" value="배송 현황" onclick="current()"/></td>
													</c:if>
													<c:if test="${pack.stateList.get(0).state_id ne 's003'}">
														<td>배송 현황이 없습니다</td>
													</c:if>
													<c:if test="${pack.stateList.get(0).state_id eq 's003'}">
														<td><input type="button" value="우편 수령" onClick="villageArrive(${pack.package_id})"/></td>
													</c:if>
													
													<c:if test="${pack.stateList.get(0).state_id eq 's001'}">
														<td><input type="button" value="우편 부착" onClick="regist2(${pack.package_id})"/></td>
													</c:if>
													<c:if test="${pack.stateList.get(0).state_id eq 's005'}">
														<td>우편 부착 완료!!!</td>
													</c:if>
													<c:if test="${pack.stateList.get(0).state_id eq 's007'}">
														<td>마을 도착 완료</td>
														<td>마을 도착 완료</td>
													</c:if>
													
													<c:if test="${pack.stateList.get(0).state_id eq 's004'}">
														<td>접수가 완료된</td>
														<td>요청입니다.</td>
														
													</c:if>
													<c:if test="${pack.stateList.get(0).state_id eq 's003'}">
														<td>드론이 배송중입니다</td>
													</c:if>
													<%-- <c:if test="${pack.stateList.get(0).state_id eq 's003'}">
														<td><input type="button" value="우편 부착" onclick="villageArrive(${pack.package_id})" /></td>
													</c:if> --%>
													
												
													

													<c:if test="${pack.stateList.get(0).state_id ne 's004' and pack.stateList.get(0).state_id ne 's007' and pack.stateList.get(0).state_id ne 's003'}">
														<td><input type="button"  value="요청취소" onclick="cancel(${pack.package_id})"/></td>

													

												</c:if>
													
													<%-- <c:if test="${pack.stateList.get(0).state_id eq 's007'}">
														<td></td>
													</c:if> --%>
								
											</c:if>
											</c:forEach>
									</table>
								</div>
								<div class="request_content" style="border-top: 2px solid #F32C28;">
								
									<table style="margin-top:10px; float:right;">
									</table>
								</div>
								
								<div>
									<input id="btn_back" type="button" value="이전 페이지로" class="btn btn-danger" onclick="back()" style="margin-top:10px; float:left;"/>
									
									<input type="button" value="이전 요청완료 내역" class="btn btn-danger" onclick="registList()" style="margin-top:10px; float:right;" />
									
								</div>
					
	</body>
</html>