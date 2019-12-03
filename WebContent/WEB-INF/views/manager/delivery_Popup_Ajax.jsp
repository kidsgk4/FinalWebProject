<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

					<div class="bor_title">
						<div class="subject" style="color:#ada8a8;">배송 기록</div>
					</div>
					<div class = "mail_list" style="border-bottom:1px solid #999;">
						<table cellspacing="0" border="1" class="frt_tbl_type" style="width:100%;padding-right:15px;">
							<colgroup>
								<col width="100" /><col width="*"/><col width="100"/><col width="100"/><col width="15">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">배송 날짜</th>
									<th scope="col">마을명</th>
									<th scope="col">패키지 번호</th>
									<th scope="col" colspan="2">무게</th>
								</tr>
							</thead>
						</table>
						<div style="max-height:500px; width:100%; overflow-x:hidden; overflow-y:scroll;">
							<table cellspacing="0" border="1" class="frt_tbl_type" style="border-top:0px;">
							
								<colgroup>
									<col width="100"/><col width="*"/><col width="100"/><col width="100"/>
								</colgroup>
								<tbody>
								<c:choose>
									<c:when test="${droneLog.size() lt 1}">
										<tr>
											<td class="num" colspan="4">이력이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${droneLog}" var="log">										
											<tr>
												<td class="num">${log.delivery_date}</td>
												<td class="writer">${log.villageList.get(0).vname}</td>
												<td class="title" >${log.packageList.get(0).package_id}</td>
												<td class="date">${log.packageList.get(0).package_weight}g</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								</tbody>
							</table>
						</div>
					</div>
