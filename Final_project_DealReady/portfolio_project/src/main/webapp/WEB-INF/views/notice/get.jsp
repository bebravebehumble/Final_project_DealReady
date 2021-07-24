<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<head>
<title><c:out value="${notice.title }" />: 공지사항</title>
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mainBar.jsp"%>
<div>
	<div class="post">
		<div class="form">
			<div class="post-info">
				<p style="color: #F78181;">공지사항</p>
				<p><b style="font-size: 25px;"><c:out value="${notice.title }" /></b></p>
				<p>딜레디</p>
				<article style="text-align: right; color: #A4A4A4">작성일: <fmt:formatDate
				 value="${notice.regDate }" type="both" dateStyle="long" /></article>
				<c:if test="${notice.regDate!=notice.updateDate }">
					<article style="text-align: right; color: #A4A4A4">수정일: <fmt:formatDate
						value="${notice.updateDate }" type="both" dateStyle="long" /></article>
				</c:if>
			</div>
			<div class="post-content">
				<p style="white-space: pre-wrap;"><c:out value="${notice.content }" /></p>
			</div>
			<br />
			<br />
			<div>
				<sec:authentication property="principal" var="pinfo" />
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq notice.writer }">
				<button data-oper="modify" class="btn-default">수정</button>
					</c:if>
				</sec:authorize>
				<button data-oper="list" class="btn-default">목록</button>
			</div>
			
			<form id='operForm' action="/notice/modify" method="get">
				<input type="hidden" id='bno' name='bno' value="${notice.bno }">
			</form>
		</div>
	</div>
</div>
</body>


<script>
$(document).ready(function() {
	// reply.js에 csrf 값을 보내기 위한 처리
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});


	var operForm = $("#operForm");
	$('button[data-oper="modify"]').on("click", function(e) {	// 수정 버튼 클릭 시
		operForm.attr("action", "/notice/modify").submit();
	});
	$('button[data-oper="list"]').on("click", function(e) {	// 목록 버튼 클릭 시
		operForm.find("#bno").remove();
		operForm.attr("action", "/notice/list").submit();
	});
})
</script>

<%@ include file="../includes/footer.jsp"%>