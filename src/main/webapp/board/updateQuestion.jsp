<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("button.btn:contains('취소')").on("click", function() {
			self.location="/board/listQuestion?questionType=${param.questionType}";
		});
		
		$("button.btn:contains('수정하기')").on("click", function() {
			$(this).closest("form").submit();
		});
	});
</script>
</head>
<body>
	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->
	
	<div class="container-fluid page-body-wrapper">
	<jsp:include page="boardSideBar.jsp"/>
	
	<div class="main-panel">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title">
							<c:if test="${param.questionType eq '자주'}"> 자주하는 질문 수정하기 </c:if>
							<c:if test="${param.questionType eq '문의'}"> 1:1 문의 수정하기 </c:if>
						</h1>
						<p class="card-description">${question.nickName}</p>
						<form class="forms-sample" method="post" action="/board/updateQuestion" encType="multipart/form-data">
							<input type="hidden" name="questionNo" value="${question.questionNo}">
							<input type="hidden" name="questionType" value="${question.questionType}">
							<input type="hidden" name="nickName" value="${question.nickName }">
							<div class="form-group row">
								<label for="title" class="col-sm-3 col-form-label">제목</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="title" value="${question.title}">
								</div>
							</div>
							
							<div class="form-group row">
								<label class="col-sm-3 col-form-label">문의 카테고리</label>
								<div class="col-sm-3">
									<select id="questionCategory" name="questionCategory" class="form-control">
										<option value="회원" ${question.questionCategory == '회원' ? 'selected' : ''}>회원 정보</option>
										<option value="환불" ${question.questionCategory == '환불' ? 'selected' : ''}>환불</option>
										<option value="주문" ${question.questionCategory == '주문' ? 'selected' : ''}>주문/결제</option>
									</select>
								</div>
							</div>

							<div class="form-group row">
								<label for="contents" class="col-sm-3 col-form-label">내용</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="contents" value="${question.contents}">
								</div>
							</div>

							<c:if test="${param.questionType eq '자주' || isAdmin}">
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">답변 내용</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" name="reply" value="${question.reply}">
									</div>
								</div>
							</c:if>
							
							<button type="button" class="btn btn-primary mr-2">수정하기</button>
							<button type="button" class="btn btn-light">취&nbsp;소</button>
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
