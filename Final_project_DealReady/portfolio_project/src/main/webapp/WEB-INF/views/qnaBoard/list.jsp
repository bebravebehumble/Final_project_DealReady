<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>딜레디: 궁그미 게시판</title>
<link rel="stylesheet" href="/resources/css/table/qnaTb.css">
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
	<div class="table">
		<div>
			<div align=center>
				<h1>
					<a href="/qnaBoard/list" style="text-decoration: none; color: #2E2E2E;">궁그미 게시판</a>
				</h1>
			<br />
				<sec:authentication property="principal" var="principal"/>
				<table class="qna">
					<thead>
						<tr>
							<th>번호</th>
							<th class="th-title">제목</th>
							<th class="th-writer">작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${pageMaker.total==0 }">
							<tr>
								<td colspan="5" style="padding: 100px 450px;"><b>검색 결과가 존재하지 않습니다.</b>
								<br/><button type="button" class="b-btn" onclick="history.back(-1);">이전으로</button></td>
							</tr>
						</c:if>
						<c:set var ="cnt" value="${cnt }" />
						<c:forEach var="board" items="${list }">
							<tr>
								<td>
									<c:choose>
										<c:when test="${pageMaker.cri.pageNum==1 }">
											<c:out value="${cnt }" />
										</c:when>
										<c:otherwise>
											<c:out value="${cnt-(pageMaker.cri.pageNum-1)*15 }"/>
										</c:otherwise>
									</c:choose>
								</td>
								<td class="td-title"><a href="${board.bno }" class="move"><c:out
											value="${board.title }" /></a>
									<c:if test="${board.replyCnt ne 0 }">
										<span style="color: #F78181;">[<c:out value="${board.replyCnt }"/>]</span>
									</c:if>
								</td>
								<td><c:out value="${board.writer }" /></td>
								<td><fmt:formatDate pattern="yyyy.MM.dd"
										value="${board.regdate }" /></td>
								<td><c:out value="${board.readCount }" /></td>
							</tr>
							<c:set var="cnt" value="${cnt-1 }" />
						</c:forEach>
					</tbody>
				</table>

				<!-- 검색 기능 시작 -->
				<div align="right" class="search">
					<div>
						<form id="searchForm" action="/qnaBoard/list" method="get">
							<select name="type" style="padding: 5px; font-size: 15px;">
								<option value="" ${pageMaker.cri.type==null? "selected" : "" }></option>
								<option value="T" ${pageMaker.cri.type eq "T"? "selected" : "" }>
								제목</option>
								<option value="W" ${pageMaker.cri.type eq "W"? "selected" : "" }>
								작성자</option>
								<option value="C" ${pageMaker.cri.type eq "C"? "selected" : "" }>
								내용</option>
							</select>
							<input type="text" name="keyword" value="${pageMaker.cri.keyword }"
								class="searchBox">
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
							<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
							<button id="searchBtn" class="s-Btn">검색</button>&nbsp;&nbsp;&nbsp;
							<button id="regBtn" class="qnaBtn">질문하기</button>
						</form>
					</div>
				</div>
				<!-- 검색 기능 끝 -->

			</div>
		</div>

		<!-- 페이징 -->
		<div align=center>
			<ul>
				<c:if test="${pageMaker.prev }">
					<li class="page-item"><a class="page-link" href="${pageMaker.realStart }">≪</a></li>
					<li class="page-item"><a class="page-link" href="${pageMaker.startPage-1 }">＜</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li class="page-item"><c:choose><c:when
							test="${pageMaker.cri.pageNum eq num }"><b
							class="link-choice">${num }</b></c:when>
							<c:otherwise><a class="page-link"
								href="${num }">${num }</a></c:otherwise></c:choose></li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1 }">＞</a></li>
					<li class="page-item"><a class="page-link" href="${pageMaker.realEnd }">≫</a></li>
				</c:if>
			</ul>
		</div>

		<form id="actionForm" action="/qnaBoard/list" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</form>
	</div>
</div>

<!-- 등록 완료 안내창 -->
<div class="regModal" id="qnaModal" tabindex="-1" role="dialog"
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
	// 글 작성 버튼
	var principal = "<c:out value='${principal}'/>";
	$("#regBtn").on("click", function(e) {
		e.preventDefault();
		if (principal == "anonymousUser") {
			if (confirm("궁그미 게시판 질문 작성은 로그인 후 가능합니다. 로그인 페이지로 이동하시겠습니까?") == true) {
				self.location = "/customLogin";
			} else {
				return false;
			}
		} else {
			self.location = "/qnaBoard/register";
		}
	});


	var result = '<c:out value="${result}"/>';
	// 글 등록 완료 모달창 동작
	checkModal(result);
	function checkModal(result) {
		if (result === '') {
			return;
		}
		if (result === "upload") {
			$(".modal-header").html("질문 등록");
			$(".modal-body").html("질문이 등록되었습니다.");
		} else if (result === "success") {
			$(".modal-header").html("질문 수정");
			$(".modal-body").html("질문이 수정되었습니다.");
		} else if (result === "deleted") {
			$(".modal-header").html("질문 삭제");
			$(".modal-body").html("질문이 삭제되었습니다.");
		}
		$("#qnaModal").attr("style", "display: block");
	};


	// 글 등록 완료 모달창 닫기 버튼
	$("#modalCloseBtn").on("click", function(e) {
		$("#qnaModal").attr("style", "display: none");
	});


	// 페이징 번호 활성화
	var actionForm = $("#actionForm");
	
	$(".page-item a").on("click", function(e) {
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});


	// 페이지 유지
	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno'"
				+ " value='" + $(this).attr("href") + "'>");
		actionForm.attr("action", "/qnaBoard/get");
		actionForm.submit();
	});


	// 검색 기능
	var searchForm = $("#searchForm");
	$("#searchBtn").on("click", function(e) {
		e.preventDefault();
		if (!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택해 주세요.");
			return false;
		}
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("검색어를 입력해 주세요.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val(1);
		searchForm.submit();
	});
	
})
</script>

<%@ include file="../includes/footer.jsp"%>
