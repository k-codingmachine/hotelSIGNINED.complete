function ReservationCheck() {
	if (document.frm.email.value.length == 0) {
		alert("예약자 이메일 확인해주세요.");
		return false;
	}

	if ($('#email').val() == "") {
		alert("예약번호는 필수입력입니다.");
		return false;
	}
	return true;
}

function open_win(url, name) {
	window.open(url, name, "width = 500, height=300, resizeable = no");
}

function ReservationPassCheck() {
	if (document.frm.pass.value.length == 0) {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	return true;
}
