<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.title }: 딜레디</title>
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/div/goods.css">
<link rel="stylesheet" href="/resources/css/form/goodsForm.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mainBar.jsp"%>
<div>
	<div>
		<div align="center">
			<div class="detail-page">
				<div class="upload-img">
					<div class="img-page-prev" id="imgPrevPage">＜</div>
					<div id="uploadImg" data-pdid="${product.pdId }"></div>
					<div class="img-page-next" id="imgNextPage">＞</div>
				</div>
				<div class="pd-info">
					<c:choose>
						<c:when test="${product.tradingCase == 'direct'}">
							<div class="trading-case-r">직거래</div>
						</c:when>
						<c:otherwise>
							<div class="trading-case-l">택배</div>
						</c:otherwise>
					</c:choose>
					<div class="pd-name"><c:out value="${product.title }" />
					</div>
					<div class="price"><fmt:formatNumber value="${product.pdPrice }"
							pattern="###,###,###" />원</div>
					<span class="price-info">
						<c:if test="${product.priceInfo0 != null }">
							<span class="delivery-f">${product.priceInfo0 }</span>
						</c:if>
						<c:if test="${product.priceInfo1 != null }">
							<span class="delivery-f">${product.priceInfo1 }</span>
						</c:if>
					</span>
					<div>
						<c:choose>
							<c:when test="${product.state == 'newState' }">
								<p>상태: 새 상품</p>
							</c:when>
							<c:otherwise>
								<p>상태: 중고 상품</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<p>수량: <c:out value="${product.pdStock }"/>개</p>
					</div>
					<div>
						<c:choose>
							<c:when test="${product.priceInfo2 != null }"><p>가격 협의: 가능</p></c:when>
							<c:otherwise><p>가격 협의: 불가능</c:otherwise>
						</c:choose>
					</div>
					<p><img src="/resources/img/read.png" width="20">
						<c:out value="${product.readCnt }" />&nbsp; |&nbsp; 
						<fmt:formatDate value="${product.regDate }" pattern="yyyy.MM.dd HH:mm" /></p>
					<div class="button">
						<sec:authentication property="principal" var="pinfo" />
						<sec:authorize access="isAuthenticated()">
						<c:choose>
							<c:when test="${pinfo.username == product.writer }">
								<div class="modify" style="display: inline-block;">
									<button name="d-btn" id="modify-btn">수정</button>
								</div>
							</c:when>
							<c:otherwise>
								<button name="h-btn" id="heartBtn">찜</button>
								<button name="c-btn" id="commuBtn">연락하기</button>
								<button name="d-btn" id="dealBtn">거래하기</button>
							</c:otherwise>
						</c:choose>
						</sec:authorize>
						<sec:authorize access="isAnonymous()">
							<button name="h-btn" id="heartBtn">찜</button>
							<button name="c-btn" id="commuBtn">연락하기</button>
							<button name="d-btn" id="dealBtn">거래하기</button>
						</sec:authorize>
					</div>
				</div>
			</div>
			<div class="pd-nav">
				<nav>
					<ul>
						<li id="pdCon"
							style="box-shadow: inset 1px 1px black, inset -1px 0 black;
							color: black">상품 설명</li
						><li id="pdQna" style="box-shadow: inset 0 -1px black;
							color: #999999">상품 문의</li
						><li id="pdReview" style="box-shadow: inset 0 -1px black;
							color: #999999">거래 후기</li>
					</ul>
				</nav>
				<div class="pd-etc">
					<div id="content">
						<h2>상품 설명</h2>
						<pre>${product.content }</pre>
						<c:if test="${product.userAdd != null }">
							<article style="margin-top: 70px; width: 300px; border: 2px solid #B4B4B4;
								padding: 30px; color: #575757; font-weight: bold;">
									★거래 장소
									<p style="font-size: 20px;">${product.userAdd }</p>
							</article>
						</c:if>
					</div>
					<div id="qna">
						<h2>상품 문의(0)</h2>
						<sec:authorize access="isAnonymous()">
							<div class="anonymous">상품 문의는 로그인 후 가능합니다.</div>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
						<c:choose>
							<c:when test="${pinfo.username == product.writer }">
								<div class="anonymous">자신의 판매글에는 문의를 남길 수 없습니다.</div>
							</c:when>
							<c:otherwise>
								<div style="border-bottom: 1px solid #E6E6E6;">
									<form id="replyForm" class="re-form">
										<div>
											<div>
												작성자: <input class="re-input" type="text" name="replyer"
													value="<c:out value="${pinfo.username}"/>" readonly="readonly">
												<button type="submit" class="reForm-btn" id="quesSubBtn"
													style="float: right;">등록</button>
											</div>
											<br />
											<div>
												<textarea id="question" class="re-text" name="reply"
														style="resize: none;" placeholder="내용을 입력해 주세요."></textarea>
												<div id="ques_cnt" align="right">[0 / 500]</div>
											</div>
										</div>
									</form>
								</div>
							</c:otherwise>
						</c:choose>
						</sec:authorize>
					</div>
					<div id="review">
						<h2>거래 후기(0)</h2>
						<sec:authorize access="isAnonymous()">
							<div class="anonymous">거래 후기는 로그인 후 작성 가능합니다.</div>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
						<c:choose>
							<c:when test="${pinfo.username == product.writer }">
								<div class="anonymous">자신의 판매글에는 후기를 남길 수 없습니다.</div>
							</c:when>
							<c:otherwise>
								<div class="anonymous">거래 후기는 거래 진행자만 작성할 수 있습니다.</div>
							</c:otherwise>
						</c:choose>
						</sec:authorize>
					</div>
				</div>
			</div>
			<form id="actionForm" action="/store/modify" method="get">
			</form>
		</div>
	</div>
