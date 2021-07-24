<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지: 딜레디</title>
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/table/myPageTb.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/mainBar.jsp"%>
<div>
	<div align="center">
		<div class="my-page">
			<table class="menu-tb">
				<tr>
					<td id="myInfoBtn" class="my-info">내 정보</td>
					<td id="storeInfoBtn" class="store-info">내 상점</td>
				</tr>
			</table>
			<table class="my-info-tb" id="myInfo">
				<tr>
					<td class="user-up userUp"><img src="/resources/img/info.png" width="90"><p>회원 수정</p></td>
					<td class="heart-pd"><img src="/resources/img/heart.png" width="75"><p>찜한 상품</p></td>
				</tr>
				<tr>
					<td class="review-mana"><img src="/resources/img/review.png" width="90" height="60"><p>리뷰 관리</p></td>
					<td class="deal-he"><img src="/resources/img/cycle.png" width="70"><p>거래 내역</p></td>
				</tr>
			</table>
			<table class="my-store-tb" id="myStore">
				<tr>
					<td class="store-up"><img src="/resources/img/setting.png" width="70"><p>상점 수정</p></td>
					<td class="pd-re" id="add"><img src="/resources/img/product.png"
						width="90"><p>상품 등록</p></td>
				</tr>
				<tr>
					<td class="pd-mana" id="goods"><img src="/resources/img/store.png"
						width="70" height="60"><p>상품 관리</p></td>
					<td class="deal-he"><img src="/resources/img/cycle.png" width="70"><p>거래 내역</p></td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>

<script>
$(document).ready(function() {
	// 내 정보 카테고리 클릭 시
	$("#myInfo td").on("click", function() {
		alert("기능 준비 중으로 아직 사용할 수 없습니다.");
		return false;
	});


	// 내 상점 카테고리 클릭 시
	$("#myStore td").on("click", function() {
		var id = $(this).attr("id");
		if (id == null) {
			alert("기능 준비 중으로 아직 사용할 수 없습니다.");
			return false;
		} else if (id == "add") {
			self.location = "/store/upload";
		} else if (id == "goods") {
			self.location = "/store/list";
		}
	});


	// 내 정보 버튼 클릭 시
	$("#myInfoBtn").on("click", function() {
		$(this).css("font-weight", "bold").css("box-shadow", "inset 0 -3px #A4A4A4");
		$("#myInfo").css("display", "block");
		$("#storeInfoBtn").css("box-shadow", "none").css("font-weight", "normal");
		$("#myStore").css("display", "none");
	});


	// 내 상점 버튼 클릭 시
	$("#storeInfoBtn").on("click", function() {
		$(this).css("font-weight", "bold").css("box-shadow", "inset 0 -3px #A4A4A4");
		$("#myStore").css("display", "block");
		$("#myInfoBtn").css("box-shadow", "none").css("font-weight", "normal");
		$("#myInfo").css("display", "none");
	});
	
})
</script>

<%@ include file="includes/footer.jsp"%>