<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>상품 수정: 내 상점</title>
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
			<b style="font-size: 30px;">상품 수정</b>
		</div>
		<div class="form2">
			<div>
				<form role="form" action="/store/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="pno" value="${store.pno }">
					<input type="hidden" name="writer" value="${store.writer }">
					<div class="input-file">
						<table id="uploadResult" class="upload-tb">
						</table>
					</div>
					<br />
					<div>
						<b>거래 방법</b>
						<label><input type="radio" name="tradingCase" value="direct">직거래</label>
						<label><input type="radio" name="tradingCase" value="delivery">택배</label>
						<br /><br />
						<b>거래 지역</b>
						<input type="text" name="userAdd"
							value='<c:out value="${store.userAdd }"/>'
							placeholder="직거래 시 장소를 입력해 주세요"
							disabled style="background: #f3f3f3;">
					</div>
					<br />
					<div>
						<b>제목</b>
						<input id="regTitle" type="text" name="title"
							value='<c:out value="${store.title }" />' size="60"
							placeholder="제목을 입력해 주세요">
					</div>
					<br />
					<div>
						<b style="vertical-align: top; margin-top: 30px">상품 설명</b>
						<textarea id="regCon" name="content"
							placeholder="상품 설명을 입력해 주세요"><c:out
							value="${store.content }"/></textarea>
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
							value='<c:out value="${store.pdPrice }"/>'
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
							value='<c:out value="${store.pdStock }"/>'
							onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">개
					</div>
					<br />
					<div align="center">
						<button type="submit" data-oper='modify' class="btn-default">완료</button>
						<button type="submit" data-oper='remove' class="btn-default">삭제</button>
						<button type="button" data-oper='back' class="btn-default">뒤로</button>
						<button type="button" data-oper='list' class="btn-default">목록</button>
					</div>
				</form>
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

	var formObj = $("form");
	var pdId = '<c:out value="${store.pdId }"/>';
	// 버튼 동작 구현
	$('button').on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		
		if (operation === 'remove') {	// 삭제 버튼
			if (confirm("상품을 삭제하시겠습니까?") == true) {
				var str = "<input type='hidden' name='pdId' value='" + pdId + "'>";
				formObj.attr("action", "/store/remove").append(str).submit();
			} else {
				e.preventDefault();
				return false;
			}
		} else if (operation === 'back') {	// 뒤로 버튼
			history.back(-1);
			return;
		} else if (operation === 'list') {	// 목록 버튼
			formObj.attr("action", "/store/list").attr("method", "get").submit();
			self.location = "/store/list";

		} else if (operation === 'modify') {
			var direct = $("input[value='direct']");
			var delivery = $("input[value='delivery']");
			var userAdd = $("input[name='userAdd']");
			var priceInfo0 = $("input[name='priceInfo0']").is(":checked");
			var priceInfo1 = $("input[name='priceInfo1']").is(":checked");

			if ($("#regTitle").val() == "") {
				e.preventDefault();
				alert("제목을 입력해 주세요.");
				$("#regTitle").focus();
				return false;
			}
			if ($("#regCon").val() == "") {
				e.preventDefault();
				alert("내용을 입력해 주세요.");
				$("#regCon").focus();
				return false;
			}
			if ((direct.is(":checked")) && (userAdd.val() == "")) {
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
					if (confirm("직거래 시 배송비 관련 항목은 체크할 수 없습니다. 체크 해제 후 수정 완료하시겠습니까?") == true) {
						$("input[value='배송비 포함']").prop("checked", false);
						$("input[value='배송비 별도']").prop("checked", false);
					} else {
						return false;
					}
				}
			}
			if ($("input[name='pdPrice']").val() == "") {
				e.preventDefault();
				alert("상품 가격을 입력해 주세요.");
				$("input[name='pdPrice']").focus();
				return false;
			}
			if ($("input[name='pdStock']").val() == "") {
				e.preventDefault();
				alert("상품 수량을 입력해 주세요.");
				$("input[name='pdStock']").focus();
				return false;
			}
			if ($("#uploadResult td[id='imgFile']").length == 0) {
				e.preventDefault();
				alert("상품 이미지를 업로드해 주세요.");
				return false;
			}

			var str="";
			$("#uploadResult td[id='imgFile']").each(function(i, obj) {
				var jobj = $(obj);
				console.dir(jobj);
				console.log("-----------------");
				console.log(jobj.data("filename"))

				str += "<input type='hidden' name='imgList[" + i;
				str += "].fileName' value='" + jobj.data("filename") + "'>";

				str += "<input type='hidden' name='imgList[" + i;
				str += "].uuid' value='" + jobj.data("uuid") + "'>";

				str += "<input type='hidden' name='imgList[" + i;
				str += "].uploadPath' value='" + jobj.data("path") + "'>";

				str += "<input type='hidden' name='attachList[" + i;
				str += "].fileType' value='" + jobj.data("type") + "'>";
			});
			str += "<input type='hidden' name='pdId' value='" + pdId + "'>";
			formObj.append(str).submit();
		}
	});


	// 거래 방법 체크
	var tradingCase = '<c:out value="${store.tradingCase }"/>';
	var add = '<c:out value="${store.userAdd}"/>';
	if (tradingCase == "direct") {
		$("input[value='direct']").prop("checked", true);
		$("input[name='userAdd']").attr("disabled", false).css("background", "white");
	} else {
		$("input[value='delivery']").prop("checked", true);
	}
	// 주소 입력칸 활성화
	$("input:radio[value='direct']").change(function() {
		var checked = $(this).prop('checked');
		$("input[name='userAdd']").attr("disabled", false).css("background", "white");
		$("input[value='배송비 포함']").prop("checked", false);
		$("input[value='배송비 별도']").prop("checked", false);
		$("input[name='userAdd']").focus();
		$("input[name='userAdd']").val(add);
	});
	$("input:radio[value='delivery']").change(function() {
		var checked = $(this).prop('checked');
		$("input[name='userAdd']").attr("disabled", true).css("background", "#f3f3f3");
		$("input[name='userAdd']").val("");
	});


	// 상태 체크
	var state = '<c:out value="${store.state}"/>';
	if (state == "newState") {
		$("input[value='newState']").prop("checked", true);
	} else {
		$("input[value='old']").prop("checked", true);
	}


	// 체크박스 체크
	var info0 = '<c:out value="${store.priceInfo0}"/>';
	var info1 = '<c:out value="${store.priceInfo1}"/>';
	var info2 = '<c:out value="${store.priceInfo2}"/>';
	if (info0 != "") {
		$("input[name='priceInfo0']").prop("checked", true);
	}
	if (info1 != "") {
		$("input[name='priceInfo1']").prop("checked", true);
	}
	if (info2 != "") {
		$("input[name='priceInfo2']").prop("checked", true);
	}

	// 가격 길이 제한
	$("input[name='pdPrice']").on("keyup", function(e) {
		var maxlength = $(this).attr("maxlength");
		var value = $("input[name='pdPrice']").val();
		if (value.length > maxlength) {
			alert("가격이 입력 가능 범위를 벗어났습니다.");
			$(this).val(value.substring(0, maxlength));
		}
	});


	// 수량 길이 제한
	$("input[name='pdStock']").on("keyup", function(e) {
		var maxlength = $(this).attr("maxlength");
		var value = $("input[name='pdStock']").val();
		if (value.length > maxlength) {
			alert("수량은 백단위까지 입력 가능합니다.");
			$(this).val(value.substring(0, maxlength));
		}
	});


	// 첨부파일 목록 표시(기존 포함 파일 불러오기)
	(function() {
		$.getJSON("/store/getImgList", {pdId:pdId}, function(arr) {
			var str = "";
			if (arr.length == 0) {
				str += "<tr class='img-view'>";
				str += "<td class='file-box' id='fileBox'>";
				str += "<label for='file'>상품 이미지 업로드</label>";
				str += "<input type='file' id='file' class='file-item'";
				str += " name='uploadFile' multiple></td>";
				
				$("#uploadResult").html(str);
				return;
			}
			$(arr).each(function(i, img) {
				var fileCallPath
				= encodeURIComponent(img.uploadPath + "\\s_" + img.uuid + "_" + img.fileName);
				if (i == 0) {
					str += "<tr class='img-view'>";
					str += "<td class='file-box' id='fileBox'>";
					str += "<label for='file'>상품 이미지 업로드</label>";
					str += "<input type='file' id='file' class='file-item'";
					str += " name='uploadFile' multiple></td>";
				} else if ((i+1)%4==0) {
					str += "<tr class='img-view'>";
				}
				str += "<td id='imgFile' data-uuid='" + img.uuid;
				str += "' data-path='" + img.uploadPath;
				str += "' data-filename='" + img.fileName;
				str += "'><img src='/detail?fileName=" + fileCallPath + "'>";
				str += "<div><span>" + img.fileName + "</span><b id='deleteBtn' data-file='";
				str += fileCallPath + "'>[×]</b></div></td>";
			});
			$("#uploadResult").html(str);
		});
	})();


	// 첨부파일 삭제(업로드 취소) 처리
	$("#uploadResult").on("click", "#deleteBtn", function(e) {
		let targetFile = $(this).data("file");
		let targetDiv = $(this).closest("#imgFile");

		$.ajax({
			url: '/deleteUploadFile',
			data: {fileName: targetFile},
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				console.log("result: " + result);
				alert("해당 파일 업로드를 취소하였습니다.");
				targetDiv.remove();
			},
			error: function(result) {
				console.log(result);
				alert("파일을 삭제하는 도중 문제가 발생했습니다.");
			}
		});
	})


	// 첨부파일 등록 처리 코드(새로운 파일 업로드)
	var regex = new RegExp("(.*?)\.(jpg|png)$");
	var maxSize = 5242880;

	function fileCheck(fileName, fileSize) {
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

	$(document).on("change", "#file", function(e) {
		let formData = new FormData();
		let fileInput = $("input[name='uploadFile']");
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];

		if (!fileCheck(fileObj.name, fileObj.size)) {
			return false;
		}

		for (var i=0; i<fileList.length; i++) {
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


	// 새로 업로드한 첨부파일 목록
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

})
</script>

<%@ include file="../includes/footer.jsp"%>