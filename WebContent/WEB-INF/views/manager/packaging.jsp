<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/css/packaging.css">

   <script type="text/javascript"
      src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
   <link rel="stylesheet" type="text/css"
      href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
   <script type="text/javascript"
      src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>

	<style type="text/css">
		.vill_search{
			width: 80px;
		    font-size: 13px;
		    height: 22px;
		    border: 1px solid red;
		}

	</style>
	<script type="text/javascript">
	   
		//이기능
		function weight_check(){
		   
		   var total = [];
		   var check = 0;
		   
		   $('input:checkbox:checked').each(function(){
		      total.push(parseInt($(this).attr('value')));
		   });
		   
		   total_weight = 0;
		   
		   for(var i = 0; i < total.length; i++){
		      total_weight += total[i];
		   }
		
		   $("#total_weight").text(total_weight+'g');
		   console.log($("#total_weight").text());
		}
		
		var index;
		var option_index;
		
		$(function(){
			index = $('input#chk').length;
			option_index = $('option').length;
			
		})
		
		function Auto_weight_check(){
		    var to_weight = 0;
		    console.log($('option').val());
		    console.log($('select').val());
		    
		    	for(var i = 0; i < index; i++) {
		    	//if(($('select').val()) == $('td#villName').text().eq(i)){
		        	var weight_int = parseInt($("td#mail_weight").eq(i).text());
		        	console.log(weight_int);
		        	to_weight += weight_int;
		        	console.log(total_weight);
		        	
		          	if(to_weight < 1000){
		          		$("input#chk").eq(i).prop("checked",true);
			          }
			      // }
			    }
		    	
			var total = [];
			   var check = 0;
			   
			   $('input:checkbox:checked').each(function(){
			      total.push(parseInt($(this).attr('value')));
			   });
			   
			   total_weight = 0;
			   
			   for(var i = 0; i < total.length; i++){
			      total_weight += total[i];
			   }
			
			   $("#total_weight").text(total_weight+'g');
		}
		      
		
		function packaging(){
		   var Array = [];
		   
		   $('input:checkbox:checked').each(function(){
		      check = $(this).attr('name');
		      Array.push(check);
		   });
		   
		   for(var i= 0; i < Array.length; i++){
		      console.log('array' + Array[i]);
		   };
		   
		   var vid = $('input.hidden_vid').eq(0).attr('id');
		   $.ajax({
		      url:"packaging",
		      data:{"mailIdList":Array,"totalWeight":$("#total_weight").text(),"vid":vid},
		      success:function(data){
		         console.log('성공');
		         location.reload();
		      }
		   });
		}
		
		function pack_mailList(value){
		   var url = 'pack_mailList?package_id='+value;
		   window.open(url,"","width=800,height=700,right=300")
		}
	
	</script>
	<script type="text/javascript">
		function mailReceive() {
			var clientToname = new Array();
			var clientFromname = new Array();
			var clientToaddress = new Array();
			var clientFromaddress = new Array();
			var clentMailweight = new Array();
	
			var array = new Array();
	
			var ranNum = Math.random() * 10 + 4;
	
			var num = parseInt(ranNum);
	
			clientToname = [ '송인성', '양관우', '안소영', '이명상', '김현수', '신용권', '이상엽',
					'염현지', '이민호', '김태희', '김민지', '김갑수', '김영희', '김남수' ];
			clientFromname = [ '염현지', '이민호', '김태희', '김민지', '김갑수', '김영희', '김남수',
					'송인성', '양관우', '안소영', '이명상', '김현수', '신용권', '이상엽'];
			clientToaddress = [ '경기도 의정부시', '경기도 남양주시', '서울특별시 면목동', '서울특별시 망우동',
					'서울특별시 상봉동', '서울특별시 중계동', '서울특별시 대치동', '서울특별시 양서구', '강원도 양구',
					'경기도 파주', '경기도 하남시', '경기도 성남', '경기도 수원', '강원도 철원군'
	
			];
			clientFromaddress = [ '경기도 의정부시', '경기도 남양주시', '서울특별시 면목동', '서울특별시 망우동',
					'서울특별시 상봉동', '서울특별시 중계동', '서울특별시 대치동', '서울특별시 양서구', '강원도 양구',
					'경기도 파주', '경기도 하남시', '경기도 성남', '경기도 수원', '강원도 철원군' ];
	
			clientMailweight = [ 30, 20, 40, 50, 60, 80, 100, 200, 300, 1, 2, 3, 4,
					5 ];
	
			clientVillageName = [ 'v001', 'v002', 'v003', 'v001', 'v002', 'v003',
					'v001', 'v002', 'v003', 'v001', 'v002', 'v003', 'v001', 'v002',
					'v003' ];
	
			for (i = 0; i < 5; i++) {
				ranNum = Math.random() * 10 + 4;
				num = parseInt(ranNum);
				ranWeight = parseInt((Math.random()*10)+4) 
				$.ajax({
					url : "clientInfo",
					data : {
						"to_name" : clientToname[num],
						"from_name" : clientFromname[num],
						"to_address" : clientToaddress[num],
						"from_address" : clientFromaddress[num],
						"vid" : clientVillageName[num],
						"weight" : ranWeight
					},
					success : function() {
						window.location.reload();
					}
				});
			}
		}
	</script>
	
	<style type="text/css">
		.frt_tbl_type .num, .frt_tbl_type .date, .frt_tbl_type .hit {
    		
    		font-size: 15px;
    		line-height: 35px;
		}
		.searching .input_submit {
    		font-size: 14px;
    		height: 22px;
    		border: 1px;
    		line-height: 18px;
    	}
    	.frt_tbl_type th{
    		line-height:20px;
    		font-size:15px;
    	}
    	.frt_tbl_type td {
		    
		    font-size: 14px;
		}
				
	</style>
	
