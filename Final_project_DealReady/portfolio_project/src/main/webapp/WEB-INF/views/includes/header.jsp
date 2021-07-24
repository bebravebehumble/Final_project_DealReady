<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<link rel="stylesheet" href="/resources/css/div/header.css">
<div align="right" class="header-div">
	<ul>
		<sec:authorize access="isAuthenticated()">
			<li>
				<span>안녕하세요, <sec:authentication
					property="principal.username"/> 님&nbsp;&nbsp;&nbsp;</span>
			</li>
			<li><a id="logout">로그아웃&nbsp;&nbsp;&nbsp;</a></li>
			<li><a href="/myPage">마이페이지</a></li>
		</sec:authorize>
		<sec:authorize access="isAnonymous()">
			<li><a href="/customLogin">로그인</a></li>
			<li>/</li>
			<li><a href="/join">회원가입</a></li>
		</sec:authorize>
	</ul>
</div>

<script>
$(document).ready(function() {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});

	// 로그아웃
	$("#logout").on("click", function(e) {
		if (confirm("로그아웃하시겠습니까?") == true) {
			$.ajax({
				type: "POST",
				url: "/logout",
				success: function(data) {
					alert("로그아웃되었습니다.");
					document.location.reload();
				}
			});
		} else {
			e.preventDefault();
			return false;
		}
	});
	
}) 
</script>