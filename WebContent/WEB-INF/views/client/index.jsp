<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>Insert title here</title>
      <script type="text/javascript"
      src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
      <link rel="stylesheet" type="text/css"
      href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
      <script type="text/javascript"
      src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
   <style type="text/css">
      .body{
         background-color: white;
         display: flex;
      }
      .request{   
         width: 50%;
         margin-top: 85px;
         text-align: center;
         padding-left: 100px;
      }
      .check{
          width: 50%;
         margin-top: 85px;
         text-align: center;
         padding-right: 100px;
      }
      img{
         vertical-align: middle;
          border-style: none;
          background-color: white;
          }
   </style>
   <script>
      
      
   </script>
   </head>
   <body>
      <jsp:include page="../common/ClienetRequestheader.jsp"></jsp:include>
      <div class="menubar">
         <ul style=margin-bottom:5px>
            <li><!-- <img src="vmemeberphoto" style="width: 76px;height: 41px;margin: 0;"> -->${vmname}님 환영합니다.<a href ="clientTouch?lid=${lid}" style=display:inline>개인정보수정</a></li>
            <li style="float:right"><a href = "logout" style=display:inline>로그아웃</a></li>
         </ul>
      </div>
      <div class="body">
         <div class="request">
            <a href="requestBoarderList?pageNo=1&totalWeight=0"style="display:block;"><img src = "./resources/images/mail_request.png" style="width:400px;height:380px;"/></a>
            <a href="requestBoarderList?pageNo=1&totalWeight=0"><button type="button" class="btn btn-outline-danger" style="width:400px;">우편 작성</button></a>
         </div>
         <div class="check">
            <a href="packageCheck"style="display:block;" ><img src = "./resources/images/mail_check.png "style="width:400px;height:380px;"/></a>
            <a href="packageCheck"><button type="button" class="btn btn-outline-success" style="width:400px;">우편 확인</button></a>
         </div>
      </div>
      
   </body>
</html>