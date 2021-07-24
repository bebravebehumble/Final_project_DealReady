<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>거래를 위한 플랫폼, 딜레디</title>
	<link rel="stylesheet" href="/resources/css/div/div.css">
	<link rel="stylesheet" href="/resources/css/div/home.css">
	<link rel="stylesheet" href="/resources/css/div/mainbar.css">
	<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/mainBar.jsp"%>
<div>
	<div class="goods-imgList">
		<div><p class="main-title">모든 상품(${cnt })</p></div>
		<c:forEach var="store" items="${store }">
				<div class="main-list" id="product" data-pno="${store.pno }">
					<div id="img${num=num-1 }" class="pd-img" data-pdid="${store.pdId }"></div>
					<div id="Detail${num }" class="pd-info">
						<c:choose>
							<c:when test="${store.tradingCase == 'direct'}">
								<div class="trading-case-r">직거래</div>
								<div class="trading-case-r">#${store.userAdd }</div>
							</c:when>
							<c:otherwise>
								<div class="trading-case-l">택배</div>
							</c:otherwise>
						</c:choose>
						<div class="pd-title"><c:out value="${store.title }"/></div>
						<div class="pd-price"><fmt:formatNumber value="${store.pdPrice }"
							pattern="###,###,###" />원
							<span>
								<c:if test="${store.tradingCase == 'delivery' }">
										${store.priceInfo0 }${store.priceInfo1 }
								</c:if>
							</span>
						</div>
						<div class="pd-stock">수량 <c:out value="${store.pdStock }"/>개</div>
						<div><fmt:formatDate pattern="yyyy-MM-dd"
							value="${store.regDate }"/></div>
					</div>
				</div>
		</c:forEach>
	</div>
	<form id="actionForm" action="/store/goods" method="get">
	</form>
</div>
</body>

<script>
$(document).ready(function(e) {
	// 상세 페이지로 이동
	$(document).on("click", "#product", function(e) {
		var pno = $(this).data("pno");
		var str = "<input type='hidden' name='pno' value='" + pno + "'>";
		$("#actionForm").append(str).submit();
	});


	// 이미지 불러오기
	var storeCnt = '<c:out value="${cnt}"/>';
	(function getImg() {
		for (var i=storeCnt-1; i>=0; i--) {
			var img = $("#img" + i);
			var imgId = img.selector;
			var pdId = $(imgId).data("pdid");
			append(imgId, pdId);
		}
	})();

	function append(imgId, pdId) {
		$.getJSON("/store/getImgList", {pdId:pdId}, function(arr) {
			if (arr.length == 0) {
				return false;
			}
			var img = arr[0];
			var str = "";
			var fileCallPath
			= encodeURIComponent(img.uploadPath + "\\" + img.uuid + "_" + img.fileName);
			str += "<img src='/detail?fileName=" + fileCallPath + "'>";
			$(imgId).html(str);
		});
	}

})
</script>
<%@ include file="includes/footer.jsp"%>