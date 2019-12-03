<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="resources/css/packaging.css">

</head>
<body>
	<div class="bor_title">
		<div class="subject">${pack_num}번 패키지</div>
	</div>
	<div class = "mail_list" style="border-bottom:1px solid #999;">
		<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;">
			<colgroup>
				<col width="50" /><col width="80" /><col width="*" /><col width="80" />
				<col width="100" /><col width="50"/><col width="15">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">발신자</th>
					<th scope="col">발신자 주소</th>
					<th scope="col">수신자</th>
					<th scope="col">수신자 주소</th>
					<th scope="col" colspan="2">무게</th>
				</tr>
			</thead>
		</table>
		<div style="max-height:500px; width:100%; overflow-x:hidden; overflow-y:scroll;">
			<table cellspacing="0" border="1" class="frt_tbl_type" style="border-top:0px;">
			
				<colgroup>
					<col width="50" /><col width="80" /><col width="*" /><col width="80" />
					<col width="100" /><col width="50"/>
				</colgroup>
				<tbody>		
					<c:forEach items="${pack_mailList}" var="mail">										
						<tr>
							<td class="num">${mail.mail_id}</td>
							<td class="title" >${mail.from_name}</td>
							<td class="date">${mail.from_address}</td>
							<td class="writer">${mail.to_name}</td>
							<td class="writer">${mail.to_address}</td>
							<td class="writer">${mail.mail_weight}g</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>