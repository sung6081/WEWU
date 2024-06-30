<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 등록</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../../js/file-upload.js"></script>
<script src="/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		$("button.btn:contains('취소')").on("click", function() {
			self.location="/board/listBoard?boardType=${param.boardType}"
		});
		 $('footer').removeClass('fixed-bottom');
		 
		 $('.add-btn').on('click', function() {
			 alert('asdfa');
				oEditors.getById["acleContents"].exec("UPDATE_CONTENTS_FIELD", []);
				$('forms-sample').submit();
				
			});
	});
	window.onload=(function(){
		getGroupList();
	})
	function upload() {
		$('.file').click();
	};

	$('.file').on('change', function() {
		if($('.file').val() != null || $('.file').val() != '') {
			$('.upload-btn').html('<i class="ti-upload btn-icon-prepend"></i>'+$('.file').val());
		}
	});

	function getGroupList() {
        $.ajax({
            url: "/app/group/getUserGroupList",
            type: "POST",
            async: true,
            cache: true,
            timeout: 3000,
            data: JSON.stringify
            		(
            			{nickname: '${sessionScope.user.nickname}'}
            		),
            processData: false,
            contentType: "application/json",
            dataType: "json",
            success: function(data, status, xhr) {
                var str = "<ul class='list-group'>";
                for (var i = 0; i < data.length; i++) {
                    str += "<li class='list-group-item'>" + 
                           "<input type='radio' id='groupNo" + data[i].groupNo + "' name='groupNo' value='" + data[i].groupNo + "'>" +
                           "<label for='groupNo" + data[i].groupNo + "'> " + data[i].groupName + "</label>" +
                           "</li>";
                }
                str += "</ul>";
                $('#groupList').append(str);
            },
            error: function(xhr, status, error) {
                alert("그룹 목록 불러오기 실패.");
            }
        });
    }
</script>
</head>
<body>
	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->

	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />

		<div class="main-panel">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title">
							<c:if test="${param.boardType eq '1'}"> 공지 사항 </c:if>
							<c:if test="${param.boardType eq '2'}"> 모임 홍보 </c:if>
							<c:if test="${param.boardType eq '3'}"> 모임 후기 </c:if>
							<c:if test="${param.boardType eq '4'}"> 후원 </c:if>
						</h1>

						<p class="card-description">${sessionScope.user.nickname}</p>

						<form class="forms-sample" method="post" action="/board/addBoard"
							enctype="multipart/form-data">
							<input type="hidden" name="boardType" value="${param.boardType}">
							<input type="hidden" name="nickName" value="${sessionScope.user.nickname }">

							<div class="form-group row">
								<label for="title" class="col-sm-3 col-form-label">제목</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" name="title">
								</div>
							</div>

							<c:if test="${param.boardType eq '3'}">
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">모임 명</label>
									<div class="col-sm-3">
										<div id="groupList">
										
										</div>
									</div>
								</div>
							</c:if>

							<div class="form-group row">
								<div class="col-sm-12">
									<!-- <textarea class="form-control" id="exampleTextarea1" name="contents" rows="40"></textarea> -->
									<textarea class="form-control" id="contents" name="contents" style="width:100%;"></textarea>
									<script type="text/javascript">
										var oEditors = [];
										nhn.husky.EZCreator.createInIFrame
										({
											 oAppRef: oEditors,
											 elPlaceHolder: "contents",
											 sSkinURI: "/editor/SmartEditor2Skin.html",
											 fCreator: "createSEditor2"
										});
									</script>
								</div>
							</div>

							<div class="row">
								<button type="button" onclick="upload()" class="upload-btn btn btn-outline-danger btn-icon-text">
									<i class="ti-upload btn-icon-prepend"></i> 파일 등록
								</button>
								<input class="file" type="file" hidden="true" name="file" accept=".jpg,.jpeg,.png,.gif" multiple>
							</div>

							<button type="button" class="btn btn-primary mr-2 add-btn">등록</button>
							<button class="btn btn-light">취&nbsp;소</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- FOOTER -->
	<jsp:include page="/footer.jsp" />
	<!-- FOOTER -->
</body>
</html>