</head>
<body>

	<jsp:include page = "../common/manageHeader.jsp"/>
	<div class="body">
		<div class="body_sub">
			<div class="pack_left">
				<div class="bor_title">
					<div class="subject" style="font-size:22px;">우편 목록</div>
					<div class="searching">
						<form action="pack_search" method="post">
							<select name="village_name" class="vill_search">
								<option>마을 선택</option>
								<c:forEach items="${villages}" var="villList">
									<option id="${villList.vid}" value="${villList.vid}">${villList.vname}</option>
								</c:forEach>
							</select>
							<input type="submit" value="조회" class="input_submit">
						</form>
						
					</div>
				</div>
				<div class = "mail_list">
					<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
						<colgroup>
							<col width="50" /><col width="80" /><col width="200" /><col width="80" /><col width="*" /><col width="100" />
							<col width="50"/><col width="70"><col width="15">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" rowspan="2">NO</th>
								<th scope="col" colspan="2">발신자</th>
								<th scope="col" colspan="2">수신자</th>
								<th scope="col" rowspan="2">도착 마을</th>
								<th scope="col" rowspan="2">무게</th>
								<th scope="col" rowspan="2" colspan="2">
									<button type="button" class="auto_btn"name="chk_auto" id='chk_auto' value="" onclick="Auto_weight_check()">자동 선택</button>
								</th>
							</tr>
							<tr>
								<th scope="col">이름</th>
								<th scope="col">주소</th>
								<th scope="col">이름</th>
								<th scope="col">주소</th>
								
							</tr>
						</thead>
					</table>
					<div style="max-height:500px; width:100%; overflow-x:hidden; overflow-y:scroll;">
						<table cellspacing="0" id="mailTable" border="1" class="frt_tbl_type" style="border-top:0px;">
						
							<colgroup>
								<col width="50" /><col width="80" /><col width="200" /><col width="80" /><col width="*" /><col width="100" />
								<col width="50" /><col width="70">
							</colgroup>
							<tbody>	
							<c:choose>
								<c:when test="${mailList.size() lt 1}">									
									<tr>
										<td class="num" colspan="8" style="height:30px; background:#fbfbf9;">우편이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									
							<c:forEach items="${mailList}" var="mail">                     

                              <tr>
                                 <td class="num">${mail.mail_id}</td>
                                 <td class="num">${mail.from_name}</td>
                                 <td class="num">${mail.from_address}</td>
                                 <td class="num">${mail.to_name}</td>
                                 <td class="num">${mail.to_address}</td>
                                 <td class="num" id="villName">${mail.villageList.get(0).vname}</td>
                                 <td class="num" id="mail_weight">${mail.mail_weight}</td>
                                 <td class="frm"><input type="checkbox" id="chk" name="${mail.mail_id}"  value="${mail.mail_weight}" onclick="weight_check()"/></td>

                              </tr>
   								<input type="hidden" id ="${mail.villageList.get(0).vid}" class="hidden_vid">
                         </c:forEach>
								</c:otherwise>
								
							</c:choose> 
							</tbody>
						</table>
					</div>
					<table border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;border-top: 1px solid #999;">
						<colgroup>
							<col width="*" /><col width="50" /><col width="100" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" colspan="5">총 무게</th>
								<th scope="col" id="total_weight"></th>
								<th scope="col"><button type="button"  onclick="mailReceive()">우편물 받기</button></th>
								<th scope="col" style="padding:0;"><button type="button" class="pack_btn" name="" id='chk_all' value="" onclick="packaging()">패키징</button></th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			
			<div class="pack_right">
				<div class="bor_title">
					<div class="subject"style="font-size:22px;">패키지 목록</div>
				</div>
				<div class = "mail_list" style="border-bottom:1px solid #999;">
					<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
						<colgroup>
							<col width="100" /><col width="*" /><col width="80" /><col width="100" /><col width="100" /><col width="100"><col width="15">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">마을 이름</th>
								<th scope="col">총 무게</th>
								<th scope="col">상태</th>
								<th scope="col" style="border-right:0;">포장 날짜</th>
								<th scope="col" colspan="2"></th>
							</tr>
						</thead>
					</table>
					<div style="max-height:500px; width:100%; overflow-x:hidden; overflow-y:scroll;">
						<table cellspacing="0" border="1" summary="명단관리 리스트" class="frt_tbl_type" style="border-top:0px;">
						
							<colgroup>
								<col width="100" /><col width="*" /><col width="80" /><col width="100" /><col width="100"><col width="100" />
							</colgroup>
							<tbody>		
								<c:forEach items="${packageList}" var="pack">										
									<tr>
										<td class="num">${pack.package_id}</td>
										<td class="title">${pack.villageList.get(0).vname}</td>
										<td class="date">${pack.package_weight}</td>
										<td class="writer">${pack.stateList.get(0).state_name}</td>
										<td class="writer">${pack.arrival_date}</td>
										<td class="title"><button type="button" class="mail_btn" value="${pack.package_id}" onclick="pack_mailList(value)">우편 목록</button></td>
									</tr> 
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>