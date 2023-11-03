<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHARD그룹 시그니드</title>
<link rel="stylesheet" href="css/main.css">
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="hotel-datepicker-main/dist/css/hotel-datepicker.css">
<script src="hotel-datepicker-main/dist/fecha.js"></script>
<script src="hotel-datepicker-main/fecha-4.2.1/dist/fecha.min.js"></script>
<script src="hotel-datepicker-main/dist/js/hotel-datepicker.js"></script>
<script src="js/search.js"></script>
<script src="js/slide.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap"
	rel="stylesheet">
	<script>
	//default date 입력
	$(function() {
	   // 서버에서 현재 날짜를 가져오는 요청
	   $.ajax({
	      url: 'HotelServlet?command=get_date',
	      type: 'get',
	      success: function(response) {
	         var date1 = response.dateView;	
	         var date2 = response.dateView2;
	         dateIn = response.dateIn;
	         dateIn2 = response.dateIn2;
	         console.log(dateIn);
	     	 console.log(dateIn2);
	         // 가져온 현재 날짜를 이미 존재하는 dateView 엘리먼트에 넣어줌
	         $('.date_day').eq(0).text(date1);
	         $('.date_day').eq(1).text(date2);
	      },
	      error: function() {
	         console.log("에러 발생");
	      }
	   });
	});
	</script>
</head>
<body>
	<script type="text/javascript">
		var result = ${result};
		if(result == 1){
			alert("예약이 취소되었습니다.");
			location.href="index.jsp";
		}else if(result == 2){
			alert("예약이 완료되었습니다.");
		}
	</script>

	<jsp:include page="header.jsp" />

	<div class="slideWrap">
		<div class="slider">
			<img src="slider/img1.webp" alt="슬라이더이미지1">
			<img src="slider/img2.webp" alt="슬라이더이미지1"> 
			<img src="slider/img3.webp" alt="슬라이더이미지1">
		</div>
	</div>
</body>
</html>