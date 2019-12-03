<%@page import="com.postoffice.web.dto.MailDTO"%>
<%@page import="com.postoffice.web.dto.StateDTO"%>
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
			<link rel="stylesheet" type="text/css" href="resources/css/notice.css">
	<script type="text/javascript">
		function requestDelete(name){
			console.log(name);
			$.ajax({
				url:"requestRemove",
				data:{"mail_id":name},
				success:function(data){
					console.log('성공');
					location.reload();
				}
			});
		}
	</script>
	<script type="text/javascript">
		function clientpackaging(){
			var Array = [];
			$('input:checkbox:checked').each(function(){
				check = $(this).attr('name');
				Array.push(check);
			});
			for(var i= 0; i < Array.length; i++){
				console.log('array' + Array[i]);
			};
			if(Array.length == 0){
				alert("*패키징된 메일이 없습니다. 확인부탁드립니다.");
			}
			else{
				$.ajax({
					url:"mailpackaging",
					data:{"mailIdList":Array,"totalWeight":$("#total_weight").text()},
					success:function(data){
						console.log("성공");
						location.reload();
					}
				});
			}
		}
		function check(){
			location.href="check";
		}
		function packageCheck(){
			location.href="packageCheck";
		}
	</script>
	<style type="text/css">
		.frt_tbl_type {
		    font-size: 15px;

		}
	
	</style>
	
	</head>
	<body>
	<jsp:include page="../common/ClienetRequestheader.jsp"></jsp:include>
		<div class="menubar">
			<ul style=margin-bottom:5px>
				<li style="position: absolute;right: 7px; border:0;">${vmname}님 환영합니다.<a href = "logout" style=display:inline>로그아웃</a>
			</ul>
		</div>
		<div class="body">
			<div class="body_sub">
					<div class="request_board_second">
						<div class="request_serch" style="float:right; maring-top:15px">
							<div style="height:20px"></div>
								<!-- 추후에 보안 검색기능 
							  <form id="searchForm" action="searchBoard" method="get">
									<select id="searchType" name="searchType">
										<option value="from_name">보내는 사람 조회</option>
										<option value="to_name">받는 사람 조회</option>
									</select>
									<input type="text" id="keyWord" name="keyword" style="height: 25px; border:#F32C28 1px solid;">
									
									<button id="search_btn" style="height: 28px; text-align:center; font-size:15px; background-color:#F32C28; border:#F32C28 1px solid;color:white;">검색</button> 
							  	
							  </form>-->
						</div>
						<div>
							<div class="subject" style="maring-top:5px; font-size:20px;">우편 요청</div>
							<div class="client_content_content">
										<table border="1" class="frt_tbl_type" style="width:100%;">
											<thead class="thead-dark">
											   <tr style="height: 39px">
											     <th scope="col">요청 번호</th>
											     <th scope="col">요청 날짜</th>
											     <th scope="col">보내는 사람</th>
											     <th scope="col">보내는 주소</th>
											     <th scope="col">받는 사람</th>
											     <th scope="col">받는 주소</th>
											     <th scope="col">메일 무게</th>
											     <th scope="col">배송 상태</th>
											     <th scope="col">마을 분류</th>
											     <th scope="col">취소</th>
											     <th scope="col" id="total_weight"></th>
											   </tr>
											  </thead>
											  <tbody>
											  <c:choose>
											  	<c:when test="${MailList.size() lt 1}">
											  		<tr>
												  		<td colspan="11" style="height:30px; background:#fbfbf9;">메일 요청이 없습니다.</td>
												  	</tr>
											  	</c:when>
												<c:otherwise>
												  	<c:forEach items="${MailList}" var="MailList">
												  		<tr>
														    <td id="Mail_id"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.mail_id }</a></td>
														    <td id="Mail_mail_date"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.mail_date}</a></td>
															<td id="Mail_fromname"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.from_name}</a></td>
															<td id="Mail_fromaddress"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.from_address}</a></td>
															<td id="Mail_toname"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.to_name }</a></td>
															<td id="Mail_toaddress"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.to_address }</a></td>
															<td id="Mail_weight"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.mail_weight }</a></td>
															<td id="Mail_state_name"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.stateList.get(0).state_name}</a></td>
															<td id="Mail_vname"><a href="boardDetail?mail_id=${MailList.mail_id }" style="font-size:15px;">${MailList.villageList.get(0).vname}</a></td>
															<td><button type="button" name="${MailList.mail_id }" id="mail_id" class="btn btn-danger" style="width:58px;height:29px;margin:0px;padding:0px" onclick="requestDelete(name)">취소</button></td>
															<td class="frm"><input type="checkbox" id="chk" name="${MailList.mail_id}"  value="${MailList.mail_weight}" onclick="weight_check()"/></td>
														</tr>
													</c:forEach>	
													</c:otherwise>
												 </c:choose>					  
											</tbody>
									</table>
									<form action="requestWrite"style="display:inline-block; float:left; margin-top: 20px;">
										<div class="client_write_button">
											<button class="btn btn-danger" onclick="clickwrite()" role="button" aria-pressed="true">글쓰기</button>
										</div>
									</form>
								</div>
								<div class="request_content" style="border-top: 2px solid #F32C28;">
								<input type = "hidden" id="totalWeight" value="${totalWeight }"/>
									<table style="margin-top:10px; float:right;">
										<tr>		
											<th scope="col"><button type="button" name="" id='chk_all' value="" onclick="clientpackaging()" class="btn btn-outline-danger">패키징</button></th>
											<th scope="col"><button type="button" name="" id='chk_all' value="" onclick="packageCheck()" class="btn btn-outline-success">확인</button></th>
										</tr>
									</table>
								</div>
								<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups" style="display:inline-block;margin-left: 615px;margin-top: 18px;" >
										<a href="requestBoarderList?pageNo=1&totalWeight=${totalWeight}" id = "first" class="btn btn-danger">처음</a>
										<c:if test="${pageNo > 1}">
											<a href="requestBoarderList?pageNo=${pageNo-1}&totalWeight=${totalWeight}" id="test1" class="btn btn-danger">이전</a>
										</c:if>		
										<div class="btn-group mr-2" role="group" aria-label="First group">
											<c:forEach begin="${startPageNo }" end="${endPageNo }" var="i">
													<c:if test="${pageNo==i }">
														<a href="requestBoarderList?pageNo=${i}&totalWeight=${totalWeight}" id="test2" class="btn btn-danger active" style="opacity: 0.5;">${i}</a>
													</c:if>
													<c:if test="${pageNo!=i }">
														<a href="requestBoarderList?pageNo=${i}&totalWeight=${totalWeight}" id="test3" class="btn btn-danger" style="opacity: 0.3;">${i}</a>
													</c:if>
									    	</c:forEach>
									    <c:if test="${groupNo<totalGroupNum }">
									    	<a href="requestBoarderList?pageNo=${endPageNo}&totalWeight=${totalWeight}" id="test4" class="btn btn-danger">다음</a>
									    </c:if>
									  </div>
									  <a href="requestBoarderList?pageNo=${endPageNo}&totalWeight=${totalWeight}" id="test5" class="btn btn-danger">맨끝</a>
								</div>					
							</div>			
						</div>
					</div>
				</div>
		</body>
		<script type="text/javascript">
		var testLen = $('a#test3').length;
		console.log('leg :' + testLen);
		
		function weight_check(){
				var intTotal = parseInt($("#totalWeight").val());
				var check = 0;
				var total = [intTotal];
				
				console.log(total);	

				
				$('input:checkbox:checked').each(function(){
					total.push(parseInt($(this).attr('value')));
				});
				
				var total_weight = 0;
				
				for(var i = 0; i < total.length; i++){
					total_weight += total[i];
				}
				
				$("#total_weight").text(total_weight+'g');
				console.log($("#total_weight").text());
				
				for(var i = 0; i < testLen; i++){
					$('a#test3').eq(i).attr('href','requestBoarderList?pageNo=${i}&totalWeight='+total_weight);
				}
				
				//$('#test3').attr('href','requestBoarderList?pageNo=${i}&totalWeight='+total_weight);
				
				$('#first').attr('href','requestBoarderList?pageNo=1&totalWeight='+total_weight);
				$('#test1').attr('href','requestBoarderList?pageNo=${startPageNo-1}&totalWeight='+total_weight);
				$('#test2').attr('href','requestBoarderList?pageNo=${i}&totalWeight='+total_weight);
				//$('#test3').attr('href','requestBoarderList?pageNo=${i}&totalWeight='+total_weight);	
				$('#test4').attr('href','requestBoarderList?pageNo=${endPageNo+1}&totalWeight='+total_weight);
				$('#test5').attr('href','requestBoarderList?pageNo=${totalPageNum}&totalWeight='+total_weight);
			}
	</script>
	</html>