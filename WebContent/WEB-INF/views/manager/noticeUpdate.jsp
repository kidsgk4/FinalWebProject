<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script type ="text/javascript" src = "<%=application.getContextPath() %>/resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" type ="text/css" href="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">		
	<script type="text/javascript" src="<%=application.getContextPath() %>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>			
	<link rel="stylesheet" type="text/css" href="resources/css/notice.css">
	<style type="text/css">
		#notice_attach_file{
			width:210px;
		}
	</style>
	<script type="text/javascript">
	function checkForm(){
		var result= true;
		
		if($("#notice_title").val()==""){
			$("#notice_title").attr("placeholder","*제목을 입력해주세요");
			result = false;
		}
		if($("#notice_content").val()==""){
			
			$("#notice_content").attr("placeholder", "*내용을 입력해주세요.");
			
			result = false;
		}
		
		return result;
	}
	</script>		


</head>
<body>
		<jsp:include page="../common/manageHeader.jsp"/>
		<div class="body">
			<div class="body_sub">
			
			<form method="post" action="noticeUpdate" onsubmit="return checkForm()" enctype="multipart/form-data">
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
								<td colspan="5">
									<input type="text" name="notice_title" value="${notice.notice_title}" style="border:0; width: 98%;">
								</td>
							</tr>
							<tr>
								<th scope="col">작성자</th>
								<td><input type="text" name="notice_name" value="${sessionScope.mname}" style="border:0;width: 98%; text-align:center;"></td>
								<th scope="col">부서</th>
								<td><input type="text" name="dept_name" value="${sessionScope.dept_name}" style="border:0;width: 98%; text-align:center;"></td>
								<th scope="col">작성일</th>
								<td><fmt:formatDate value="${notice.notice_date}" pattern="yyyy-MM-dd" /></td>
							</tr>
							<tr>
								<th scope="col">첨부파일</th>
								<c:if test="${empty notice.notice_attach_file}">
								<td colspan="3">
									<input type="text" id="notice_attach_file" name="notice_attach_file" value="${notice.notice_attach_file}" style="border:0;" readonly>
									<input type="file" name="attachFile" id="attachFile" style="padding-left:100px;">
								</td>
								</c:if>
								<c:if test="${not empty notice.notice_attach_file}">
								<td colspan="5">
									<input type="text" id="notice_attach_file" name="notice_attach_file" value="${notice.notice_attach_file}" style="border:0;" readonly>
									<input type="file" name="attachFile" id="attachFile">
								</td>
								</c:if>
							</tr>
							<tr>
							<td colspan="6">
								<textarea name="notice_content" rows="30" cols="5" style="width: 100%;">${notice.notice_content}</textarea>
							</td>
							</tr>
					</table>
						<input type="hidden" name="notice_id" value="${notice.notice_id}">
						<input type="submit" value="저장" onClick="checkForm()" class="btn btn-danger"></input>
					</div>
					
				</form> 
				
				
			</div>
		</div>


</body>
</html>