<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<head>
<title><c:out value="${board.title }" />: 궁그미 게시판</title>
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/form/qnaReForm.css">
<link rel="stylesheet" href="/resources/css/paging/qnaRePageList.css">
<link rel="stylesheet" href="/resources/css/attach/attach.css">
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
				<p style="color: #F78181;">궁그미 게시판</p>
				<p><b style="font-size: 25px;"><c:out value="${board.title }" /></b></p>
				<p><c:out value="${board.writer }" /></p>
				<article style="text-align: right; color: #A4A4A4">작성일: <fmt:formatDate
				 value="${board.regdate }" type="both" dateStyle="long" /></article>
				<c:if test="${board.regdate!=board.updateDate }">
					<article style="text-align: right; color: #A4A4A4">수정일: <fmt:formatDate
						value="${board.updateDate }" type="both" dateStyle="long" /></article>
				</c:if>
			</div>
			<div class="post-content">
				<p style="white-space: pre-wrap;"><c:out value="${board.content }" /></p>
			</div>

			<!-- 첨부파일 시작 -->
			<br />
			<div>
				<div>
					<div>
						<div id="uploadResult">
							<ul class="attach-ul"></ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 첨부파일 끝 -->

			<div>
				<sec:authentication property="principal" var="pinfo" />
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer }">
				<button data-oper="modify" class="btn-default">수정</button>
					</c:if>
				</sec:authorize>
				<button data-oper="list" class="btn-default">목록</button>
			</div>
			
			<form id='operForm' action="/qnaBoard/modify" method="get">
				<input type="hidden" id='bno' name='bno' value="${board.bno }">
				<input type="hidden" name="pageNum" value="${cri.pageNum }">
				<input type="hidden" name="amount" value="${cri.amount }">
				<input type="hidden" name="type" value="${cri.type }">
				<input type="hidden" name="keyword" value="${cri.keyword }">
			</form>
		</div>

		<!-- 댓글 목록 -->
		<br />
		<div>
			<div>
				<div style="border-bottom: 1px solid #E6E6E6; padding: 20px 10px">
					<img src="../resources/img/comments.png" width="20px"
					 style="height: 20px; vertical-align: middle">&nbsp;<b>댓글</b>
					 <sec:authorize access="isAnonymous()">
					 	<div style="text-align: center;">댓글 작성은 로그인 후 가능합니다.</div>
					</sec:authorize>
					 <sec:authorize access="isAuthenticated()">
						 <button id="reWrite" class="reForm-btn" style="float: right">작성</button>
					 </sec:authorize>
				</div>
				<div style="border-bottom: 1px solid #E6E6E6;">
					<form id="replyForm" class="re-form">
						<div>
							 <sec:authorize access="isAuthenticated()">
								작성자: <input class="re-input" type="text" name="replyer"
									value="<c:out value="${pinfo.username}"/>" readonly="readonly">
								<button type="submit" class="reForm-btn" id="reSubBtn"
									style="float: right;">등록</button>
								<button type="reset" class="reForm-btn" id="reFormClose"
									style="float: right;">취소</button>
							</sec:authorize>
						</div>
						<br />
						<div>
							<textarea id="reply" class="re-text" name="reply"
								style="resize: none;" placeholder="내용을 입력해 주세요."></textarea>
							<div id="reply_cnt" align="right">[0 / 500]</div>
						</div>
					</form>
				</div>
				<div>
					<ul id="chat" class="reply-ul">
						<li></li>
					</ul>
				</div>
				<div id="reply-footer" align="center"></div>
			</div>
		</div>
		<!-- 댓글 목록 끝 -->
	</div>
</div>
</body>


