<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<div class="bor_title">
		<div class="subject">드론 상태</div>
	</div>
	<div class = "mail_list" style="border-bottom:1px solid #999;">
		<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
			<colgroup>
				<col width="70"/><col width="50"/><col width="*" /><col width="100"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col" colspan="2">드론명</th>
					<td colspan="2">${droneInfo.drone_id}</td>
				</tr>
			</thead>
		</table>
		<div style="max-height:500px; width:100%;">
			<table cellspacing="0" border="1" id="droneList" class="frt_tbl_type" style="border-top:0px;">
				<colgroup>
					<col width="70"/><col width="50"/><col width="*" /><col width="90"/>
				</colgroup>
				<tbody>											
					<tr>
						<th scope="col" colspan="2">현재 상태</th>
						<td class="title" colspan="2">${droneInfo.stateList.get(0).state_name}</td> 
					</tr>
					<tr>
						<th scope="col" colspan="2">등록 일자 일자</th>
						<td class="title" colspan="2">${droneInfo.add_date}</td> 
					</tr>
					<tr>
						<th scope="col" colspan="2">최근 운용 일자</th>
						<td class="title" colspan="2">2018-04-12 14:22</td> 
					</tr>
				</tbody>
			</table>
		</div>
	</div>