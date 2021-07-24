<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>공지 작성: 공지사항</title>
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/form/qnaForm.css">
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
			<b style="font-size: 30px;">공지 작성</b>
		</div>
		<div class="form2">
			<div align="center">
				<form role="form" action="/notice/register" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<div>
						<input id="regTitle" type="text" name="title"
							placeholder="제목을 입력해 주세요">
					</div>
					<br />
					<div>
						<input id="regWri" type="text" name="writer"
							value='<sec:authentication property="principal.username"/>'
							readonly="readonly">
					</div>
					<br />
					<div>
						<textarea id="regCon" name="content"
							placeholder="내용을 입력해 주세요"></textarea>
					</div>
					<br />
					<button type="submit" class="btn-default" id="regSub-btn">등록</button>
					<button type="reset" class="btn-default">다시</button>
					<button type="button" class="btn-default" onclick="history.back(-1);">뒤로</button>
				</form>
			</div>
		</div>
	</div>
</body>

<script>
$(document).ready(function(e) {
	// 게시글 제목 글자 수
	$('#regTitle').on('keyup', function() {
		if ($(this).val().length > 60) {
			$(this).val($(this).val().substring(0, 60));
			alert("공지 제목은 최대 60글자까지 입력 가능합니다.");
		}
	});


	// 게시글 내용 글자 수
	$('#regCon').on('keyup', function() {
		if ($(this).val().length > 1300) {
			$(this).val($(this).val().substring(0, 1300));
			alert("공지 내용은 최대 1300글자까지 입력 가능합니다.");
		}
	});


	// 입력 없이 등록 버튼 눌렀을 때
	var formObj = $("form[role='form']");
	$("#regSub-btn").on("click", function(e) {
		if ($("#regTitle").val().length == 0) {
			$(this).val($(this).val().substring(0, 0));
			e.preventDefault();
			alert("제목을 입력해 주세요.");
		} else if ($("#regCon").val().length == 0) {
			$(this).val($(this).val().substring(0, 0));
			e.preventDefault();
			alert("내용을 입력해 주세요.");
		}
	});
	
})
</script>

<%@ include file="../includes/footer.jsp"%>