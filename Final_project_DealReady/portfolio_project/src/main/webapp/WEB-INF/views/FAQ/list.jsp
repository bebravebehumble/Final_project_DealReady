<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>딜레디: FAQ</title>
<link rel="stylesheet" href="/resources/css/table/FAQTb.css">
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/modal/modal.css">
<link rel="stylesheet" href="/resources/css/modal/modiModal.css">
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mainBar.jsp"%>
<div>
	<div class="table">
		<div>
			<div align=center>
				<h1>
					<a href="/FAQ/list" style="text-decoration: none; color: #2E2E2E;">FAQ</a>
				</h1>
			<br />
				<table class="faq" id="listTb">
					<thead>
						<tr>
							<th>번호</th>
							<th class="th-title">제목</th>
						</tr>
					</thead>
					<c:forEach var="board" items="${faq }">
					<tbody id="listBody">
						<tr>
							<td><c:out value="${cnt=cnt-1 }" /></td>
							<td class="td-title" id="titleTd"><a href="${board.bno }" id="title"><c:out
										value="${board.title }" /></a>
							</td>
						</tr>
						<tr id="content${board.bno}" class="tr-content">
							<td colspan="2" id="conTd${board.bno }"><p style="white-space: pre-wrap;
								text-align: left;"><c:out value="${board.content }" /></p>
							<sec:authentication property="principal" var="pinfo" />
							<sec:authorize access="isAuthenticated()">
								<c:if test="${pinfo.authorities == '[admin]' }">
									<button id="modiBtn" class="modi-btn" data-bno="${board.bno }"
										data-writer="${board.writer }" data-con="${board.content }"
										data-title="${board.title }">수정</button>
									<button id="remoBtn" class="remo-btn"
										data-bno="${board.bno }" data-writer="${board.writer }">삭제</button>
								</c:if>
							</sec:authorize>
							</td>
						</tr>
					</tbody>
					</c:forEach>
				</table>
				<br />
				<sec:authentication property="principal" var="pinfo" />
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.authorities == '[admin]' }">
						<button id="regBtn" class="FAQBtn">FAQ 작성</button>
					</c:if>
				</sec:authorize>
			</div>
		</div>
		<form id="actionForm" action="/FAQ/list" method="get">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</form>
	</div>
</div>

<!-- 등록 완료 안내창 -->
<div class="regModal" id="FAQModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-content" role="document">
		<div class="modal-header"></div>
		<div class="modal-body"></div>
		<div class="modal-footer">
			<button type="button" class="modal" id="modalCloseBtn"
				data-dismiss="modal">닫기</button>
		</div>
	</div>
</div>

<!-- FAQ 수정창 -->
<div class="modiModal" id="FAQModiModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modi-content" role="document">
		<div class="modi-header">FAQ 수정</div>
		<div class="modi-body">
			<div>
				<input class="faq-title" name="FAQTi" value="FAQ 제목">
			</div>
			<div>
				<textarea id="FAQCon"></textarea>
			</div>
			
		</div>
		<div class="modi-footer">
			<button type="submit" id="modiSubBtn" class="modiMo-btn">완료</button>
			<button id="closeBtn" class="remo-btn">취소</button>
		</div>
		<form id="bnoForm">
		</form>
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


	// 글 삭제 버튼 이벤트
	var actionForm = $("#actionForm");
	$(document).on("click", "#remoBtn", function(e) {
		e.preventDefault();
		var bno = $(this).data("bno");
		var writer = $(this).data("writer");
		if (confirm("해당 FAQ를 삭제하시겠습니까?") == true) {
			actionForm.attr("action", "/FAQ/remove").attr("method", "post");
			actionForm.append("<input type='hidden' name='bno'"
					+ " value='" + bno + "'>");
			actionForm.append("<input type='hidden' name='writer'"
					+ " value='" + writer + "'>");
			actionForm.submit();
		} else {
			return false;
		}
	});


	// 글 수정 모달창
	var modal = $("#FAQModiModal");
	var bnoForm = $("#bnoForm");
	$(document).on("click", "#modiBtn", function(e) {
		e.preventDefault();
		var title = $(this).data("title");
		var writer = $(this).data("writer");
		var content = $(this).data("con");
		var bno = $(this).data("bno");
		modal.find("input").val("");
		modal.find("textarea#FAQCon").val("");
		modal.find("input[name='FAQTi']").val(title);
		modal.find("textarea#FAQCon").val(content);
		modal.attr("style", "display: block");
		bnoForm.append("<input type='hidden' name='bno'"
				+ " value='" + bno + "'>");
		bnoForm.append("<input type='hidden' name='writer'"
				+ " value='" + writer + "'>");
	});


	// 수정 완료 버튼
	$(document).on("click", "#modiSubBtn", function(e) {
		var title = modal.find("input[name='FAQTi']").val();
		var content = modal.find("textarea#FAQCon").val();
		var bno = bnoForm.find("input[name='bno']").val();
		var writer = bnoForm.find("input[name='writer']").val();

		if (title == "") {
			alert("제목을 입력해 주세요.");
			return false;
		}

		if (content == "") {
			alert("내용을 입력해 주세요.");
			return false;
		}

		actionForm.append("<input type='hidden' name='title'"
				+ " value='" + title + "'>");
		actionForm.append("<input type='hidden' name='content'"
		+ " value='" + content + "'>");
		actionForm.append("<input type='hidden' name='bno'"
				+ " value='" + bno + "'>");
		actionForm.append("<input type='hidden' name='writer'"
			+ " value='" + writer + "'>");
		actionForm.submit();

		$.ajax({
			url: "/FAQ/modify",
			type: "POST",
			dataType: "JSON",
			data: {
				title: title,
				content: content,
				bno: bno,
				writer: writer
			}
		});
		modal.hide();
		document.location.reload();
	});


	// 취소 버튼 이벤트
	$(document).on("click", "#closeBtn", function() {
		modal.attr("style", "display: none");
		bnoForm.find("input[name='bno']").remove();
		bnoForm.find("input[name='writer']").remove();
	});


	// FAQ 작성 버튼
	$("#regBtn").on("click", function(e) {
		e.preventDefault();
		self.location = "/FAQ/register";
	});

	var result = '<c:out value="${result}"/>';
	// 글 등록 완료 모달창 동작
	checkModal(result);
	function checkModal(result) {
		if (result === '') {
			return;
		}
		if (result === "success") {
			$(".modal-header").html("FAQ 등록");
			$(".modal-body").html("FAQ가 등록되었습니다.");
		} else if (result === "deleted") {
			$(".modal-header").html("FAQ 삭제");
			$(".modal-body").html("FAQ가 삭제되었습니다.");
		}
		$("#FAQModal").attr("style", "display: block");
	};


	// 글 등록 완료 모달창 닫기 버튼
	$("#modalCloseBtn").on("click", function(e) {
		$("#FAQModal").attr("style", "display: none");
	});


	// FAQ 내용 호출
	var cnt = 0;
	$(document).on("click", "#title", function(e) {
		e.preventDefault();
		cnt = cnt+1;
		var bno = $(this).attr("href");
		if ((cnt%2) == 0) {
			$("#content" + bno).hide();
		} else {
			$("#content" + bno).show();
			$("#conTd" + bno).css("padding", "50px 70px");
		}
	});

})
</script>

<%@ include file="../includes/footer.jsp"%>
