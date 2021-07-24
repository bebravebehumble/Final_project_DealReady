<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<title>딜레디: 계정 찾기</title>
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/login/login.css">
<link rel="stylesheet" href="/resources/css/div/findAcc.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="includes/header.jsp"%>
<div>
	<div class="login-div">
		<div class="login-box">
			<div align="center">
				<table>
					<tr>
						<td id="findId" class="find-id">아이디 찾기</td>
						<td>|</td>
						<td id="findPw" class="find-pw">비밀번호 찾기</td>
					</tr>
				</table>
				<br />
				<form action="/findAccount" method="post">
					<div id="idDiv" style="display: block;">
						<h1>아이디 찾기</h1>
						<br />
						<span>찾으시는 아이디와 연결된 이메일 입력해 주세요.</span>
						<div class="id">
							<input type="text" name="userMail" id="userMail"
								placeholder="이메일" class="input-id">
						</div>
					</div>
					<div id="pwDiv" style="display: none;">
						<h1>비밀번호 찾기</h1>
						<br />
						<span>비밀번호를 찾으시는 아이디와 이메일을 입력해 주세요.</span>
						<br />
						<div class="id">
							<input type="text" name="userid" id="userid"
								placeholder="아이디" class="input-id">
						</div>
						<div class="id">
							<input type="text" name="userMail" id="userMailPw"
								placeholder="이메일" class="input-id">
						</div>
					</div>
					<div>
						<input type="submit" value="FIND" id="idFindBtn"
							class="login-btn" style="display: block;">
						<input type="submit" value="FIND" id="pwFindBtn"
							class="login-btn" style="display: none;">
					</div>
					<br />
					<br />
					<div class="login-move">
						<span>로그인하러 가기</span>
					</div>
					<button type="button" data-oper="login" class="login-btn">LOGIN</button>
					<br />
					<br />
					<div>
						<span>아직 회원이 아니신가요?</span>
					</div>
					<button type="button" data-oper="join" class="login-btn">JOIN</button>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
			</div>
		</div>
	</div>
</div>
</body>

<script>
$(document).ready(function() {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});


	// 아이디 찾기, 비밀번호 찾기 메뉴 버튼
	$("#findId").on("click", function(e) {
		$("#findId").css("font-weight", "bold");
		$("#idDiv").css("display", "block");
		$("#idFindBtn").css("display", "block");
		$("#findPw").css("font-weight", "normal");
		$("#pwDiv").css("display", "none");
		$("#pwFindBtn").css("display", "none");
	});
	$("#findPw").on("click", function(e) {
		$("#findPw").css("font-weight", "bold");
		$("#pwDiv").css("display", "block");
		$("#pwFindBtn").css("display", "block");
		$("#findId").css("font-weight", "normal");
		$("#idDiv").css("display", "none");
		$("#idFindBtn").css("display", "none");
	});


	$('button').on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		
		if (operation === 'join') {	// 회원가입 버튼
			self.location = "/join";
		} else if (operation === 'login') {	// 로그인 버튼
			self.location = "/customLogin";
		}
	});


	// 아이디 찾기 버튼 클릭 이벤트
	var mailReg = /^[a-zA-Z0-9]([-_\.]?[a-zA-Z0-9])*@[a-z0-9]([-_\.]?[a-z0-9])*\.[a-z]{2,3}$/;
	$("#idFindBtn").on("click", function(e) {
		e.preventDefault();
		console.log("clicked idFindBtn");
		var userMail = $("#userMail").val();
		var data = {userMail: userMail};

		if (userMail == '') {
			alert("이메일을 입력해 주세요.");
			return false;
		}
		if (!mailReg.test(userMail)) {
			alert("이메일 양식을 확인해 주세요.");
			return false;
		}

		$.ajax({
			type: "POST",
			url: "/findAccount/id",
			data: data,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result) {
				if (result != 'not found') {
					alert("찾으시는 아이디는 " + result + "입니다.");
				} else {
					alert("해당 이메일로 가입한 아이디가 존재하지 않습니다.");
					return false;
				}
			}
		});
	});


	// 비밀번호 찾기 버튼 클릭 이벤트
	$("#pwFindBtn").on("click", function(e) {	// find 버튼 클릭 시
		e.preventDefault();
		console.log("clicked pwFindBtn");
		var userid = $("#userid").val();
		var userMailPw = $("#userMailPw").val();

		if (userid == '') {
			alert("아이디를 입력해 주세요.");
			return false;
		}
		if (userMailPw == '') {
			alert("이메일을 입력해 주세요.");
			return false;
		}
		if (!mailReg.test(userMailPw)) {
			alert("이메일 양식을 확인해 주세요.");
			return false;
		}

		var promise = $.ajax({
			type: "POST",
			url: "/findAccount/pw",
			data: {
				userid: userid,
				userMailPw: userMailPw
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			}
		});
		promise.then(successFunction);
		function successFunction(result) {
			if (result == 'found') {
				if (confirm("입력하신 이메일로 임시 비밀번호를 발급받으시겠습니까?") == true) {
					$.ajax({
						url: "/findAccount/pwMail",
						type: "POST",
						data: {
							userid: userid,
							userMailPw: userMailPw
						},
						beforeSend: function(xhr) {
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
						},
						success: function(result) {
							if (result == 'success') {
								alert("이메일로 임시 비밀번호를 발급해드렸으니 확인해 주세요.");
							} else if (result == 'fail') {
								alert("임시 비밀번호 발급 도중 문제가 발생했습니다.");
								return false;
							} else {
								alert("입력하신 정보가 정확한지 확인해 주세요.");
								return false;
							}
						}
					});
				}
			} else {
				alert("입력하신 정보가 정확한지 확인해 주세요.");
				return false;
			}
		}
	});

})
</script>

<%@ include file="includes/footer.jsp"%>