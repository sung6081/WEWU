<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<style>
  .large-icon {
    font-size: 52px; /* 원하는 크기로 설정 */
  }
</style>
<script type="text/javascript">

	$(function() {
		$("button.btn:contains('취소')").on("click", function() {
			self.location = "/board/listBoard?boardType=${param.boardType}"
		});

	});

	function upload() {

		$('.file').click();

	};

	$('.file').on(
			'change',
			function() {

				if ($('.file').val() != null || $('.file').val() != '') {

					$('.upload-btn').html(
							'<i class="ti-upload btn-icon-prepend"></i>'
									+ $('.file').val());

				}

			});
	
	$(function(){
		$("i.")
	})
	
	
	
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
						<p class="card-description">${sessionScpoe.user.usernickName}</p>
						<p class="card-description">nick1</p>
						<form class="forms-sample" method="post"
							action="/board/updateBoard" enctype="multipart/form-data">

							<input type="hidden" name="boardType" value="${param.boardType}">
							<input type="hidden" name="boardNo" value="${param.boardNo}">
							<input type="hidden" name="nickName" value="nick1">

							<div class="form-group row">
								<label for="title" class="col-sm-3 col-form-label">제목</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" name="title"
										value="${board.title }">
								</div>
							</div>
							<c:if test="${param.boardType eq '3'}">
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">모임 명</label>
									<div class="col-sm-3">
										<select id="userGroupNo" name="userGroupNo"
											class="form-control">

											<option value="1" selected>플로깅</option>
											<option value="2">리필스테이션</option>

										</select>
									</div>
								</div>
							</c:if>
							<div class="form-group row">
								<label for="exampleFormControlTextarea1"
									class="col-sm-3 col-form-label">내용</label>
								<div class="col-sm-12">
									<textarea class="form-control" id="exampleTextarea1" name="contents" rows="40" placeholder="${board.contents}"></textarea>
									
								</div>
							</div>

							<!-- <div class="form-group">
								<label>파일 등록</label> 
								<input type="file" name="img[]" class="file-upload-default">
								<div class="input-group col-xs-12">
									<input type="text" class="form-control file-upload-info"
									 disabled placeholder="Upload Image" multiple> 
										<span class="input-group-append">
										<button class="file-upload-browse btn btn-primary" type="button">Upload</button>
									</span>
								</div>
							</div> -->

							<div class="form-group row">
								<div class="col-sm-12">
									<%-- ${boardFile.fileName} --%>
									<c:forEach var="file" items="${boardFile}">
										<img src="${file.fileName }">
										<i class="mdi mdi-close-box-outline" style="font-size: 24px;"></i>
										<br>
									    <br>
									</c:forEach>

								</div>
							</div>
							<div class="row">
								<button type="button" onclick="upload()"
									class="upload-btn btn btn-outline-danger btn-icon-text">
									<i class="ti-upload btn-icon-prepend"></i> 파일 등록
								</button>
								<input class="file" type="file" hidden="true" name="file"
									accept=".jpg,.jpeg,.png,.gif" multiple>
							</div>

							<button type="button" class="btn btn-primary mr-2">수&nbsp;정</button>
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