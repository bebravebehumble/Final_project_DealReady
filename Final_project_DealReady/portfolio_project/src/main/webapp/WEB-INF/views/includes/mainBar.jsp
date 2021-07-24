<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="mainbar">
	<div align="center">
		<div class="mainbar-ele">
			<sec:authentication property="principal" var="principal"/>
			<img src="/resources/img/logo.png" name="logo">
			<form class="main-search">
				<select name="main-type">
					<option value="" ${pageMaker.cri.type==null? "selected" : "" }></option>
					<option value="pdName" ${pageMaker.cri.type eq "pdName"? "selected" : "" }>
					상품명</option>
					<option value="store" ${pageMaker.cri.type eq "store"? "selected" : "" }>
					상점 이름</option>
					<option value="delivery" ${pageMaker.cri.type eq "delivery"? "selected" : "" }>
					택배</option>
					<option value="direct" ${pageMaker.cri.type eq "direct"? "selected" : "" }>
					직거래</option>
				</select>
				<input type="text" name="main-keyword" class="search-div">
				<img src="/resources/img/search.png" name="search">
			</form>
			<ul>
				<li id="store-btn"><a href="/">딜레디몰</a></li>
				<li id="sell-btn"><a href="/store/upload">판매GO</a></li>
				<li id="shop-btn">쇼핑몰</li>
				<li id="qna-btn"><a href="/qnaBoard/list">게시판</a></li>
				<li id="notice-btn"><a href="/notice/list">공지사항</a></li>
			</ul>
		</div>
	</div>
</div>

<script>
$(document).ready(function(e) {
	// 판매GO 메뉴 클릭 시
	var principal = '${principal}';
	$("#sell-btn").on("click", function(e) {
		if (principal == 'anonymousUser') {
			e.preventDefault();
			if (confirm("상품 등록은 로그인 후 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?") == true) {
				self.location = "/store/upload";
			} else {
				return false;
			}
		}
	});


	// 쇼핑몰 메뉴 클릭 시
	$("#shop-btn").on("click", function() {
		alert("딜레디 쇼핑몰 페이지는 준비 중입니다.");
	});


	// 검색 버튼 이벤트
	$("img[name='search']").on("click", function(){
		alert("검색 기능은 아직 사용할 수 없습니다.");
	});


	// 로고 클릭 시
	$("img[name='logo']").on("click", function() {
		self.location = "/";
	});

})
</script>