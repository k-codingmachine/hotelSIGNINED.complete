<%@page import="com.signied.dto.ReservationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보 조회</title>
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/ReservationTable.css">
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="hotel-datepicker-main/dist/css/hotel-datepicker.css">
<script src="hotel-datepicker-main/dist/fecha.js"></script>
<script src="hotel-datepicker-main/fecha-4.2.1/dist/fecha.min.js"></script>
<script src="hotel-datepicker-main/dist/js/hotel-datepicker.js"></script>
<script src="js/sertch.js"></script>
<script src="js/ReservationCheck.js" type="text/javascript"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="header.jsp" />

	<h3 class="info-title">예약 정보</h3>

	<div class="reservationWrap">
		<div class="room_info">
			<div class="room_img">
				<img src="${room.img}" alt="예약한 객실 사진" />
			</div>
		</div>

		<div class="reservation_info">
			<p>요약</p>
			<table>
				<tr>
					<th>호텔 및 객실</th>
					<td>시그니드 서울 : <span class="room_name">${room.roomName}</span></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${reservation.reserveEmail}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${reservation.reserveName}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${reservation.reservePhone}</td>
				</tr>
				<tr>
					<th>Check-In</th>
					<td>${checkIn}</td>
				</tr>
				<tr>
					<th>Check-Out</th>
					<td>${checkOut}</td>
				</tr>
				<tr>
					<th>인원수</th>
					<td>${reservation.guestNum}</td>
				</tr>
				<tr>
					<th>요금 (${bak}박)</th>
					<td><fmt:formatNumber value="${total}" pattern="#,###" /> KRW</td>
				</tr>
				
			</table>
		</div>

	</div>



	<div class="divbutton">
		<button type="submit" name="confirm" value="확인"
			onclick="open_win('HotelServlet?command=Reservation_pass_check_form&num=${reservation.reserveNum}', 'delete')"
			class="cancleButton">
			<span>예약 취소</span>
		</button>
	</div>
</body>
</html>
