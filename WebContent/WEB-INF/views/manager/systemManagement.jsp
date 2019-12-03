<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css" rel="stylesheet">
	<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="resources/css/systemManagement.css">

	<script type="text/javascript">
	
		//state테이블 행 추가
		function StateInfoPlus(){
			$("#SInfoPlus").show();
			$("#SMStateUpdate").hide();
		}
		//state테이블 추가: id확인
		function stateIdCheck(){
			var idCheck =0;
			var state_id = $('#plusStateId').val();
			console.log(state_id);
			
			$.ajax({
				url : "stateIdCheck?state_id="+state_id,
				success : function(data){
					//console.log(result.check);
					console.log(data);
					console.log(data.stateCheck);
					if(data.stateCheck > 0){					
						$('#stateInsertRequest').prop("disabled",true);
					}else if(data.stateCheck == 0){
						$('#stateInsertRequest').prop("disabled",false);

					}
				}
			});
			
		};
		//상태정보 추가
		function sysStateInsert(){
			$("#SMStateUpdate").show();
			$("#SInfoPlus").hide();
			
	 		
			if($("#plusStateId").val() == ''){
				//$("#plusStateId").attr("placeholder","*상태코드를 입력해주세요.");
				alert("*상태코드를 입력해주세요.");
				return false;
			}
			if($("#plusStateName").val()==''){
				//$("#plusStateName").attr("placeholder","*상태명을 입력해주세요.");
				alert("*상태명을 입력해주세요.");
				return false;
			}
			
				var plusStateId =  $("#plusStateId").val();
				var plusStateName = $("#plusStateName").val();
				var rowItem="<tr>"
					rowItem += "<tr><td>"+plusStateId+"</td>"
					rowItem += "<td>"+ plusStateName +"</td>"
					rowItem += "<td class='statedelete'> <a id='sdel_btn' href='sysstateDelete?state_id=${state.state_id}' onclick='SDel_btn_clicked(this);'>X</a> </td>"
					rowItem += "</tr>";
					
				$("#stateList").append(rowItem);
				return true;		
		}
		
		//행 추가 취소
		function sCancel(){
			$("#plusStateId").val('');
			$("#plusStateName").val('');
			$("#SInfoPlus").hide();
			$("#SMStateUpdate").show();
			
		}
		//state 테이블 수정
		function StateInfoUpdate(id){

			$('#updateStateId').val(id);
			$("#SMStateUpdate").hide();
			$("#SInfoUpdate").show();
			$("#SInfoPlus").hide();
			
		}

		//수정버튼 눌렀을 때
		function sysStateUpdate(){
			$("#SMStateUpdate").show();
			$("#SInfoUpdate").hide();
			
			if($("#updateStateId").val() == ''){
				//$("#updateStateId").attr("placeholder","*상태코드를 입력해주세요");
				alert("*상태코드를 입력해주세요.");
				return false;
			}
			if($("#updateStateName").val() == ''){
				alert("*상태명을 입력해주세요.");
				//$("#updateStateName").attr("placeholder","*상태명을 입력해주세요");
				return false;
			}
			
			
			
			var updateStateId = $("#updateStateId").val();
			var updateStateName = $("#updateStateName").val();
			var rowItem="<tr>"
			rowItem += "<tr><td>"+updateStateId+"</td>"
			rowItem += "<td>"+ updateStateName +"</td>"
			rowItem += "<td class='statedelete'> <a id='sdel_btn' href='sysstateDelete?state_id=${state.state_id}' onclick='SDel_btn_clicked(this);'>X</a> </td>"
			rowItem += "</tr>"
		
			$("#stateList").append(rowItem)

			return true;
			
	
		}
		//취소버튼 눌렀을 때
		function suCancel(){
			$("#updateStateName").val('');
			$("#SMStateUpdate").show();
			$("#SInfoUpdate").hide();
		}
		
		//state테이블 행 삭제
		function SDel_btn_clicked(obj){
			var tr = $(obj).parent().parent();
			tr.remove();	
		}
		
		//////////////////////////////////////////////////////////////////////////////
		
		//dept 테이블 행 추가
		function DeptInfoPlus(){
			$("#DInfoPlus").show();
			$("#SMDeptUpdate").hide();
		}
		
		//dept 테이블 추가: id확인
		function deptIdCheck(){
			var didCheck =0;
			var dept_id = $('#plusDeptId').val();
			console.log(dept_id);
			
			$.ajax({
				url : "deptIdCheck?dept_id="+ dept_id,
				success : function(data){
					//console.log(result.check);
					console.log(data);
					console.log(data.deptCheck);
					if(data.deptCheck > 0){					
						$('#deptInsertRequest').prop("disabled",true);
					}else if(data.deptCheck == 0){
						$('#deptInsertRequest').prop("disabled",false);

					}
				}
			});
			
		};
		
		
		//부서정보 추가
		function sysDeptInsert(){
			$("#SMDeptUpdate").show();
			$("#DInfoPlus").hide();
			
			if($("#plusDeptId").val() == ''){
				//$("#plusStateId").attr("placeholder","*상태코드를 입력해주세요.");
				alert("*부서코드를 입력해주세요.");
				return false;
			}
			if($("#plusDeptName").val()==''){
				//$("#plusStateName").attr("placeholder","*상태명을 입력해주세요.");
				alert("*부서명을 입력해주세요.");
				return false;
			}
		
			var plusStateId = $("#plusDeptId").val();
			var plusStateName = $("#plusDeptName").val();
			var rowItem="<tr>"
			rowItem += "<tr><td>"+plusDeptId+"</td>"
			rowItem += "<td>"+ plusDeptName +"</td>"
			rowItem += "<td class='deptdelete'> <a id='ddel_btn' href='sysdeptDelete?dept_id=${dept.dept_id}' onclick='DDel_btn_clicked(this);'>X</a> </td>"
			rowItem += "</tr>"
		
			$("#deptList").append(rowItem)
			return true;
		}
		//추가취소 눌렀을 경우
		function dCancel(){
			$("#plusDeptId").val('');
			$("#plusDeptName").val('');
			$("#DInfoPlus").hide();
			$("#SMDeptUpdate").show();
			
		}
		
		//dept 테이블 수정
		function DeptInfoUpdate(id){
			
			$('#updateDeptId').val(id);
			
			$("#SMDeptUpdate").hide();
			$("#DInfoUpdate").show();
			$("#DInfoPlus").hide();
			
		}

		//수정버튼 눌렀을 때
		function sysDeptUpdate(){
			$("#SMDeptUpdate").show();
			$("#DInfoUpdate").hide();
			
			if($("#updateDeptId").val() == null){
				$("#updateDeptId").attr("placeholder","*상태코드를 입력해주세요");
				return false;
			}
			if($("#updateDeptName").val()==''){
				//$("#plusStateName").attr("placeholder","*상태명을 입력해주세요.");
				alert("*부서명을 입력해주세요.");
				return false;
			}
			else{
			var updateStateId = $("#updateDeptId").val();
			var updateStateName = $("#updateDeptName").val();
			var rowItem="<tr>"
			rowItem += "<tr><td>"+updateDeptId+"</td>"
			rowItem += "<td>"+ updateDeptName +"</td>"
			rowItem += "<td class='deptdelete'> <a id='sdel_btn' href='sysdeptDelete?dept_id=${dept.dept_id}' onclick='DDel_btn_clicked(this);'>X</a> </td>"
			rowItem += "</tr>"
		
			$("#deptList").append(rowItem)

			return true;
			}
	
		}
		//수정취소버튼 눌렀을 때
		function duCancel(){
			$("#updateDeptName").val('');
			$("#SMDeptUpdate").show();
			$("#DInfoUpdate").hide();
		}
		
		//dept 행 삭제
		function DDel_btn_clicked(obj){
			var tr=$(obj).parent().parent();
			tr.remove();	
		}
		
		////////////////////////////////////////////////////////////////////
		
		//Village 테이블 수정
		function VillageInfoUpdate(id){
			$('#updateVillageId').val(id);
			
			$("#SMVillageUpdate").hide();
			$("#VInfoUpdate").show();
			$("#VInfoPlus").hide();
			
		}
		//마을 코드 중복 체크
		function vIdCheck(){
			var vidCheck =0;
			var vid = $("#plusVillageId").val();
			console.log(vid);
			
			$.ajax({
				url: "villageIdCheck?vid=" + vid,
				success : function(data){
					//console.log(result.check);
					console.log(data);
					console.log(data.villageCheck);
					if(data.villageCheck > 0){					
						$("#villageInsertRequest").prop("disabled",true);
					}else if(data.villageCheck == 0){
						$('#villageInsertRequest').prop("disabled",false);

					}
				} 		
			});
			
			
		}

		//수정버튼 눌렀을 때
		function sysVillageUpdate(){
			$("#SMVillageUpdate").show();
			$("#VInfoUpdate").hide();
			
			if($("#updateVillageId").val() == null){
				$("#updateVillageId").attr("placeholder","*마을코드를 입력해주세요");
				return false;
			}
			if($("#updateVillageName").val()==''){
				//$("#plusStateName").attr("placeholder","*상태명을 입력해주세요.");
				alert("*마을명을 입력해주세요.");
				return false;
			}
			else{
			var updateVId = $("#updateVId").val();
			var updateVName = $("#updateVName").val();
			var rowItem="<tr>"
			rowItem += "<tr><td>"+updateVId+"</td>"
			rowItem += "<td>"+ updateVName +"</td>"
			rowItem += "<td class='villagedelete'> <a id='sdel_btn' href='sysvillageDelete?vid=${village.vid}' onclick='VDel_btn_clicked(this);'>X</a> </td>"
			rowItem += "</tr>"
		
			$("#villageList").append(rowItem)

			return true;
			}
	
		}
		//취소버튼 눌렀을 때
		function vuCancel(){
			$("#updateVillageName").val('');
			$("#SMVillageUpdate").show();
			$("#VInfoUpdate").hide();
			
		}

		//village테이블 행 추가
		function VillageInfoPlus(){
			$("#VInfoPlus").show();
			$("#SMVillageUpdate").hide();
		}
		
		function sysVillageInsert(){
			$("#SMVillageUpdate").show();
			$("#VInfoPlus").hide();
			
			if($("#plusVillageId").val() == ''){
				//$("#plusStateId").attr("placeholder","*상태코드를 입력해주세요.");
				alert("*마을코드를 입력해주세요.");
				return false;
			}
			if($("#plusVillageName").val()==''){
				//$("#plusStateName").attr("placeholder","*상태명을 입력해주세요.");
				alert("*마을명을 입력해주세요.");
				return false;
			}
		
			var plusVillageId = $("#plusVillageId").val();
			var plusVillageName = $("#plusVillageName").val();
			var rowItem="<tr>"
			rowItem += "<tr><td>"+plusVillageId+"</td>"
			rowItem += "<td>"+ plusVillageName +"</td>"
			rowItem += "<td class='villagedelete'> <a id='sdel_btn' href='sysvillageDelete?vid=${village.vid}' onclick='VDel_btn_clicked(this);'>X</a> </td>"
			rowItem += "</tr>"
			
			var last = $("tr[name=str]:last")
			$("#villageList").append(rowItem)
			return true;
		}
		
		function vCancel(){
			$("#plusVillageId").val('');
			$("#plusVillageName").val('');
			$("#VInfoPlus").hide();
			$("#SMVillageUpdate").show();
		}
		
		//village 행 삭제
		function VDel_btn_clicked(obj){
			var tr=$(obj).parent().parent();
			tr.remove();
		}
		
		window.onload=function sortTable(){
			var table = $('#stateList');
			var rows = table[0].rows;
			for(var i=0; i<(rows.length); i++){
				var fCell = rows[i].cells[0];
				var sCell = rows[i+1].cells[0];
				if(fCell.innerHTML.toLowerCase() > sCell. innerHTML.toLowerCase()){
					rows[i].parentNode.insertBefore(rows[i+1], rows[i]);
				}
			}
		}
		
		
	
	</script>
	<style>
	.frt_tbl_type th{
		line-height: 22px;
		
	}
		thead{
			font-size:16px;
			line-height: 14px;
		}
		tbody{
			font-size:14px;
			
		}
	</style>


