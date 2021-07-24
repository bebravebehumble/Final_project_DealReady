<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<title>딜레디: 로그인</title>
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/login/login.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="includes/header.jsp"%>
<div>
	<div class="login-div">
		<div class="login-box">
			<div align="center">
				<form action="/login" method="post">
					<h1>LOGIN</h1>
					<br />
					<div class="id">
						ID&nbsp;&nbsp;<input type="text" name="username"
							placeholder="아이디" class="input-id">
					</div>
					<div class="pw">
						PW&nbsp;&nbsp;<input type="password" name="password"
							placeholder="비밀번호" class="input-pw">
					</div>
					<div class="error">
						${error }
					</div>
					<div align="center" style="width: 450px">
						<div class="check">
							<label><input type="checkbox" name="remember-me"> 자동 로그인</label>
							<ul>
								<li>
									<a href="/findAccount">아이디/비밀번호 찾기</a>
								</li>
							</ul>
						</div>
					</div>
					<br />
					<br />
					<div>
						<input type="submit" value="LOGIN" class="login-btn">
					</div>
					<br />
					<div>
						<span>아직 회원이 아니신가요?</span>
					</div>
					<button type="button" class="login-btn">JOIN</button>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
			</div>
		</div>
	</div>
</div>
</body>

<script>
$(document).ready(function() {
	$('input[type="submit"]').on("click", function(e) {	// login 버튼 누를 시
		if ($('input[type="text"]').val() == '') {
			alert("아이디를 입력해 주세요.");
			return false;
		}
		if ($('input[type="password"]').val() == '') {
			alert("비밀번호를 입력해 주세요.");
			return false;
		}
	});

	$('button[type="button"]').on("click", function(e) {	// join 버튼 누를 시
		self.location = "/join";
	});
})
</script>

<%@ include file="includes/footer.jsp"%>