<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 - 객실, 요금 선택 | 시그니드</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="hotel-datepicker-main/dist/css/hotel-datepicker.css">
<script src="hotel-datepicker-main/dist/fecha.js"></script>
<script src="hotel-datepicker-main/fecha-4.2.1/dist/fecha.min.js"></script>
<script src="hotel-datepicker-main/dist/js/hotel-datepicker.js"></script>
<link rel="stylesheet" href="css/search.css">
<script src="js/search.js"></script>
<!-- 이거 폰트어썸 스크립트로 아이콘 쓸 수 있는 스크립트입니다. -->
<script src="https://kit.fontawesome.com/f21f7d3508.js"
	crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap"
	rel="stylesheet">
</head>
<body>
	<div id="wrap">
		<div class="header">
			<a href="index.jsp"><img src="image/hotel_logo.png" alt="호텔로고사진"></a>

			<nav>
				<ul>
					<li class="sertchClick"><a href="">객실예약</a></li>
					<li><a href="ReservationInquiry.jsp">예약조회</a></li>
					<li><a href="HotelServlet?command=QnAList&pageNum=1">QnA</a></li>
				</ul>
			</nav>
			<div class="sertchWrap">
				<div class="hotelSertch">
					<form action="HotelServlet" name="frm" method="post" id="myForm">
						<input type="hidden" name="command" value="search_room"
							class="command" />
						<input type="hidden" name="originCheckIn" value="${originCheckIn}" id="originCheckIn"/>
						<input type="hidden" name="originCheckOut" value="${originCheckOut}" id="originCheckOut"/>
						<div class="hotelName">
							<label for="name">호텔</label>
							<div class="input">
								<input type="text" readonly="readonly" value="시그니드 서울"
									name="name" id="name">
							</div>
						</div>
						<div class="hotelCheckinAndCheckout">
							<div class="date_col">
								<strong class="date_title">체크인</strong> <span class="date_day">${checkIn}</span>
							</div>
							<span class="date_stay"> <span class="night">${bak}</span>
							</span>
							<div class="date_col">
								<strong class="date_title">체크아웃</strong> <span class="date_day">${checkOut}</span>
							</div>

							<a href="" title="레이어팝업" class="date_anchor"></a>
						</div>
						<div class="sertchPerson">
							<div class="person_col">
								<strong class="person_text">객실수</strong> <span
									class="person_num">1</span>
							</div>
							<div class="person_col">
								<strong class="person_text">성인</strong> <span class="person_num">${adult}</span>
							</div>
							<div class="person_col">
								<strong class="person_text">어린이</strong> <span
									class="person_num">${child}</span>
							</div>

							<a href="" title="레이어팝업" class="date_anchor"></a>
						</div>
						<div class="item_edit">
							<button type="submit" class="sertchButton" form="myForm"
								onclick="amountCount()">수 정</button>
						</div>

						<div class="dateInput">
							<div>
								<input type="hidden" id="input-id" name="input-id">
							</div>

							<div class="datePerson">
								<span>객실 1</span>
								<!-- 어른의 수를 조절하는 input -->
								<div class="datePersonBtn">
									<button type="button" onclick="del('adultAmount')"
										class="amounts personPlus">
										<span>-</span>
									</button>
									<input type="number" name="adultAmount" id="adultAmount"
										value="${adult}" min="1" size="3" class="personNum"> <span
										class="person_adult">성인${adult}</span>
									<button type="button" onclick="add('adultAmount')"
										class="amounts personMinus">
										<span>+</span>
									</button>
								</div>
								<div class="datePersonBtn">
									<button type="button" onclick="del('childAmount')"
										class="amounts personPlus">
										<span>-</span>
									</button>
									<input type="number" name="childAmount" id="childAmount"
										value="${child}" size="3" class="personNum"> <span
										class="person_child">어린이${child}</span>
									<button type="button" onclick="add('childAmount')"
										class="amounts personMinus">
										<span>+</span>
									</button>
								</div>
							</div>

						</div>
					</form>
				</div>

			</div>
		</div>

		<!-- 10/27 href 이동은 페이지가 만들어지고 수정 -->
		<div class="stepProcess">
			<ul class="process_col">
				<li class="list_first"><a href="#">호텔 선택</a></li>
				<li class="list_second"><a href="#">객실 선택</a></li>
				<li class="list_third"><a href="#">예약정보 입력</a></li>
			</ul>
		</div>

		<div class="searchList">
			<div class="searchListImg">
				<a href="" id="show"><img src="./search_icon/detailSearch.ico"
					alt="detailSearch" width="35" height="35"> <span
					class="searchListP">상세검색</span> </a>
			</div>
		</div>
		
		<div>
      		<p class="message">${message}</p>
    	</div>

		<div class="roomList">
			<form action="HotelServlet" name="frm" method="post" id="roomFrm">
				<input type="hidden" name="command" value="Reservation_save" class="command"/>
				<input type="hidden" name="originCheckIn" value="${originCheckIn}" id="originCheckIn"/> 
				<input type="hidden" name="originCheckOut" value="${originCheckOut}" id="originCheckOut"/>

				<c:forEach var="room" items="${roomList }">
					<div class="record">
						<div class="roomImg">
							<img src="${room.img}" />
						</div>
						<div class="room_info">
							<div class="roomName">
								<a href="HotelServlet?command=room_list&num=${room.roomNum}">${room.roomName}</a>
							</div>
							<div class="rommViewAndPerson">
								<span>전망 ${room.viewType}</span> <span>최대인원수
									${room.roomCapacity}명</span> <span>침대타입 ${room.roomType} <img
									src="image/bed.png" alt="침대사진" /></span>
							</div>
							<div class="roomPrice">
								<span><fmt:formatNumber type="currency"
										value="${room.roomPrice}" currencySymbol="￦" /> KRW</span>
							</div>
							<button type="button" onclick="submitFormWithRoomDetails('${room.roomNum}', '${room.roomName}','${room.img}' ,'${room.roomPrice}')">예약하기</button>
						</div>
					</div>
				</c:forEach>
			</form>
		</div>
	</div>

	<div class="background">
		<div class="detailSearch">

			<!-- header : 객실 필터 div title로 객실 필터, 창을 닫는 x버튼을 우측 상단에 만들어서 css값이 리셋이 될 수 있도록 작성 -->
			<header class="detailSearch-modal-head">
				<h2 class="detailSearch-modal-title">객실필터</h2>
				<!-- ??? 닫기버튼 어떻게 -->
				<button type="button" class="closeButton"
					onclick="closeButton('.background')">
					<i class="fa-solid fa-xmark"></i>
				</button>
			</header>

			<form action="HotelServlet" method="post" name="frm" id="sortFrm">
				<input type="hidden" name="command" value="detail_search"
					class="command" />
				<div class="detailSerach_sort">
					<!-- body영역 정렬 기준 : 낮은 가격순, 높은 가격순 = 가격을 가져와서 asc, desc 하는 정렬 sql구문을 사용해서 정렬해준다.
                  오름 차순 : ASC 내림차순 : DESC -->
					<p class="title">정렬기준</p>
					<div class="sortButton">
						<div class="price-btn">
							<input type="radio" id="rowSort" name="fee" value="asc"
								checked="checked"> <label for="rowSort"
								class="sort_label">낮은 가격 순</label>
						</div>
						<div class="price-btn">
							<input type="radio" id="highSort" name="fee" value="desc">
							<label for="highSort" class="sort_label">높은 가격 순</label>
						</div>
					</div>
				</div>


				<div class="column">
					<!-- 뷰타입 : 오션, 시티, 하버
               = viewtype을 select해서 DB에서 조건에 맞는 내용을 가져와서 [???]값에 저장  -->
					<p class="title">뷰타입</p>
					<div class="view-btn-area typeBtn">
						<div class="view-btn">
							<input type="checkbox" name="view" id="view_city" value="시티뷰" />
							<label for="view_city" class="type_label"># 시티뷰</label>
						</div>
						<div class="view-btn">
							<input type="checkbox" name="view" id="view_ocean" value="오션뷰" />
							<label for="view_ocean" class="type_label"># 오션뷰</label>
						</div>
						<div class="view-btn">
							<input type="checkbox" name="view" id="view_haver" value="하버뷰" />
							<label for="view_haver" class="type_label"># 하버뷰</label>
						</div>
					</div>
				</div>

				<div class="column">
					<p class="title">침대 타입</p>
					<!-- 근데 이거 다중선택하게 어떻게 함? -->
					<div class="room-btn-area typeBtn">
						<div class="room-btn">
							<input type="checkbox" name="room" id="room_double" value="더블" />
							<label for="room_double" class="type_label"># 더블</label>
						</div>
						<div class="room-btn">
							<input type="checkbox" name="room" id="room_twin" value="트윈" />
							<label for="room_twin" class="type_label"># 트윈</label>
						</div>
						<div class="room-btn">
							<input type="checkbox" name="room" id="room_family" value="패밀리" />
							<label for="room_family" class="type_label"># 패밀리</label>
						</div>
					</div>
				</div>
				<div class="detailSerach-modal-foot">
					<button type="reset" class="reset-btn" onclick="resetButton()">
						<span>초기화</span>
					</button>
					<button type="submit" class="confirm-btn" form="sortFrm"
						onclick="submitForm('.background')">
						<span>적용</span>
					</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>