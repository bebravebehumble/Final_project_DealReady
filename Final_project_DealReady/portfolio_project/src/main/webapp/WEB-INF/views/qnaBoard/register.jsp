<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<title>질문 작성: 궁그미 게시판</title>
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
			<b style="font-size: 30px;">질문 작성</b>
		</div>
		<div class="form2">
			<div align="center">
				<form role="form" action="/qnaBoard/register" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<div>
						<input id="regTitle" type="text" name="title"
							placeholder="제목을 입력해 주세요">
					</div>
					<br />
					<div>
						<input id="regWri" type="text" name="writer"
							value='<sec:authentication property="principal.username"/>'
							readonly="readonly">
					</div>
					<br />
					<div>
						<textarea id="regCon" name="content"
							placeholder="내용을 입력해 주세요"></textarea>
					</div>
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
					<br />
					<button type="submit" class="btn-default" id="regSub-btn">등록</button>
					<button type="reset" class="btn-default">다시</button>
					<button type="button" class="btn-default" onclick="history.back(-1);">뒤로</button>
				</form>
			</div>
		</div>
	</div>
</body>

<script>
$(document).ready(function(e) {
	// 게시글 제목 글자 수
	$('#regTitle').on('keyup', function() {
		if ($(this).val().length > 60) {
			$(this).val($(this).val().substring(0, 60));
			alert("질문 제목은 최대 60글자까지 입력 가능합니다.");
		}
	});


	// 게시글 내용 글자 수
	$('#regCon').on('keyup', function() {
		if ($(this).val().length > 1300) {
			$(this).val($(this).val().substring(0, 1300));
			alert("질문 내용은 최대 1300글자까지 입력 가능합니다.");
		}
	});


	// 입력 없이 등록 버튼 눌렀을 때
	var formObj = $("form[role='form']");
	$("#regSub-btn").on("click", function(e) {
		e.preventDefault();
		if ($("#regTitle").val().length == 0) {
			$(this).val($(this).val().substring(0, 0));
			e.preventDefault();
			alert("제목을 입력해 주세요.");
			return false;
		} else if ($("#regCon").val().length == 0) {
			$(this).val($(this).val().substring(0, 0));
			e.preventDefault();
			alert("내용을 입력해 주세요.");
			return false;
		}

		// 글 등록 클릭 시 첨부파일 정보 포함 전송
		var str ="";
		$("#uploadResult ul li").each(function(i, obj) {
			var jobj = $(obj);
			console.dir(jobj);
			console.log("------------------");
			console.log(jobj.data("filename"));

			// 동적으로 생성하는 히든값
			str += "<input type='hidden' name='attachList[" + i;
			str += "].fileName' value='" + jobj.data("filename") + "'>";

			str += "<input type='hidden' name='attachList[" + i;
			str += "].uuid' value='" + jobj.data("uuid") + "'>";

			str += "<input type='hidden' name='attachList[" + i;
			str += "].uploadPath' value='" + jobj.data("path") + "'>";

			str += "<input type='hidden' name='attachList[" + i;
			str += "].fileType' value='" + jobj.data("type") + "'>";
		});
		formObj.append(str).submit();
		// 처음엔 주석 처리, 테스트 후 주석 해제
	});

	
	// 첨부파일 설정
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


	// 로그인 처리 추가 후 첨부파일 등록 처리를 위한 변수
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	// 첨부파일 정보 저장
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

			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},

			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result) {
				showUploadResult(result);
			}
		});
	});


	// 첨부파일 목록 표시
	function showUploadResult(uploadResultArr) {
		if ((!uploadResultArr) || (uploadResultArr.length == 0)) {
			return false;
		}
		var uploadUL = $("#uploadResult ul");
		var str = "";

		$(uploadResultArr).each(function(i, obj) {
			var fileCallPath
			= encodeURIComponent(obj.uploadPath + "/" + obj.uuid
					+ "_" + obj.fileName);

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


	// 첨부파일 업로드 취소(삭제)
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

			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},

			dataType: 'text',
			type: 'POST',
			success: function(result) {
				alert("해당 파일 업로드를 취소하였습니다.");
				targetLi.remove();
			}
		});
	});
	
})
</script>

<%@ include file="../includes/footer.jsp"%>