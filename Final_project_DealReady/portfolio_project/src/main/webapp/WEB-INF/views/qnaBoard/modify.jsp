<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>질문 수정: 궁그미 게시판</title>
<link rel="stylesheet" href="/resources/css/button/button.css">
<link rel="stylesheet" href="/resources/css/form/qnaForm.css">
<link rel="stylesheet" href="/resources/css/attach/attach.css">
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
			<b style="font-size: 30px;">질문 수정</b>
		</div>
		<div class="form2">
			<div align="center">
				<form role="form" action="/qnaBoard/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="writer" value="${board.writer }">
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
					<input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword" value="${cri.keyword }">
					<div>
						<input type="text" name="title" id="modiTitle"
							value='<c:out value="${board.title }" />' size="60">
					</div>
					<br />
					<div>
						<textarea rows="20" cols="62" id="modiCon"
							name="content"><c:out value="${board.content }"/></textarea>
					</div>
					<!-- 첨부파일 표시 -->
					<br />
					<div>
						<div>
							<div id="heading"></div>
							<div id="body">
								<div>
									<input type="file" name="uploadFile" multiple>
								</div>
								<div id="uploadResult">
									<ul class="attachList"></ul>
								</div>
							</div>
						</div>
					</div>
					<br />
					<!-- 첨부파일 표시 끝 -->
					<button type="submit" data-oper='modify' class="btn-default">완료</button>
					<button type="submit" data-oper='remove' class="btn-default">삭제</button>
					<button type="button" data-oper='back' class="btn-default">뒤로</button>
					<button type="button" data-oper='list' class="btn-default">목록</button>
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


	// 게시글 제목 글자 수
	$('#modiTitle').on('keyup', function() {
		if ($(this).val().length > 60) {
			$(this).val($(this).val().substring(0, 60));
			alert("질문 제목은 최대 60글자까지 입력 가능합니다.");
		}
	});


	// 게시글 내용 글자 수
	$('#modiCon').on('keyup', function() {
		if ($(this).val().length > 1300) {
			$(this).val($(this).val().substring(0, 1300));
			alert("질문 내용은 최대 1300글자까지 입력 가능합니다.");
		}
	});


	var formObj = $("form");
	// 버튼 동작 구현
	$('button').on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		
		if (operation === 'remove') {	// 삭제 버튼
			if (confirm("질문을 삭제하시겠습니까?") == true) {
				formObj.attr("action", "/qnaBoard/remove");
			} else {
				e.preventDefault();
				return false;
			}
		} else if (operation === 'back') {	// 뒤로 버튼
			history.back(-1);
			return;
		} else if (operation === 'list') {	// 목록 버튼
			formObj.attr("action", "/qnaBoard/list").attr("method", "get");
			var pageNumTag = $("input[name='pageNum']");
			var amountTag = $("input[name='amount']");
			var keywordTag = $("input[name='keyword']");
			var typeTag = $("input[name='type']");
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		} else if (operation === 'modify') {
			var str="";
			$("#uploadResult ul li").each(function(i, obj) {
				var jobj = $(obj);
				console.dir(jobj);
				console.log("-----------------");
				console.log(jobj.data("filename"))

				str += "<input type='hidden' name='attachList[" + i;
				str += "].fileName' value='" + jobj.data("filename") + "'>";

				str += "<input type='hidden' name='attachList[" + i;
				str += "].uuid' value='" + jobj.data("uuid") + "'>";

				str += "<input type='hidden' name='attachList[" + i;
				str += "].uploadPath' value='" + jobj.data("path") + "'>";

				str += "<input type='hidden' name='attachList[" + i;
				str += "].fileType' value='" + jobj.data("type") + "'>";
			});
			formObj.append(str);
		}
		formObj.submit();
	});


	// 첨부파일 목록 표시(기존 포함 파일 불러오기)
	(function() {
		var bno='<c:out value="${board.bno}"/>';
		$.getJSON("/qnaBoard/getAttachList", {bno:bno}, function(arr) {
			var str = "";
			$(arr).each(function(i, attach) {
				var fileCallPath
				= encodeURIComponent(attach.uploadPath + "/"
						+ attach.uuid + "_" + attach.fileName);

				str += "<li data-path='" + attach.uploadPath;
				str += "' data-uuid='" + attach.uuid;
				str += "' data-filename='" + attach.fileName;
				str += "' data-type='" + attach.fileType + "'><div>";
				str += "<img src='/resources/img/attach.png'&nbsp;";
				str += "<span>" + attach.fileName + "</span>&nbsp;<b data-file='";
				str += fileCallPath + "' data-type='file'>[x]</b></div></li>"
			});
			$("#uploadResult ul").html(str);
		});
	})();


	// 첨부파일 삭제(업로드 취소) 처리
	$("#uploadResult").on("click", "b", function(e) {
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");

		$.ajax({
			url: '/deleteFile',
			data: {
				fileName: targetFile,
				type: type
			},
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				alert("해당 파일 업로드를 취소하였습니다.");
				targetLi.remove();
			}
		});
	});


	// 첨부파일 등록 처리 코드(새로운 파일 업로드)
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;

	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert("업로드 가능한 파일 크기를 초과하였습니다.");
			return false;
		}
		if (regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}

	$("input[type='file']").change(function(e) {
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;

		for (var i=0; i<files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}

		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result) {
				showUploadResult(result);
			}
		});
	});


	// 새로 업로드한 첨부파일 목록
	function showUploadResult(uploadResultArr) {
		if ((!uploadResultArr) || (uploadResultArr.length == 0)) {
			return;
		}
		var uploadUL = $("#uploadResult ul");
		var str = "";

		$(uploadResultArr).each(function(i, obj) {
			var fileCallPath
			= encodeURIComponent(obj.uploadPath + "/"
					+ obj.uuid + "_" + obj.fileName)

			var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

			str += "<li data-path='" + obj.uploadPath;
			str += "' data-uuid='" + obj.uuid;
			str += "' data-filename='" + obj.fileName;
			str += "' data-type='" + obj.image + "'>";
			str += "<div><img src='/resources/img/attach.png'>&nbsp;";
			str += "<span>" + obj.fileName + "</span>&nbsp;<b data-file='";
			str += fileCallPath + "' data-type='file'>[x]</b></div></li>";
		});
		uploadUL.append(str);
	}

})
</script>

<%@ include file="../includes/footer.jsp"%>