<%@ page contentType="text/html; charset=UTF-8"%>
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
			<style type="text/css">
			input::placeholder{
				color:red;
			}
			textarea::placeholder{
				color:red;
			}
			</style>		
	</head>
	<body>
		<jsp:include page="../common/manageHeader.jsp"/>
		<div class="body">
			<div class="body_sub">
			
			<form method="post" action="noticeWrite" onsubmit="return checkForm()" enctype="multipart/form-data">
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
									<input type="text" id="notice_title" name="notice_title" style="border:0;width: 98%;">
<!-- 									<span id="noticetitleError" class="error" style="color:red;width:22%;"></span>
 -->								</td>
							</tr>
							<tr>
								<th scope="col">작성자</th>
								<td>${sessionScope.mname}</td>
								<th scope="col">부서</th>
								<td>${sessionScope.dept_name}</td>
								<th scope="col">작성일</th>
								<td><fmt:formatDate value="<%=new java.util.Date() %>" pattern="yyyy-MM-dd" /></td>
								
							</tr>
							<tr>
								<th scope="col">첨부파일</th>
								<td colspan="5">
									<input type="file" name="attachFile" id="attachFile">
								</td>
							</tr>
							<tr>
							<td colspan="6">
								<textarea id="notice_content" name="notice_content" rows="30" cols="5" style="width: 100%;"></textarea>
								<span id="noticecontentError" class="error" style="color:red"></span>
							</td>
							</tr>
					</table>
						<input type="hidden" name="mid" value="${memberInfo.mid}"/>
						<input type="submit" value="저장" onclick="checkForm()" class="btn btn-outline-danger"></input>
					</div>
				</form> 
			</div>
		</div>
		
	</body>
</html>