<script type="text/javascript" src="/resources/js/reply.js"></script>
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
		operForm.attr("action", "/qnaBoard/modify").submit();
	});
	$('button[data-oper="list"]').on("click", function(e) {	// 목록 버튼 클릭 시
		operForm.find("#bno").remove();
		operForm.attr("action", "/qnaBoard/list").submit();
	});


	var replyForm = $("#replyForm");
	var replyer = replyForm.find("input[name='replyer']");
	var bnoValue = '<c:out value="${board.bno}"/>';


	// 댓글 작성 버튼
	$("#reWrite").on("click", function(e) {
		replyForm.attr("style", "display: block");
	});
	// 댓글 취소 버튼
	$("#reFormClose").on("click", function(e) {
		replyForm.attr("style", "display: none");
	});


	// 댓글 등록 버튼
	$("#reSubBtn").on("click", function(e) {
		e.preventDefault();

		if ($("textarea#reply").val() == "") {
			alert("댓글을 입력해 주세요.");
			return false;
		}
		
		var reply = {
				replyer: replyer.val(),
				reply: $("textarea#reply").val(),
				bno: bnoValue
		};
		replyService.add(reply, function(result) {
			alert("댓글이 등록되었습니다.");
			replyer.val("");
			$("textarea#reply").val("");
			replyForm.attr("style", "display: none");
			showList(-1);
		});
	});
	


	// 댓글 글자 수
	$('#reply').on('keyup', function() {
		$('#reply_cnt').html("[" + $(this).val().length + " / 500]");
		
		if ($(this).val().length > 500) {
			$(this).val($(this).val().substring(0, 500));
			$('#reply_cnt').html("[500 / 500]");
			alert("댓글은 최대 500글자까지 입력 가능합니다.");
		}
	});


	// 댓글 목록 표시
	var replyUL = $("#chat");
	function showList(page) {
		replyService.getList ({
			bno: bnoValue,
			page: page || 1
		},
		function(replyCnt, list) {
			if (page == -1) {
				showList(1);
				return;
			}

			var str = "";
			if (list == null || list.length == 0) {
				str += "<div align='center' style='margin: 50px;'>댓글이 없습니다.</div>";
				replyUL.html(str);
				return;
			}
			for (var i=0, len=list.length || 0; i<len; i++) {
				str += "<li class='reply-li'><div><div><small>";
				str += list[i].replyer + "</small><small style='float: right;'>";
				str += replyService.displayTime(list[i].replyDate) + "</small></div>";

				str += "<p id='default-re" + list[i].rno + "' style='display:block;'>" + list[i].reply;
				str += "<sec:authentication property='principal' var='pinfo' />";
				str += "<sec:authorize access='isAuthenticated()'>"
				if (list[i].replyer == "${pinfo.username}") {
					str += "<button type='submit' id='reRemoBtn' data-rno='";
					str += list[i].rno + "' class='reply-remo' style='float: right;'>삭제</button>";
					str += "<button type='button' id='reModiBtn' data-rno='";
					str += list[i].rno + "' class='reply-modi' style='float: right;'>수정</button></p>";
				}
				str += "</sec:authorize>";

				str += "<p id='modify-re" + list[i].rno + "' style='display:none;'>";
				str += "<textarea class='re-text-modi' name='reply" + list[i].rno;
				str += "' style='resize: none;'>" + list[i].reply + "</textarea>";

				str += "<button type='submit' id='modiSubBtn' data-rno='";
				str += list[i].rno + "' class='reply-remo' style='float: right;'>완료</button>";

				str += "<button type='button' id='CloseReModiBtn' data-rno='";
				str += list[i].rno + "' class='reply-modi' style='float: right;'>취소</button>";
				str += "</p></div></li>";
			}
			replyUL.html(str);
			showReplyPage(replyCnt);
			// 댓글 목록 페이징 호출 코드
		});
	}
	showList(1);


	// 댓글 수정폼 보이기
	$(document).on("click", "#reModiBtn", function() {
		var rno = $(this).data("rno");
		$("#default-re" + rno).attr("style", "display: none");
		$("#modify-re" + rno).attr("style", "display: block");
	});


	// 댓글 수정폼 숨기기
	$(document).on("click", "#CloseReModiBtn", function() {
		var rno = $(this).data("rno");
		$("#default-re" + rno).attr("style", "display: block");
		$("#modify-re" + rno).attr("style", "display: none");
	});


	// 댓글 수정 처리
	$(document).on("click", "#modiSubBtn", function(e) {
		var rno = $(this).data("rno");
		var replyText = $("textarea[name=reply" + rno + "]");
		var reply = {
				rno: rno,
				reply: replyText.val()
		};
		replyService.update(reply, function(result) {
			alert("댓글이 수정되었습니다.");
			$("#default-re" + rno).attr("style", "display: block");
			$("#modify-re" + rno).attr("style", "display: none");
			showList(pageNum);
		});
	});


	// 댓글 삭제 처리
	$(document).on("click", "#reRemoBtn", function(e) {
		var rno = $(this).data("rno");
		if (confirm("댓글을 삭제하시겠습니까?") == true) {
			replyService.remove(rno, function(result) {
				alert("댓글이 삭제되었습니다.");
				$("#default-re" + rno).attr("style", "display: block");
				$("#modify-re" + rno).attr("style", "display: none");
				showList(-1);
			});
		} else {
			e.preventDefault();
			return false;
		}
	});


	// 댓글 목록 페이징
	var pageNum = 1;
	var replyPageFooter = $("#reply-footer");

	function showReplyPage(replyCnt) {
		var endNum = Math.ceil(pageNum / 10.0) * 10; // 수정
		var startNum = endNum - 9;
		var realEnd = Math.ceil((replyCnt * 1.0) / 5);
		var prev = startNum != 1;
		var next = false;

		if (endNum >= realEnd) {
			endNum = realEnd;  // 수정
		}
		if (endNum < realEnd) {
			next = true;
		}
		var str = "<ul class='page-ul'>";
		if (prev) {
			str += "<li class='page-li'>";
			str += "<a class='page-link' href='1')>≪</a></li>";
			str += "<li class='page-li'><a class='page-link' href='";
			str += (startNum - 1) + "'>＜</a></li>";
		}
		for (var i=startNum; i<=endNum; i++) {
			str += "<li class='page-li'>";
				if (pageNum == i) {
					str += "<b class='link-choice'>" + i + "</b>";
				} else {
					str += "<a class='page-link' href='" + i + "'>" + i + "</a>";
				}
			str += "</li>";
		}
		if (next) {
			str += "<li class='page-li'><a class='page-link' href='";
			str += (endNum + 1) + "'>＞</a></li>";
			str += "<li class='page-li'><a class='page-link' href='";
			str += realEnd + "'>≫</a></li>";
		}
		str += "</ul>";
		replyPageFooter.html(str);
	}


	// 댓글 목록 페이지 번호 이벤트
	replyPageFooter.on("click", "li a", function(e) {
		e.preventDefault();
		var targetPageNum = $(this).attr("href");
		pageNum = targetPageNum;
		showList(pageNum);
	});


	// 비동기 처리로 표시하는 첨부파일 목록
	(function() {
		var bno='<c:out value="${board.bno}"/>';
		$.getJSON("/qnaBoard/getAttachList", {bno:bno}, function(arr) {
			var str="";

			$(arr).each(function (i, attach) {
				str += "<li data-path='" + attach.uploadPath;
				str += "' data-uuid='" + attach.uuid;
				str += "' data-filename='" + attach.fileName;
				str += "' data-type='" +attach.fileType + "'><div class='attach-box'>";
				str += "<img src='/resources/img/attach.png'>&nbsp;";
				str += "<span>" + attach.fileName + "</span><br />";
				str += "</div></li>";
			});
			$("#uploadResult ul").html(str);
		});
	})();


	// 첨부파일 다운로드
	$("#uploadResult").on("click", "li", function(e) {
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path")
				+ "/" + liObj.data("uuid")
				+ "_" + liObj.data("filename"));
		self.location = "/download?fileName=" + path;
		
	});

})
</script>

<%@ include file="../includes/footer.jsp"%>