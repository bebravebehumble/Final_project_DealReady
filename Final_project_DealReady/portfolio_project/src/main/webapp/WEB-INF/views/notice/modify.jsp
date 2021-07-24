<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>공지 수정: 공지사항</title>
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/form/qnaForm.css">
<link rel="stylesheet" href="/resources/css/attach/attach.css">
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mainBar.jsp"%>
	<div>
		<div class="title">
			<b style="font-size: 30px;">공지 수정</b>
		</div>
		<div class="form2">
			<div align="center">
				<form role="form" action="/notice/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="bno" value="${notice.bno }">
					<input type="hidden" name="writer" value="${notice.writer }">
					<div>
						<input type="text" name="title"
							value='<c:out value="${notice.title }" />' size="60">
						<!-- 100글자 초과할 시 모달창 띄우는 기능 구현 필요(script) -->
					</div>
					<br />
					<div>
						<textarea rows="20" cols="62"
							name="content"><c:out value="${notice.content }"/></textarea>
					</div>
					<br />
					<button type="submit" data-oper='modify' class="btn-default">완료</button>
					<button type="submit" data-oper='remove' class="btn-default">삭제</button>
					<button type="button" data-oper='back' class="btn-default">뒤로</button>
					<button type="button" data-oper='list' class="btn-default">목록</button>
				</form>
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

	var formObj = $("form");
	// 버튼 동작 구현
	$('button').on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log("operation: " + operation);

		if (operation === 'remove') {	// 삭제 버튼
			if (confirm("해당 공지를 삭제하시겠습니까?") == true) {
				formObj.attr("action", "/notice/remove");
			} else {
				e.preventDefault();
				return false;
			}
		} else if (operation === 'back') {	// 뒤로 버튼
			history.back(-1);
			return;
		} else if (operation === 'list') {	// 목록 버튼
			formObj.attr("action", "/notice/list").attr("method", "get");
		}
		formObj.submit();
	});

})
</script>

<%@ include file="../includes/footer.jsp"%>