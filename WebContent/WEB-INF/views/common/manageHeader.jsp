<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="resources/css/header.css">
</head>
<body>
	<div class="header">
		<div class="logo">
			<a href="index"><img src="resources/images/logo.PNG" height=100%></a>
		</div>
		<div class="menubar">
			<ul>
				<li><a href = "packagingList">우편물 현황</a></li>
				<li><a href = "delivery">우편물 드론 배송</a></li>
				<li><a href = "droneManagement">드론 관리</a></li>
				<li><a href = "systemManagement">시스템 관리</a></li>
				<li><a href = "noticeList">공지사항</a></li>
				<!-- <li><a href = "clientManagement">회원 관리</a></li> -->
				<li style="position: absolute;right: 7px; border:0;"><a href = "logout">로그아웃</a>
			</ul>
		</div>
	</div>
</body>
</html>