</head>
<body>
	<jsp:include page = "../common/manageHeader.jsp"/>
		<div class="body" style="padding-top:30px;">
			<div class="body_sub">
				<!-- 상태정보 -->
				<div class="management_left">
					<div class="bor_title">
						<div class="subject" style="font-size:20px;">상태 코드</div>
						<div id = "SMStateUpdate" style="margin-left: 87%;">
							<input id="stateInsert" type="submit" class="btn btn-outline-danger" value="+ 추가 " onclick="StateInfoPlus();" style="font-size:11pt;padding:1px;">
						</div> 
					</div>
					<div class="tophalf" style="height:450px;">
					<div class = "mail_list" style="border-bottom:1px solid #999;">
						<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
							<colgroup>
								<col width="100" /><col width="*" /><col width="90">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">상태코드</th>
									<th scope="col">상태명</th>
									<th scope="col">삭제</th>
								</tr>
							</thead>
						</table>
						<div style="max-height:450px; width:100%; overflow-x:hidden; overflow-y:scroll;">
							<table cellspacing="0" border="1" id="stateList" class="frt_tbl_type" style="border-top:0px;">
							
								<colgroup>
									<col width="100" /><col width="*" /><col width="60">
								</colgroup>
								<tbody>		
									<c:forEach items="${stateList}" var="state">										
										<tr id="state">
											<td>
												<a id="${state.state_id}" onclick="StateInfoUpdate(id)"href="#;" style="font-size:15px;">${state.state_id}</a>
											</td>
											<td id="statename" class="stateName">${state.state_name}</td>
											<td class="statedelete">
												<a id="sdel_btn" href="sysstateDelete?state_id=${state.state_id}"style="font-size:15px;" onclick="SDel_btn_clicked(this);">X</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					
					</div>
					<!-- 상태 정보 추가 -->
					<form method="post" action="stateinsert" onsubmit="return sysStateInsert()">
					<div id="SInfoPlus" style="display:none; ">
						<h4 style="margin-top: 30px;">상태 정보 추가</h4>
						<table cellspacing="0" border="1" id="stateplus" class="frt_tbl_type" style="border-top:0px;">
							<colgroup>
									<col width="100" /><col width="*" /><col width="50"/><col width="50"/>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">상태코드</th>
									<th scope="col">상태명</th>
									<th scope="col">추가</th>
									<th scope="col">취소</th>
								</tr>
							</thead>	
							<tbody>											
								<tr>
									<td><input type="text" id="plusStateId" name="state_id" class="plusStateId" oninput="stateIdCheck()"/></td>
									<td><input type="text" id="plusStateName" name="state_name" class="plusStateName"/></td>
									<td><input id="stateInsertRequest" type="submit" value="추가" style="border:0; width=30px;"></td>
									<td><input id="sInsertCancel" type="button" value="취소" onclick="sCancel()" style="border:0; width=30px;"></td>					
								</tr>
							</tbody>
						</table>
					</div>
					</form>
					
					<!-- 상태 정보 수정 -->
					<form method="post" action="stateupdate" onsubmit="return sysStateUpdate();">
					<div id="SInfoUpdate" style="display:none;">
						<h4 style="margin-top: 30px;">상태 정보 수정</h4>
						<table cellspacing="0" border="1" id="stateUpdate" class="frt_tbl_type" style="border-top:0px;">
							<colgroup>
									<col width="100" /><col width="*" /><col width="50"/><col width="50"/>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">상태코드</th>
									<th scope="col">상태명</th>
									<th scope="col">수정</th>
									<th scope="col">취소</th>
								</tr>
							</thead>	
							<tbody>											
								<tr>
									<td><input type="text" id="updateStateId" name="state_id" class="updateeStateId" style="width=55px;" readonly/></td>
									<td><input type="text" id="updateStateName" name="state_name" class="updateStateName"/></td>
									<td><input id="stateUpdate" type="submit" value="수정" style="border:0; width=30px;"></td>
									<td><input id="sUpdateCancel" type="button" value="취소" onclick="suCancel()" style="border:0; width=30px;"></td>					
								</tr>
							</tbody>
						</table>
					</div>
					</form>
					
					
					
					
				</div>
				
				<!-- 부서정보 -->
				<div class="management_center">
					<div class="bor_title">
						<div class="subject" style="font-size:20px;">부서</div>
						<div id = "SMDeptUpdate" style="margin-left: 87%;">
							<input id="deptInsert" type="submit" value="+ 추가 " class="btn btn-outline-danger" onclick="DeptInfoPlus()" style="font-size:11pt;padding:1px;">
						</div>
					</div>
					<div class="tophalf" style="height:450px; border:0px;">
					<div class = "mail_list" style="border-bottom:1px solid #999;">
						<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
							<colgroup>
								<col width="80" /><col width="*" /><col width="90"/>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">부서코드</th>
									<th scope="col">부서명</th>
									<th scope="col">삭제</th>
								</tr>
							</thead>
						</table>
							<div style="max-height:450px; width:100%; overflow-x:hidden; overflow-y:scroll;">
								<table cellspacing="0" border="1" id="deptList" class="frt_tbl_type" style="border-top:0px;">
									<colgroup>
										<col width="80" /><col width="*" /><col width="60"/>
									</colgroup>
									<tbody>		
										<c:forEach items="${deptList}" var="dept">								
											<tr>
												<td>
													<a id="${dept.dept_id}" onclick="DeptInfoUpdate(id)"href="#;"style="font-size:15px;">${dept.dept_id}</a>
												</td>
												<td class="deptName">${dept.dept_name}</td>
												<td class="deptdelete">
													<a href="sysdeptDelete?dept_id=${dept.dept_id}" onclick="DDel_btn_clicked(this);"style="font-size:15px;">X</a>
												</td>
												
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						
						</div>
						<!-- 부서정보 추가 -->
						<div id="DInfoPlus" style="display:none; ">
							<h4 style="margin-top: 30px;">부서 정보 추가</h4>
							<form method="post" action="deptinsert" onsubmit="return sysDeptInsert()" >
								<div class="DInfoPlus">
									<table cellspacing="0" border="1" id="deptplus" class="frt_tbl_type" style="border-top:0px;">
										<colgroup>
											<col width="100" /><col width="*" /><col width="50"/><col width="50"/>
										</colgroup>
										<thead>
											<tr>
												<th scope="col">부서코드</th>
												<th scope="col">부서명</th>
												<th scope="col">추가</th>
												<th scope="col">취소</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="text" id="plusDeptId" name="dept_id" oninput="deptIdCheck()"></td>
												<td><input type="text" id="plusDeptName" name="dept_name"></td>
												<td><input id="deptInsertRequest" type="submit" value="추가" style="border:0;"></td>
												<td><input id="dInsertCancel" type="button" value="취소" onclick="dCancel()" style="border:0; width=30px;"></td>					
												
											</tr>
										</tbody>
									</table>
								</div>
							</form>
						</div>
						<!-- 부서정보 수정 -->
						<div id="DInfoUpdate" style="display:none; ">
							<h4 style="margin-top: 30px;">부서 정보 수정</h4>
							<form method="post" action="deptupdate" onsubmit="return sysDeptUpdate()">
								<div class="DInfoUpdate">
									<table cellspacing="0" border="1" id="deptupdate" class="frt_tbl_type" style="border-top:0px;">
										<colgroup>
											<col width="100" /><col width="*" /><col width="50"/><col width="50"/>
										</colgroup>
										<thead>
											<tr>
												<th scope="col">부서코드</th>
												<th scope="col">부서명</th>
												<th scope="col">수정</th>
												<th scope="col">취소</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="text" id="updateDeptId" name="dept_id" readonly></td>
												<td><input type="text" id="updateDeptName" name="dept_name"></td>
												<td><input id="deptUpdate" type="submit" value="수정" style="border:0;"></td>
												<td><input id="dUpdateCancel" type="button" value="취소" onclick="duCancel()" style="border:0; width=30px;"></td>					
												
											</tr>
										</tbody>
									</table>
								</div>
							</form>
						</div>
						
						
						
				</div>
				
				<!-- 마을 정보 -->
				<div class="management_right">
					<div class="bor_title">
						<div class="subject" style="font-size:20px;">마을</div>
						<div id = "SMVillageUpdate" style="margin-left:87%;">
						<input id="villageInsert" type="submit" class="btn btn-outline-danger" value="+ 추가 " onclick="VillageInfoPlus()" style="font-size:11pt;padding:1px;">
					</div>
					</div>
					<div class="tophalf" style="height:450px; border:0px;">
					<div class = "mail_list" style="border-bottom:1px solid #999;">
						<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
							<colgroup>
								<col width="70" /><col width="*" /><col width="80">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">마을번호</th>
									<th scope="col">주소</th>
									<th scope="col">삭제</th>
								</tr>
							</thead>
						</table>
						<div style="max-height:450px; width:100%; overflow-x:hidden; overflow-y:scroll;">
							<table cellspacing="0" border="1" id="villageList" class="frt_tbl_type" style="border-top:0px;">
							
								<colgroup>
									<col width="70" /><col width="*" /><col width="50">
								</colgroup>
								<tbody>		
									<c:forEach items="${villageList}" var="village">									
										<tr>
											<td class="vid"><a id="${village.vid}" onclick="VillageInfoUpdate(id)" href="#;">${village.vid}</a></td>
											<td class="vname">${village.vname}</td>							
											<td class="vdelete">
												<a href="sysvillageDelete?vid=${village.vid}" onclick="VDel_btn_clicked(this);"style="font-size:15px;">X</a>
											</td>
										</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</div>
					</div>
					
					</div>
						<!-- 마을 정보 추가 -->
						<form method="post" action="villageinsert" onsubmit="return sysVillageInsert()">
							<div id="VInfoPlus" style="display:none; ">
								<h4 style="margin-top: 30px;">마을 추가</h4>
								<table cellspacing="0" border="1" id="villageplus" class="frt_tbl_type" style="border-top:0px;">
									<colgroup>
										<col width="100" /><col width="*" /><col width="50"/><col width="50"/>
									</colgroup>
									<thead>
										<tr>
											<th scope="col">마을코드</th>
											<th scope="col">마을명</th>
											<th scope="col">추가</th>
											<th scope="col">취소</th>
										</tr>
									</thead>	
									<tbody>											
										<tr>
											<td><input type="text" id="plusVillageId" name="vid" class="plusVillageId" oninput="vIdCheck()"/></td>
											<td><input type="text" id="plusVillageId" name="vname" class="plusVillageName"/></td>
											<td><input id="villageInsertRequest" type="submit" value="추가" style="border:0;"></td>	
											<td><input id="sInsertCancel" type="button" value="취소" onclick="vCancel()" style="border:0; width=30px;"></td>									
										</tr>
									</tbody>
								</table>
							</div>
						</form>
					<!-- 마을 정보 수정 -->
					<form method="post" action="villageupdate" onsubmit="return sysVillageUpdate()">
							<div id="VInfoUpdate" style="display:none; ">
								<h4 style="margin-top: 30px;">마을 추가</h4>
								<table cellspacing="0" border="1" id="villageupdate" class="frt_tbl_type" style="border-top:0px;">
									<colgroup>
										<col width="100" /><col width="*" /><col width="50"/><col width="50"/>
									</colgroup>
									<thead>
										<tr>
											<th scope="col">마을코드</th>
											<th scope="col">마을명</th>
											<th scope="col">수정</th>
											<th scope="col">취소</th>
										</tr>
									</thead>	
									<tbody>											
										<tr>
											<td><input type="text" id="updateVillageId" name="vid" class="updateVillageId" style="width=55px;" readonly/></td>
											<td><input type="text" id="updateVillageName" name="vname" class="updateVillageName"/></td>
											<td><input id="villageUpdate" type="submit" value="수정" style="border:0;"></td>	
											<td><input id="vUpdateCancel" type="button" value="취소" onclick="vuCancel()" style="border:0; width=30px;"></td>									
										</tr>
									</tbody>
								</table>
							</div>
						</form>
					
					
					
				</div>

			</div>	
		</div>
</body>
</html>