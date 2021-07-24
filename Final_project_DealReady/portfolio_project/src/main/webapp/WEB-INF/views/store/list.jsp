<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>상품 목록: 내 상점</title>
<link rel="stylesheet" href="/resources/css/table/storeListTb.css">
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/modal/modal.css">
<link rel="stylesheet" href="/resources/css/paging/pageList.css">
<link rel="stylesheet" href="/resources/css/form/searchForm.css">
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mainBar.jsp"%>
<div>
	<div class="table-s">
		<div>
			<div align=center>
				<h1>
					<a href="/store/list" style="text-decoration: none; color: #2E2E2E;">상품 목록</a>
				</h1>
			<br />
				<table>
					<thead>
						<tr>
							<td>상품 번호</td>
							<td colspan="2" class="pd-info">상품 정보</td>
							<td>상품 금액</td>
							<td>거래 현황</td>
							<td>상품 수정</td>
						</tr>
					</thead>
					<tbody>
						<c:choose>
						<c:when test="${total == 0 }">
							<tr>
								<td colspan="6" class="pd-none"><p>등록하신 상품이 없습니다.</p></td>
							</tr>
						</c:when>
						<c:otherwise>
						<c:forEach var="store" items="${store }">
							<tr class="pd-detail">
								<td class="pd-pdId"><c:out value="${store.pdId }" /></td>
								<td id="img${i=i+1 }" class="pd-img"></td>
								<td id="Detail${i }" class="detail td-detail"
									data-pno="${store.pno }" data-pdid="${store.pdId }">
									<p class="pd-title"><c:out value="${store.title }"/></p>
									<p><c:out value="${store.pdStock }"/>개 / <img
										src="/resources/img/seepw.png" width="20"><c:out
										value="${store.readCnt }"/></p>
									<p><fmt:formatDate pattern="yyyy-MM-dd"
										value="${store.regDate }"/></p>
								</td>
								<td><fmt:formatNumber value="${store.pdPrice }" pattern="###,###,###" />원</td>
								<td><p>양도 대기 중</p></td>
								<td><button id="modifyBtn" class="modi-btn"
									data-pno="${store.pno }" data-pdid="${store.pdId }">수정</button></td>
							</tr>
						</c:forEach>
						</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div align="right">
					<button type="button" id="regBtn" class="qnaBtn">상품 등록</button>
				</div>
			</div>
		</div>

		<form id="actionForm" action="/store/list" method="get">
		</form>
	</div>
</div>

<!-- 등록 완료 안내창 -->
<div class="regModal" id="pdModal" tabindex="-1" role="dialog"
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
</body>


<script>
$(document).ready(function() {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});

	var actionForm = $("#actionForm");

	$("#regBtn").on("click", function(e) {
		e.preventDefault();
		self.location = "/store/upload";
	});

	$(document).on("click", "#modifyBtn", function(e) {
		e.preventDefault();
		var pno = $(this).data("pno");
		var pdId = $(this).data("pdid");
		console.log(pno);
		console.log(pdId);
		actionForm.append("<input type='hidden' name='pno'"
				+ " value='" + pno + "'>");
		actionForm.append("<input type='hidden' name='pdId'"
				+ "value='" + pdId + "'>");
		actionForm.attr("action", "/store/modify");
		actionForm.submit();
	});

	var result = '<c:out value="${result}"/>';
	// 글 등록 완료 모달창 동작
	checkModal(result);
	function checkModal(result) {
		if (result === '') {
			return;
		}
		if (result === "upload") {
			$(".modal-header").html("상품 등록");
			$(".modal-body").html("상품이 등록되었습니다.");
		} else if (result === "success") {
			$(".modal-header").html("상품 수정");
			$(".modal-body").html("상품이 수정되었습니다.");
		} else if (result === "deleted") {
			$(".modal-header").html("상품 삭제");
			$(".modal-body").html("상품이 삭제되었습니다.");
		}
		$("#pdModal").attr("style", "display: block");
	};


	// 글 등록 완료 모달창 닫기 버튼
	$("#modalCloseBtn").on("click", function(e) {
		$("#pdModal").attr("style", "display: none");
	});


	// 페이지 유지
	$(document).on("click", ".detail", function(e) {
		var pno = $(this).data("pno");
		e.preventDefault();
		actionForm.append("<input type='hidden' name='pno'"
				+ " value='" + pno + "'>");
		actionForm.attr("action", "/store/goods");
		self.location = "/store/goods/" + pno;
		actionForm.submit();
	});


	// 이미지 불러오기
	(function getImg() {
		var storeCnt = $("table tbody tr").length;
		console.log(storeCnt);
		for (var i=1; i<=storeCnt; i++) {
			var detail = $("#Detail" + i);
			var pdId = detail.data("pdid");
			var imgtd = $("#img" + i);
			var imgid = imgtd.selector;
			append(imgid, pdId);
		}
	})();

	function append(imgid, pdId) {
		$.getJSON("/store/getImgList", {pdId:pdId}, function(arr) {
			if (arr.length == 0) {
				return false;
			}
			var img = arr[0];
			var str = "";
			var fileCallPath
			= encodeURIComponent(img.uploadPath + "\\s_" + img.uuid + "_" + img.fileName);
			str += "<img src='/detail?fileName=" + fileCallPath + "'>";
			$(imgid).html(str);
		});
	}
	
})
</script>

<%@ include file="../includes/footer.jsp"%>