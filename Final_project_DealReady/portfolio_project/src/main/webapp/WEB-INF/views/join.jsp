<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>딜레디: 회원가입</title>
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/login/joinForm.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/mainBar.jsp"%>
	<div>
		<div style="width: 1020px; height: auto; margin: 50px auto 10px auto;
			padding: 10px; border-bottom: 1px solid #A4A4A4;">
			<b style="font-size: 30px;">회원가입</b>
		</div>
		<div style="width: 900px; height: auto; margin: 0px auto 70 auto; padding: 40 70px;
			border: 1.5px solid #D8D8D8; border-radius: 0.5em;">
			<div>
				<form class="joinForm" role="form" action="/join" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<div>
						아이디 <input type="text" name="userid" required
							id="userid"> <small>(영문자 또는 영문자/숫자 5~15자)</small>
							<span id="ava" class="check-g">사용 가능한 아이디입니다.</span>
							<span id="over" class="check-r">이미 존재하는 아이디입니다.</span>
							<span id="impo" class="check-r">사용할 수 없는 아이디입니다.</span>
					</div>
					<div>
						비밀번호 <input type="password" name="userpw" required
							id="password"><img src="/resources/img/seepw.png" id="seePw"
							class="see-pw"><img src="/resources/img/noSeePw.png" id="noSeePw" class="no-see-pw">
							<small>(영문자/숫자/특수문자(!@#$%^&*~ 중) 8~20자)</small>
						<span id="impopw" class="check-r">비밀번호를 양식에 맞춰 설정해 주세요.</span>
					</div>
					<div>
						비밀번호 확인 <input type="password" name="pwcheck" id="pwCheck" required>
						<span id="checkOk" class="check-g">비밀번호가 일치합니다.</span>
						<span id="checkNo" class="check-r">비밀번호가 일치하지 않습니다.</span>
					</div>
					<div>
						이름 <input type="text" name="userName" id="name" required>
					</div>
					<div>
						닉네임 <input type="text" name="userNick"
							id="nickName" required> <small>(한글(숫자) 또는 영문자(숫자) 또는 한글/영문자(숫자) 3~15자)</small>
						<span id="impoNick" class="check-r">닉네임을 양식에 맞춰 설정해 주세요.</span>
					</div>
					<div>
						이메일 <input type="text" name="userMail" id="mailCheck" required>
						<span id="notMail" class="check-r">이메일 형식에 맞게 작성해 주세요.</span>
					</div>
					<div>
						우편번호 <input type="text" name="userAdd" id="postcode" readonly="readonly" required>
						<button type="button" id="addressBtn" class="add-btn">주소 찾기</button>
					</div>
					<div>
						<input type="text" name="userAdd1" id="userAdd" class="user-add"
							placeholder="주소" readonly="readonly" required>
					</div>
					<div>
						<input type="text" name="userAdd2" id="userAdd1" class="user-add" placeholder="상세 주소">
					</div>
					<br />
					<div align="center">
						<button type="submit" class="btn-default" id="join-btn">가입</button>
						<button type="reset" class="btn-default">다시</button>
						<button type="button" class="btn-default" onclick="history.back(-1);">뒤로</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function(e) {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});


	// 아이디를 기입했을 때
	var idReg = /^(?=.*[a-z])[a-z0-9]{5,15}$/i;
	$("#userid").change(function() {
		var userid = $(this).val();

		// 아이디 문자, 길이 제한
		if (userid != '') {
			if (!idReg.test(userid)) {
				alert("아이디는 영문자 혹은 영문자와 숫자로 이루어진 5~15자여야 합니다.");
				$("#ava").css("display", "none");
				$("#over").css("display", "none");
				$("#impo").css("display", "block");
				$(this).focus();
				return false;
			}
		}

		// 아이디 중복 확인
		var data = {userid: userid}
		// {컨트롤러에 넘기는 이름: 데이터}
		$.ajax({
			type: "post",
			url: "/useridCk",
			data: data,
			success: function(result) {
				if (result != 'find') {
					$("#ava").css("display", "block");
					$("#over").css("display", "none");
					$("#impo").css("display", "none");
				} else {
					$("#over").css("display", "block");
					$("#ava").css("display", "none");
					$("#impo").css("display", "none");
				}
			}
		});
	});


	// 비밀번호 양식 확인
	var pwReg = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*~])[a-z0-9!@#$%^&*~]{5,15}$/i;
	$("#password").change(function() {
		var password = $(this).val();
		if (!pwReg.test(password)) {
			alert("비밀번호는 영문자와 숫자, 특수문자(!@#$%^&*~ 중 선택)로 이루어진 8~20자여야 합니다.");
			$("#impopw").css("display", "block");
			$(this).focus();
			return false;
		} else {
			$("#impopw").css("display", "none");
		}
	});


	// 비밀번호 일치 확인
	$("#pwCheck").on('focus', function() {
		if ($("#password").val() == '') {
			alert("비밀번호를 먼저 입력해 주세요.");
			$("input[name='userpw']").focus();
			return false;
		}
	});

	$("#pwCheck").on('blur', function() {
		if (($("#password").val() && $(this).val()) != '') {
			if ($("#password").val() == $(this).val()) {
				$("#checkOk").css("display", "block");
				$("#checkNo").css("display", "none");
			} else {
				$("#checkNo").css("display", "block");
				$("#checkOk").css("display", "none");
				return false;
			}
		}
	});
	

	// 이메일 양식 확인
	var mailReg = /^[a-zA-Z0-9]([-_\.]?[a-zA-Z0-9])*@[a-z0-9]([-_\.]?[a-z0-9])*\.[a-z]{2,3}$/;
	$("#mailCheck").on('blur', function() {
		var mailCheck = $(this).val();
		if (mailCheck != '') {
			if (!mailReg.test(mailCheck)) {
				$("#notMail").css("display", "block");
				return false;
			} else {
				$("#notMail").css("display", "none");
			}
		}
	});


	// 이름 길이 설정
	$("#name").on('keyup', function() {
		if ($(this).val().length > 15) {
			$(this).val($(this).val().substring(0, 15));
			alert("이름은 15자 이내로 입력 가능합니다.");
			return false;
		}
	});


	// 닉네임 길이, 양식 설정
	$("#nickName").on('keyup', function() {
		if ($(this).val().length > 15) {
			$(this).val($(this).val().substring(0,15));
			alert("닉네임은 15자 이내로 입력 가능합니다.");
			return false;
		}
	});

	var nickAlNeReg = /^(?=.*[a-z])[a-z0-9]{3,15}/i;
	var nickHanNeReg = /^(?=.*[가-힣])[가-힣0-9]{3,15}/;
	var nickHanAlReg = /^(?=.*[a-z][가-힣])[가-힣a-z0-9]{3,15}/i;
	var impoReg = /^(?=.*[ㄱ-ㅎ|ㅏ-ㅣ])/;
	var space = /\s/g;
	$("#nickName").change(function() {
		var nickName = $(this).val();

		if (impoReg.test(nickName)) {
			alert("닉네임은 자음 또는 모음을 포함할 수 없습니다.");
			$("#impoNick").css("display", "block");
			$(this).focus();
			return false;
		}
		if ($(this).val().length < 3) {
			alert("닉네임 길이가 짧습니다.");
			$("#impoNick").css("display", "block");
			$(this).focus();
			return false;
		}
		if (space.test(nickName)) {
			alert("닉네임은 공백을 포함할 수 없습니다.");
			$("#impoNick").css("display", "block");
			$(this).focus();
			return false;
		}

		if ((!nickAlNeReg.test(nickName)) && (!nickHanNeReg.test(nickName)) && (!nickHanAlReg.test(nickName))) {
			alert("닉네임은 한글 또는 영문자를 반드시 포함해야 하며, 첫 3자는 한글 또는 영문자여야 합니다.");
			$("#impoNick").css("display", "block");
			$(this).focus();
			return false;
		} else {
			$("#impoNick").css("display", "none");
		}
	});


	// 우편 번호, 주소란을 클릭할 경우
	$("#postcode").on("click", function() {
		alert("우편번호는 직접 기입할 수 없습니다. 주소 찾기 버튼을 이용해 주세요.");
	});

	$("#userAdd").on("click", function() {
		alert("기본 주소는 주소 찾기 버튼을 이용하시면 자동으로 입력됩니다. 상세 주소는 아래 입력란에 추가로 입력해 주세요.");
	});


	// 비밀번호 표시/비표시
	$("#noSeePw").on("click", function() {
		$(this).hide();
		$("#seePw").show();
		$("#password").attr("type", "text");
	});

	$("#seePw").on("click", function() {
		$(this).hide();
		$("#noSeePw").show();
		$("#password").attr("type", "password");
	});


	// 가입 버튼 이벤트
	$("#join-btn").on("click", function(e) {
		if ($("#userid").val() != '') {
			if (!idReg.test($("#userid").val())) {	// 아이디 확인
				e.preventDefault();
				alert("아이디를 확인해 주세요.");
				return false;
			}
		}
		if ($("#password").val() != '') {
			if (!pwReg.test($("#password").val())) {	// 비밀번호 확인
				e.preventDefault();
				alert("비밀번호를 확인해 주세요.");
				return false;
			}
		}
		if (($("#password").val() && $("#pwCheck").val()) != '') { // 비밀번호 확인란 확인
			if ($("#password").val() != $("#pwCheck").val()) {
				e.preventDefault();
				alert("비밀번호 확인란을 알맞게 기입했는지 확인해 주세요.");
				return false;
			}
		}
		if ($("#mailCheck").val() != '') {
			if (!mailReg.test($("#mailCheck").val())) {		// 이메일 확인
				e.preventDefault();
				alert("이메일을 확인해 주세요.");
				return false;
			}
		}

		// 닉네임 확인
		if ($("#nickName").val() != '') {
			if ((!nickAlNeReg.test($("#nickName").val())) && (!nickHanNeReg.test($("#nickName").val())) && (!nickHanAlReg.test($("#nickName").val()))) {
				e.preventDefault();
				alert("닉네임을 확인해 주세요.");
				return false;
			}
			if (impoReg.test($("#nickName").val())) {
				e.preventDefault();
				alert("닉네임을 확인해 주세요.");
				return false;
			}
			if (space.test($("#nickName").val())) {
				e.preventDefault();
				alert("닉네임을 확인해 주세요");
				return false;
			}
		}

		// 상세 주소 확인
		if ($("#userAdd1").val() == '') {
			if (confirm("상세 주소를 입력하지 않은 채 회원가입하시겠습니까?") == true) {
			} else {
				e.preventDefault();
				return false;
			}
		}
	});


	// 다음 주소 연동
	$("#addressBtn").on("click", function() {
		new daum.Postcode({
			oncomplete: function(data) {
				var add ='';
				var extraAddr = "";

				if (data.userSelectedType === 'R') {
					add = data.roadAddress;
				} else {
					add = data.jibunAddress;
				}

				if (data.userSelectedType === 'R') {
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment ==='Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					add += extraAddr;
				} else {
					add += ' ';
				}
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("userAdd").value = add;
				document.getElementById("userAdd1").focus();
			}
		}).open();
	});

});
</script>

<%@ include file="includes/footer.jsp"%>