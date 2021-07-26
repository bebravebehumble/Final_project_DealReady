<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>딜레디: 공지사항</title>
<link rel="stylesheet" href="/resources/css/table/noticeTb.css">
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/modal/modal.css">
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
					<a href="/notice/list" style="text-decoration: none; color: #2E2E2E;">공지사항</a>
				</h1>
			<br />
				<table class="notice" id="listTb">
					<thead>
						<tr>
							<th>번호</th>
							<th class="th-title">제목</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<c:forEach var="board" items="${list }">
					<tbody id="listBody">
						<tr>
							<td><c:out value="${num=num-1 }" /></td>
							<td class="td-title"><a href="${board.bno }" class="move"><c:out
										value="${board.title }" /></a>&nbsp;
							</td>
							<td><fmt:formatDate pattern="yyyy.MM.dd"
									value="${board.regDate }" /></td>
							<td><c:out value="${board.readCnt }" /></td>
						</tr>
					</tbody>
					</c:forEach>
				</table>
				<button id="moreListBtn" class="more-btn">더보기</button>
				<button id="listResetBtn" class="more-btn">접기</button>
				<br />
				<sec:authentication property="principal" var="pinfo" />
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.authorities == '[admin]' }">
						<button id="regBtn" class="noti-regi-btn">공지 작성</button>
					</c:if>
				</sec:authorize>
			</div>
		</div>
		<form id="actionForm" action="/notice/list" method="get">
		</form>
	</div>
</div>

<!-- 등록 완료 안내창 -->
<div class="regModal" id="notiModal" tabindex="-1" role="dialog"
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
	var pinfo = '<c:out value="${pinfo}"/>';
	console.log("pinfo: " + pinfo);

	$("#regBtn").on("click", function(e) {
		e.preventDefault();
		self.location = "/notice/register";
	});
	
	var result = '<c:out value="${result}"/>';
	// 글 등록 완료 모달창 동작
	checkModal(result);
	function checkModal(result) {
		if (result === '') {
			return;
		}
		if (parseInt(result) > 0) {
			$(".modal-header").html("공지 등록");
			$(".modal-body").html("공지가 등록되었습니다.");
		} else if (result === "success") {
			$(".modal-header").html("공지 수정");
			$(".modal-body").html("공지가 수정되었습니다.");
		} else if (result === "deleted") {
			$(".modal-header").html("공지 삭제");
			$(".modal-body").html("공지가 삭제되었습니다.");
		}
		$("#notiModal").attr("style", "display: block");
	};


	// 글 등록 완료 모달창 닫기 버튼
	$("#modalCloseBtn").on("click", function(e) {
		$("#notiModal").attr("style", "display: none");
	});


	// 페이지 유지
	var actionForm = $("#actionForm");
	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno'"
				+ " value='" + $(this).attr("href") + "'>");
		actionForm.attr("action", "/notice/get");
		actionForm.submit();
	});


	// 더보기 목록 게시물 시각 표시
	function regdate(timeValue) {
		var today = new Date();
		var dateObj = new Date(timeValue);

		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1;
		var dd = dateObj.getDate();

		return [yy, '.', (mm>9?'':'0')+mm, '.'
			, (dd>9?'':'0')+dd].join('');
	}


	// 목록 더보기 버튼
	var startNum = $("#listBody tr").length+1;
	var totalCnt = '<c:out value="${totalCnt}"/>';
	var total = totalCnt;
	var bno = '<c:out value="${board.bno}"/>';
	var title = '<c:out value="${board.title}"/>';
	var regDate = '<c:out value="${board.regDate}"/>';
	var readCnt = '<c:out value="${board.readCnt}"/>';
	var clickCnt = 0;

	if (startNum > 9) {
		$("#moreListBtn").css("display", "block");
	}
	$("#moreListBtn").on("click", function(e) {
		console.log(total);
		clickCnt = clickCnt + 1;
		var data = {startNum: startNum};
		var str = "";
		if (startNum+9 >= totalCnt) {
			$("#moreListBtn").css("display", "none");
		}
		$.ajax({
			url: "/notice/list",
			type: "POST",
			dataType: "JSON",
			data: data,
			success: function(result) {
				if (clickCnt == 1) {
					total = total - 9;
				}
				if (result.length < 10) {
					$("#moreListBtn").css("display", "none");	
				}
				if (result.length > 0) {
					for (var i=0; i<result.length; i++) {
						str += "<tr id='moreNoti'><td>" + (total=total-1) + "</td>";
						str += "<td class='td-title'><a href='" + result[i].bno;
						str += "' id='listTitle'>" + result[i].title + "</td>";
						str += "<td>" + regdate(result[i].regDate) + "</td>";
						str += "<td>" + result[i].readCnt + "</td></tr>";
					}
					$("#listTb tbody tr:last").after(str);
					startNum += 10;

					// 접기 버튼
					if (startNum >= 20) {
						$("#listResetBtn").css("display", "block");
					}
					$("#listResetBtn").on("click", function(e) {
						total = totalCnt;
						clickCnt = 0;
						$("#listTb tr[id='moreNoti']").remove();
						$("#listResetBtn").css("display", "none");
						startNum = $("#listBody tr").length+1;
						if (startNum > 9) {
							$("#moreListBtn").css("display", "block");
						}
					});
				}
			}
		});

	});


	// 비동기로 추가된 목록 제목 누를 시
	$(document).on("click", "#listTitle", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno'"
				+ " value='" + $(this).attr("href") + "'>");
		actionForm.attr("action", "/notice/get");
		actionForm.submit();
	});

})
</script>

<%@ include file="../includes/footer.jsp"%>
