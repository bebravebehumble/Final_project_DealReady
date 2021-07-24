<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="move-btn">
	<div class="top top-btn">↑</div>
	<div class="bottom bottom-btn">↓</div>
</div>
<footer>
	<div align="center">
		<div>
			<ul>
				<li><a href="/notice/list">공지사항</a></li>
				<li><a href="/FAQ/list">FAQ</a></li>
				<li><span id="ques">1:1 문의</span></li>
				<li><a href="/qnaBoard/list">궁그미 게시판</a></li>
			</ul>
		</div>
		<div class="info">
			<p>상호명 (주)딜레디 | 이메일 dealready@naver.com</p>
			<p>고객 센터 1234-1234</p>
			<br />
			<p>Copyright &copy; 딜레디 All Rights Reserved.</p>
		</div>
	</div>
</footer>

<script>
$(document).ready(function(e) {
	$("#ques").on("click", function(e) {
		alert("1:1 문의 기능은 아직 사용할 수 없습니다. 문의가 필요하신 경우, 고객 센터 또는 이메일을 통해 진행해 주시기 바랍니다.");
	});


	$(window).scroll(function() {
		if ($(this).scrollTop() > 150) {
			$(".top").fadeIn();
		} else {
			$(".top").fadeOut();
		}
	});

	// 탑 버튼
	$(".top").on("click", function() {
		$("html, body").animate({scrollTop: 0}, 500);
	});


	// 바텀 버튼
	$(".bottom").on("click", function() {
		$("html, body").animate({scrollTop: ($("footer").offset().top)}, 500);
	});

})
</script>

</html>