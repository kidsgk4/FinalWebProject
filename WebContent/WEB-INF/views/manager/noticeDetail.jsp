<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
			<script type ="text/javascript" src = "<%=application.getContextPath() %>/resources/js/jquery-3.4.1.min.js"></script>
			<link rel="stylesheet" type ="text/css" href="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
			<script type="text/javascript" src="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>			
			<link rel="stylesheet" type="text/css" href="resources/css/notice.css">
		
			<script type="text/javascript">
				function fileCheck(){
					form.submit();
				}
			</script>
	</head>
	<body>
	<jsp:include page="../common/manageHeader.jsp"/>
		<div class="body">
			<div class="body_sub">
			
			
				<div class="bor_title">
					<div class="subject">공지사항 글작성</div>
					
				</div>

				<div class = "mail_list">
					<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;">
						<colgroup>
							<col width="10%"/><col width="23%"/><col width="10%"/>
							<col width="23%"/><col width="10%"/><col width="24%"/>
						</colgroup>
							<tr>
								<th scope="col">제목</th>
								<td colspan="5"><input type="text" name="wtitle" style="border:0;width: 98%;" value="${noticedetail.notice_title}"readonly></td>
							
							</tr>
							<tr>
								<th scope="col">작성자</th>
								<td><input type="text" name="mname" value="${noticedetail.memberList.get(0).mname}" style="border:0; width: 100%; text-align: center" readonly></td>
								<th scope="col">부서</th>
								<td><input type="text" name="dept_name" value="${noticedetail.deptList.get(0).dept_name}" style="border:0; width: 100%; text-align: center" readonly></td>
								<th scope="col">작성일</th>
								<td><fmt:formatDate value="${noticedetail.notice_date}" pattern="yyyy-MM-dd" /></td>
								
							</tr>
							<tr>
								<th scope="col">첨부파일</th>
								<td colspan="5">
								<c:if test="${not empty noticedetail.notice_attach_file}">
								<form action="filedownload" method="post"enctype="nultipart/form-data">
									<input type="hidden" value="${noticedetail.notice_id}" id="notice_id" name="notice_id"/>
									<input type="submit" id= "NFileName" name="NFileName" value="${noticedetail.notice_attach_file}" style="border:0;background-color:white"/>
								</form>								
								</c:if>
								</td>
							</tr>
							<tr>
							<td colspan="6"><textarea rows="30" cols="5" style="width: 100%;"readonly>${noticedetail.notice_content}</textarea></td>
							</tr>
					</table>
						
					</div>
		
				<a href="noticeList?pageNum=${PageNum}" class="btn btn-secondary" float:left;"id="listBtn">목록으로</a>	
				<!-- 관리자가 아니라면 수정 삭제 불가(해당글을 작성한 사람 = 관리자) -->
				<c:if test="${noticedetail.mid eq sessionScope.lid}">
					<div class="buttonBox" style="float:right;">
					<a href="noticeUpdate?notice_id=${noticedetail.notice_id}" class="btn btn-danger" id="updateBtn">수정</a>	
					<a href="noticeDelete?notice_id=${noticedetail.notice_id}" class="btn btn-danger" id="deleteBtn">삭제</a>
					</div>
				</c:if>
			</div>
		</div>
	</body>
</html>