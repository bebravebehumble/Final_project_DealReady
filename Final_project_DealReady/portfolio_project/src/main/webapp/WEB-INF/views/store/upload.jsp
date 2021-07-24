<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>상품 등록: 딜레디</title>
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/form/uploadForm.css">
<link rel="stylesheet" href="/resources/css/div/div.css">
<link rel="stylesheet" href="/resources/css/div/mainbar.css">
<link rel="stylesheet" href="/resources/css/div/footer.css">
</head>

<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/mainBar.jsp"%>
	<div>
		<div class="title">
			<b style="font-size: 30px;">상품 등록</b>
		</div>
		<div class="form2">
			<div>
				<form role="form" action="/store/upload" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="writer"
					value="<sec:authentication property='principal.username'/>">
					<div class="input-file">
						<table id="uploadResult" class="upload-tb">
							<tr class='img-view'>
								<td class="file-box">
									<label for="file">상품 이미지 업로드</label>
									<input type="file" id="file" class="file-item" name="uploadFile" multiple>
								</td>
							</tr>
						</table>
					</div>
					<br />
					<div>
						<b>거래 방법</b>
						<label><input type="radio" name="tradingCase" value="direct">직거래</label>
						<label><input type="radio" name="tradingCase" value="delivery">택배</label>
						<br /><br />
						<b>거래 지역</b>
						<input type="text" name="userAdd" placeholder="직거래 시 장소를 입력해 주세요"
							disabled style="background: #f3f3f3;">
					</div>
					<br />
					<div>
						<b>제목</b>
						<input id="regTitle" type="text" name="title"
							placeholder="제목을 입력해 주세요">
					</div>
					<br />
					<div>
						<b style="vertical-align: top; margin-top: 30px">상품 설명</b>
						<textarea id="regCon" name="content"
							placeholder="상품 설명을 입력해 주세요"></textarea>
					</div>
					<br />
					<div>
						<b>상태</b>
						<label><input type="radio" name="state" value="newState">새 상품</label>
						<label><input type="radio" name="state" value="old">중고 상품</label>
					</div>
					<br />
					<div>
						<b>가격</b>
						<input type="number" name="pdPrice" maxlength="9"
							onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
						<span>(숫자만 입력 ex, 10000)</span><br />
						<b></b>
						<label><input type="checkbox" name="priceInfo0" value="배송비 포함">배송비 포함</label>
						<label><input type="checkbox" name="priceInfo1" value="배송비 별도">배송비 별도</label>
						<label><input type="checkbox" name="priceInfo2" value="가격 조정 가능">가격 조정 가능</label>
					</div>
					<br />
					<div>
						<b>수량</b>
						<input type="number" name="pdStock" min="0" max="999" maxlength="3"
							onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">개
					</div>
					<br/>
					<div align="center">
					<button type="submit" class="btn-default" id="regSub-btn">등록</button>
					<button type="reset" class="btn-default">다시</button>
					<button type="button" class="btn-default" onclick="history.back(-1);">뒤로</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<script>
