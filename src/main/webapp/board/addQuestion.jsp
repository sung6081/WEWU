<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 등록</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>

	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->

	<div class="main-panel">
		<div class="content-wrapper">
			<div class="col-md-6 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title">
							<c:if test="${param.questionType eq '1'}"> 자주하는 질문 등록하기 </c:if>
							<c:if test="${param.questionType eq '2'}"> 1:1 문의 등록하기 </c:if>
						</h1>
							<p class="card-description">${sessionScpoe.user.usernickName}</p>
							<p class="card-description">nick1</p>
							
							<form class="forms-sample" method="post" action="/board/addQuestion" enctype="multipart/form-data">
								<input type="hidden" name="questionNo" value="${param.questionNo}">
								<input type="hidden" name="questionType"value="${param.questionType}">
								
							<div class="form-group row">
									<label for="title" class="col-sm-3 col-form-label">제목</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" name="title">
									</div>
								</div>

								<div class="form-group row">
									<label for="title" class="col-sm-3 col-form-label">내용</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" name="contents">
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">문의 카테고리</label>
									<div class="col-sm-9">
										<select id="questionCategory" name="questionCategory" class="form-control">
											<option value="배송" selected>배송</option>
											<option value="환불">환불</option>
											<option value="회원">회원 정보</option>
											<option value="주문">주문/결제</option>
										</select>
									</div>
								</div>
								
								<c:if test="${param.questionType eq '1'}">
									<div class="form-group row">
										<label class="col-sm-3 col-form-label">답변 내용</label>
										<div class="col-sm-9">
											<input type="text" class="form-control" name="title">
										</div>
									</div>
								</c:if>
							  <button type="submit" class="btn btn-primary mr-2">등록하기</button>
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