</div>
</body>

<script>
$(document).ready(function(e) {
	$("#heartBtn").on("click", function(e) {
		alert("추후 기능 개발 예정입니다.");
	});
	$("#commuBtn").on("click", function(e) {
		alert("추후 기능 개발 예정입니다.");
	});
	$("#dealBtn").on("click", function(e) {
		alert("추후 기능 개발 예정입니다.");
	});

	$("#pdCon").on("click", function(e) {	// 상품 설명 메뉴 클릭
		$(this).attr("style", "").css("color", "black")
		.css("box-shadow", "inset 1px 1px black, inset -1px 0 black");
		$("#pdQna").attr("style", "").css("color", "#999999")
		.css("box-shadow", "inset 0 -1px black");
		$("#pdReview").attr("style", "").css("color", "#999999")
		.css("box-shadow", "inset 0 -1px black");
		var scroll = $("#content").offset().top - 290;
		$("html, body").animate({scrollTop: scroll}, 500);
	});


	$("#pdQna").on("click", function(e) {	// 상품 문의 메뉴 클릭
		$(this).attr("style", "").css("color", "black")
		.css("box-shadow", "inset 1px 1px black, inset -1px 0 black");
		$("#pdCon").attr("style", "").css("color", "#999999")
		.css("box-shadow", "inset 0 -1px black");
		$("#pdReview").attr("style", "").css("color", "#999999")
		.css("box-shadow", "inset 0 -1px black");
		var scroll = $("#qna").offset().top - 260;
		$("html, body").animate({scrollTop: scroll}, 500);
	});


	$("#pdReview").on("click", function(e) {	// 거래 후기 메뉴 클릭
		$(this).attr("style", "").css("color", "black")
		.css("box-shadow", "inset 1px 1px black, inset -1px 0 black");
		$("#pdCon").attr("style", "").css("color", "#999999")
		.css("box-shadow", "inset 0 -1px black");
		$("#pdQna").attr("style", "").css("color", "#999999")
		.css("box-shadow", "inset 0 -1px black");
		var scroll = $("#review").offset().top - 260;
		$("html, body").animate({scrollTop: scroll}, 500);
	});


	// 수정 버튼
	var pno = "<c:out value='${product.pno}'/>";
	$("#modify-btn").on("click", function(e) {
		str = "<input type='hidden' name='pno' value='" + pno + "'>";
		$("#actionForm").append(str).submit();
	});


	// 댓글 글자 수
	$('#question').on('keyup', function() {
		$('#ques_cnt').html("[" + $(this).val().length + " / 500]");
		
		if ($(this).val().length > 500) {
			$(this).val($(this).val().substring(0, 500));
			$('#ques_cnt').html("[500 / 500]");
			alert("댓글은 최대 500글자까지 입력 가능합니다.");
		}
	});
	$('#reply').on('keyup', function() {
		$('#reply_cnt').html("[" + $(this).val().length + " / 500]");
		
		if ($(this).val().length > 500) {
			$(this).val($(this).val().substring(0, 500));
			$('#reply_cnt').html("[500 / 500]");
			alert("댓글은 최대 500글자까지 입력 가능합니다.");
		}
	});


	// 댓글 등록 버튼
	$("#reSubBtn").on("click", function(e) {
		e.preventDefault();
		var reply = $("#reply").val();
		if (reply == "") {
			alert("내용을 입력해 주세요.");
			return false;
		}
		alert("기능 준비 중입니다.");
		$("#reply").val("");
		return false;
	});
	$("#quesSubBtn").on("click", function(e) {
		e.preventDefault();
		var question = $("#question").val();
		if (question == "") {
			alert("내용을 입력해 주세요.");
			return false;
		}
		alert("기능 준비 중입니다.");
		$("#question").val("");
		return false;
	});


	// 이미지 불러오기
	var uploadImg = $("#uploadImg");
	var pdId = uploadImg.data("pdid");
	(function() {
		$.getJSON("/store/getImgList", {pdId:pdId}, function(arr) {
			if (arr.length == 0) {
				$("#imgPrevPage").remove();
				$("#imgNextPage").remove();
				return false;
			}
			if (arr.length == 1) {
				$("#imgPrevPage").remove();
				$("#imgNextPage").remove();
			}
			var img = arr[0];
			var str = "";
			var fileCallPath
			= encodeURIComponent(img.uploadPath + "\\" + img.uuid + "_" + img.fileName);
			str += "<img src='/detail?fileName=" + fileCallPath + "'>";
			uploadImg.html(str);
		});
	})();


	// 이미지 불러오기
	var click = 0;
	var type = "";
	function getImg(click, type) {
		var str = "";
		var img = "";
		$.getJSON("/store/getImgList", {pdId:pdId}, function(arr) {
			if (arr.length == 0) {
				return false;
			}
			if (click >= 1) {
				$("#imgPrevPage").css("display", "block");
				$("#imgNextPage").css("display", "block");
			} else if ((click+1) < arr.length) {
				$("#imgNextPage").css("display", "block");
			}
			if (type == "Next") {
				img = arr[click];
				if ((click+1) >= arr.length) {
					$("#imgNextPage").css("display", "none");
				}
			} else {
				img = arr[click];
				if (click < 1) {
					img = arr[0];
					$("#imgPrevPage").css("display", "none");
				}
			}
			var fileCallPath
			= encodeURIComponent(img.uploadPath + "\\" + img.uuid + "_" + img.fileName);
			str += "<img src='/detail?fileName=" + fileCallPath + "'>";
			uploadImg.html(str);
		});
	};


	// 이전, 다음 이미지
	$("#imgNextPage").on("click", function(e) {
		type = "Next";
		click = click+1;
		getImg(click, type);
	});
	$("#imgPrevPage").on("click", function(e) {
		type = "Prev";
		click = click-1;
		getImg(click, type);
	});

})

</script>
</html>
<%@ include file="../includes/footer.jsp"%>