$(document).ready(function(e) {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});


	// 주소 입력칸 활성화
	$("input:radio[value='direct']").change(function() {
		var checked = $(this).prop('checked');
		$("input[name='userAdd']").attr("disabled", false).css("background", "white");
		$("input[name='userAdd']").focus();
		$("input[value='배송비 포함']").prop("checked", false);
		$("input[value='배송비 별도']").prop("checked", false);
	});
	$("input:radio[value='delivery']").change(function() {
		var checked = $(this).prop('checked');
		$("input[name='userAdd']").attr("disabled", true).css("background", "#f3f3f3");
		$("input[name='userAdd']").val("");
	});


	// 가격 길이 제한
	$("input[name='pdPrice'][maxlength]").on('keyup', function(e) {
		var maxlength = $(this).attr('maxlength');
		var value = $("input[name='pdPrice']").val();
		if (value.length > maxlength) {
			alert("가격이 입력 가능 범위를 벗어났습니다.");
			$(this).val(value.substring(0, maxlength));
		}
	});


	// 수량 길이 제한
	$("input[name='pdStock']").on('keyup', function(e) {
		var maxlength = $(this).attr('maxlength');
		var value = $("input[name='pdStock']").val();
		if (value.length > maxlength) {
			alert("수량은 백단위까지 입력 가능합니다.");
			$(this).val(value.substring(0, maxlength));
		}
	});


	// 게시글 제목 글자 수
	$('#regTitle').on('keyup', function() {
		if ($(this).val().length > 60) {
			$(this).val($(this).val().substring(0, 60));
			alert("공지 제목은 최대 60글자까지 입력 가능합니다.");
		}
	});


	// 게시글 내용 글자 수
	$('#regCon').on('keyup', function() {
		if ($(this).val().length > 1300) {
			$(this).val($(this).val().substring(0, 1300));
			alert("공지 내용은 최대 1300글자까지 입력 가능합니다.");
		}
	});


	// 입력 없이 등록 버튼 눌렀을 때
	var formObj = $("form[role='form']");
	$("#regSub-btn").on("click", function(e) {
		var str ="";
		var direct = $("input:radio[value='direct']");
		var delivery = $("input:radio[value='delivery']");
		var newState = $("input:radio[value='newState']");
		var old = $("input:radio[value='old']");
		var userAdd = $("input[name='userAdd']");
		var priceInfo0 = $("input[name='priceInfo0']").is(":checked");
		var priceInfo1 = $("input[name='priceInfo1']").is(":checked");


		if ($("#uploadResult td[id='imgFile']").length == 0) {	// 상품 이미지 업로드 확인
			e.preventDefault();
			alert("상품 이미지를 업로드해 주세요.");
			return false;
		}

		if ($("#regTitle").val() == "") {	// 제목 null값 확인
			e.preventDefault();
			alert("제목을 입력해 주세요.");
			$("#regTitle").focus();
			return false;
		}
		if ($("#regCon").val() == "") {	// 내용 null값 확인
			e.preventDefault();
			alert("내용을 입력해 주세요.");
			$("#regCon").focus();
			return false;
		}

		if ((!delivery.is(":checked")) && (!direct.is(":checked"))) {	// 거래 방법 체크 확인
			e.preventDefault();
			alert("거래 방법을 선택해 주세요.");
			return false;
		}

		if ((direct.is(":checked")) && (userAdd.val() == "")) {		// 거래 장소 입력 확인
			e.preventDefault();
			alert("거래 장소를 입력해 주세요.");
			userAdd.focus();
			return false;
		}
		if ((delivery.is(":checked"))) {
			if ((priceInfo0 == false) && (priceInfo1 == false)) {
				e.preventDefault();
				alert("원활한 거래를 위해 배송비 여부를 선택해 주세요.");
				return false;
			}
		}
		if ((direct.is(":checked"))) {
			if ((priceInfo0 == true) || (priceInfo1 == true)) {
				e.preventDefault();
				if (confirm("직거래 시 배송비 관련 항목은 체크할 수 없습니다. 체크 해제 후 업로드하시겠습니까?") == true) {
					$("input[value='배송비 포함']").prop("checked", false);
					$("input[value='배송비 별도']").prop("checked", false);
				} else {
					return false;
				}
			}
		}

		if ((!newState.is(":checked")) && (!old.is(":checked"))) {	// 상품 상태 체크 확인
			e.preventDefault();
			alert("거래 상품 상태를 선택해 주세요.");
			return false;
		}

		if ($("input[name='pdPrice']").val() == "") {	// 상품 가격 입력 확인
			e.preventDefault();
			alert("상품 가격을 입력해 주세요.");
			$("input[name='pdPrice']").focus();
			return false;
		}

		if ($("input[name='pdStock']").val() == "") {	// 상품 수량 입력 확인
			e.preventDefault();
			alert("상품 수량을 입력해 주세요.");
			$("input[name='pdStock']").focus();
			return false;
		}


		// 이미지 정보
		$("#uploadResult td[id='imgFile']").each(function(i, obj) {
			var jobj = $(obj);
			console.dir(jobj);
			console.log("------------------");
			console.log(jobj.data("filename"));
			
			// 동적으로 생성하는 히든값
			str += "<input type='hidden' name='imgList[" + i;
			str += "].fileName' value='" + jobj.data("filename") + "'>";

			str += "<input type='hidden' name='imgList[" + i;
			str += "].uuid' value='" + jobj.data("uuid") + "'>";

			str += "<input type='hidden' name='imgList[" + i;
			str += "].uploadPath' value='" + jobj.data("path") + "'>";
		});
		$("form[role='form']").append(str).submit();
	});


	// 이미지 업로드
	$("input[type='file']").on("change", function(e) {
		let formData = new FormData();
		// 첨부파일을 FromData에 저장한 뒤 서버로 전송하는 역할
		let fileInput = $("input[name='uploadFile']");
		// uploadFile에서 선택한 파일을 file형태로 fileInput에 저장
		let fileList = fileInput[0].files;
		// files에서 0번째로 저장된 fileInput(file)을 fileList에 저장(FileList의 요소로 들어간 File 객체)
		let fileObj = fileList[0];
		// 배열 fileList를 fileObj에 저장

		if (!fileCheck(fileObj.name, fileObj.size)) {
			return false;
		}

		// FromData 객체에 여러 파일 저장
		for (let i=0; i<fileList.length; i++) {
			formData.append("uploadFile", fileList[i]);
		}

		$.ajax({
			url: '/store/fileUploadAjax',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result) {
				showUploadImage(result);
			},
			error: function(result) {
				alert("이미지 파일만 업로드 가능합니다.");
			}
		});
	});


	// 이미지 출력 함수
	function showUploadImage(uploadResultArr) {
		if (!uploadResultArr || uploadResultArr.length == 0) {
			alert("이미지 불러오기에 실패하였습니다.");
			return false;
		}

		let uploadResult = $("#uploadResult tr td");
		var uploadResultCnt = ($("#uploadResult td").length);
		var str = "";
		var obj = uploadResultArr[0];
		console.log(uploadResultCnt);
		var fileCallPath
		= encodeURIComponent(obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);

		if ((uploadResultCnt != 0) && (uploadResultCnt%4 == 0)) {
			str += "<tr class='img-view'>";
		}
		str += "<td id='imgFile' data-uuid='" + obj.uuid;
		str += "' data-path='" + obj.uploadPath;
		str += "' data-filename='" + obj.fileName;
		str += "'><img src='/detail?fileName=" + fileCallPath + "'>";
		str += "<div><span>" + obj.fileName + "</span><b id='deleteBtn' data-file='";
		str += fileCallPath + "'>[×]</b></div></td>";

		if ((uploadResultCnt != 0) && (uploadResultCnt%4 == 0)) {
			$("#uploadResult tr:last").after(str);
		} else {
			$("#uploadResult td:last").after(str);
		}
	}


	// 첨부파일 삭제
	$("#uploadResult").on("click", "#deleteBtn", function(e) {
		let targetFile = $(this).data("file");
		let targetDiv = $(this).closest("#imgFile");

		$.ajax({
			url: '/deleteUploadFile',
			data: {fileName: targetFile},
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				alert("해당 파일 업로드를 취소하였습니다.");
				targetDiv.remove();
			},
			error: function(result) {
				alert("파일을 삭제하는 도중 문제가 발생했습니다.");
			}
		});
	})


	// 첨부파일 체크
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 5242880;	// 5MB

	function fileCheck(fileName, fileSize){
		if (!regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		if (fileSize >= maxSize) {
			alert("업로드 가능한 파일 크기를 초과하였습니다.");
			return false;
		}
		return true;
	}
	
})
</script>

<%@ include file="../includes/footer.jsp"%>