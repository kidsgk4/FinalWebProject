<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 
	<div class = "mail_list">
		<table cellspacing="0" border="1" summary="명단관리  리스트" class="frt_tbl_type" style="width:100%;padding-right:15px;">
			<colgroup>
				<col width="100" /><col width="*" /><col width="80" /><col width="100" /><col width="100" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">마을 이름</th>
					<th scope="col">총 무게</th>
					<th scope="col">상태</th>
					<th scope="col">포장 날짜</th>
					<th scope="col"><input type="checkbox" name="chk_auto" id='chk_auto' value="" onclick="Auto_weight_check()" /><label for="chk_all"></label></th>
					<th scope="col"></th>
				</tr>
			</thead>
		</table>
		<div style="max-height:500px; width:100%; overflow-x:hidden; overflow-y:scroll;">
			<table cellspacing="0" border="1" summary="명단관리 리스트" class="frt_tbl_type" style="border-top:0px;">
			
				<colgroup>
					<col width="100" /><col width="*" /><col width="80" /><col width="100" /><col width="100" />
				</colgroup>
				<tbody>		
					<c:forEach items="${packagingList}" var="package">										
						<tr>
							<td class="num">${package.package_id}</td>
							<td class="title" >${package.village}</td>
							<td class="date">${package.package_weight}</td>
							<td class="writer">${package.state_id}</td>
							<td class="writer">${package.arrival_date}</td>
							<td class="frm"><input type="checkbox" id="chk" name="${mail.mail_id}"  value="${mail.mail_weight}" onclick="weight_check()"/></td>
						</tr>
					</c:forEach>
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
					<th scope="col"><button type="button" name="" id='chk_all' value="" onclick="packaging()">패키징</button></th>
				</tr>
			</thead>
		</table>
	</div>
-->