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
<script type="text/javascript">
	$(function(){
		$("button.btn:contains('취소')").on("click", function() {
			self.location="/board/listQuestion?questionType=${param.questionType}"
		});

	});
	
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
							

						<form class="forms-sample" method="post" action="/board/addBoard" enctype="multipart/form-data">

							<input type="hidden" name="boardType" value="${param.boardType}">
						
							<div class="form-group row">
								<label for="title" class="col-sm-3 col-form-label">제목</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="title">
								</div>
							</div>
							
							<div class="form-group row">
									<label class="col-sm-3 col-form-label">모임 명</label>
									<div class="col-sm-3">
										<select id="userGroupNo" name="userGroupNo" class="form-control">
										
											<option value="배송" selected>배송</option>
											<option value="환불">환불</option>
											<option value="회원">회원 정보</option>
											<option value="주문">주문/결제</option>
										</select>
									</div>
								</div>
							
							<div class="form-group row">
								<label for="userGroupNo" class="col-sm-3 col-form-label">사용자 모임 명</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="userGroupNo">
								</div>
							</div>

							<div class="form-group row">
								<label for="contents" class="col-sm-3 col-form-label">내용</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="contents">
								</div>
							</div>
							
							<div class="form-group row">
								<label for="fileName" class="col-sm-3 col-form-label">파일이름</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="fileName">
								</div>
							</div>

							<div class="form-group">
								<label>파일 등록</label> 
								<input type="file" name="img[]" class="file-upload-default">
								<div class="input-group col-xs-12">
									<input type="text" class="form-control file-upload-info"
									 disabled placeholder="Upload Image" multiple> 
										<span class="input-group-append">
										<button class="file-upload-browse btn btn-primary" type="button">Upload</button>
									</span>
								</div>
							</div>


							<div class="form-group row">
								<label for="fileName" class="col-sm-3 col-form-label">파일이름</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="fileName">
								</div>
							</div>
							
							<div class="form-group row">
								<label for="fileUUID" class="col-sm-3 col-form-label">파일UUID</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="fileUUID">
								</div>
							</div>
							
							<div class="form-group row">
								<label for="fileExt" class="col-sm-3 col-form-label">파일EXT</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="fileExt">
								</div>
							</div>
							
							<button type="submit" class="btn btn-primary mr-2">등&nbsp;록</button>
							<button class="btn btn-light" >취&nbsp;소</button>
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