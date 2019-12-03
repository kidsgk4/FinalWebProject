<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page session="true"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
			<script type ="text/javascript" 
			src = "<%=application.getContextPath() %>/resources/js/jquery-3.4.1.min.js"></script>
			<link rel="stylesheet" type ="text/css" 
			href="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
			<script type="text/javascript" 
			src="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>		
			<link rel="stylesheet" type="text/css" href="resources/css/notice.css">
			
			
		<style type="text/css">
			.notice_page{
				margin-left: 41%;
				padding-top: 8px;
			}
			
			
			.search_div{
				float:right;
				width:305px;
				
			}
			
			.wbtn_div{
				float:left;
				
				
			}
			th{
				font-size:16px;
				font-weight:700;
			}
			td{
				font-size:15px;
				font-weight:500;
			}
			
			
			</style>
		
	</head>
	<body>

			<jsp:include page="../common/manageHeader.jsp"/>
			<div class="body">
				<div class="body_sub">

				
				<div class="mail_list">
				<div class="bor_title">
					<div class="subject" style="margin-bottom:5px; font-size:22px;">공지사항</div>
					
					<div class="search_div">
						<form id="noticeSearchForm" method="get" action="noticeSearch">
							<select id="searchNotice" name="searchNotice" style="height: 25px;border:#F32C28 1px solid;">
								<option value="notice_title">제목</option>
								<option value="mname">작성자</option>
							</select>
							<input type="text" id="searchWord" name="searchWord" style="height: 25px; border:#F32C28 1px solid;">
							<button id="search_btn" style="height: 28px; text-align:center; font-size:15px; background-color:#F32C28; border:#F32C28 1px solid;color:white;">검색</button>
						</form>	
					</div>	
				</div>
		
				
					
				<div class="mail_list">				
					<table border="1" class="frt_tbl_type" style="width:100%;">
						
						<colgroup>
							<col width="15%"/><col width="21%"/><col width="21%"/>
							<col width="21%"/><col width="22%"/>
						</colgroup>
						<thead>
							<tr style="height: 39px">
								<th scope="col">글번호</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">부서</th>
								<th scope="col">작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="notice" items="${noticeList}">	
								<tr style="height: 34px;" onMouseOver="this.style.backgroundColor='#DDDDDD';" onMouseOut="this.style.backgroundColor='white'">
									<td><a href="noticeDetail?notice_id=${notice.notice_id}" style="font-size:15px;">${notice.notice_id}</a></td>
									<td><a href="noticeDetail?notice_id=${notice.notice_id}" style="font-size:15px;">${notice.notice_title}</a></td>
									<td>${notice.memberList.get(0).mname}</td>
									<td>${notice.deptList.get(0).dept_name}</td>
									<td><fmt:formatDate value="${notice.notice_date}" pattern="yyyy-MM-dd" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div class="wbtn_div">
								<a href="noticeWrite" class="btn btn-outline-danger" style="margin-top:10px;">글쓰기</a>
					</div>
					
					</div>
						
						<!-- noticeList의 페이징 처리 -->
				
						<c:if test="${totalPageNum >= 1}">
							<div class="notice_page">
							<a href="noticeList?pageNum=1" class="btn btn-outline-danger" style="margin-top:5px;"><<</a>
							<c:if test="${groupNum >1}">
								<a href="noticeList?pageNum=${startPageNum-1}" class="btn btn-outline-danger" style="margin-top:5px;"><</a>
							</c:if>
								<div style="display: inline-block;" class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
								 
								 <div class="btn-group mr-2" role="group" aria-label="First group" style="margin-top:5px;">
								 	<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
								 		<c:if test="${pageNum==i}">
								 			<a href="noticeList?pageNum=${i}" class="btn btn-danger active" >${i}</a>
								 		</c:if>
								 		<c:if test="${pageNum!=i}">
								 			<a href="noticeList?pageNum=${i}" class="btn btn-danger" style="opacity: 0.5;">${i}</a>
								 		</c:if>
								 	</c:forEach>
								  </div>
								
								</div>	
								<c:if test="${groupNum <totalGroupNum}">
									<a href="noticeList?pageNum=${endPageNum+1}" class="btn btn-outline-danger" style="margin-top:5px;">></a>
								</c:if>
								<a href="noticeList?pageNum=${totalPageNum}" class="btn btn-outline-danger" style="margin-top:5px;">>></a>
							</div>
						</c:if>

					</div>
				
				</div>
			</div>
	
	</body>
</html>