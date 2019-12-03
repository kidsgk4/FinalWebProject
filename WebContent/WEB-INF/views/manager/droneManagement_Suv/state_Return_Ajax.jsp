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
						<td class="title" id="arm" colspan="2"></td> 
					</tr>
					<tr>
						<th scope="col" colspan="2">등록 일자 일자</th>
						<td class="title" colspan="2">2018-04-12</td> 
					</tr>
					<tr>
						<th scope="col" colspan="2">최근 운용 일자</th>
						<td class="title" colspan="2">2018-04-12 14:22</td> 
					</tr>
					<tr>
						<th scope="col">배터리</th>
						<td class="title" id="battery"></td>
						<th scope="col">총 거리</th>
						<td class="title" id="total_length"></td>
					</tr>
					<tr>
						<th scope="col" colspan="2">예상 소요 시간</th>
						<td class="title" id="expectancy_time" colspan="2"></td>
					</tr>
					<tr>
						<th scope="col">높이</th>
						<td class="title" id="alt"></td>
						<th scope="col">속도</th>
						<td class="title" id="speed"></td> 
					</tr>
					<tr>
						<th scope="col">위도</th>
						<td class="title" id="currLat"></td>
						<th scope="col">경도</th>
						<td class="title" id="currLng"></td> 
					</tr>
					<tr>
						<th scope="col">roll</th>
						<td class="title" id="roll"></td>
						<th scope="col">pitch</th>
						<td class="title" id="pitch"></td> 
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	