<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->
<meta charset="UTF-8">
<title>WEWU</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".btn-light").on("click", function() {
			self.location="/board/listQuestion?questionType=${param.questionType}"
		});
		
		

	});
	$(function(){
		$(".addQ").on("click",function(){
			$("form").attr("method","POST").attr("action","/board/addQuestion").submit();
		})
	})
</script>
<style type="text/css">
.jumbotron{
margin: 0 !important; /* 기본 마진 제거 */
background-color: #00A06C;
}

</style>
</head>
<body>

	
	
	<div class="container-fluid page-body-wrapper">
	<jsp:include page="boardSideBar.jsp"/>

	<div class="main-panel mb-5">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="jumbotron">
						<div class="container">
							<p class="display-4">
								<b><h3><c:if test="${param.questionType eq '자주'}"> 자주하는 질문 등록하기 </c:if>
							<c:if test="${param.questionType eq '문의'}"> 1:1 문의 등록하기 </c:if></h3></b>
							</p>
						</div>
					</div>
					<div class="card-body">
						<h1 class="card-title">
							
							
						</h1>
							<p class="card-description">${sessionScpoe.user.nickname}</p>
							
							
							<form class="forms-sample" method="post" action="/board/addQuestion" enctype="multipart/form-data">
								<input type="hidden" name="questionType"value="${param.questionType}">
								<input type="hidden" name="nickName" value="${user.nickname }">
								
							<div class="form-group row">
									<label for="title" class="col-sm-3 col-form-label">제목</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" name="title">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">문의 카테고리</label>
									<div class="col-sm-9">
										<select id="questionCategory" name="questionCategory" class="form-control">
											<option value="회원"selected>회원 정보</option>
											<option value="환불">환불</option>
											
											<option value="주문">주문/결제</option>
										</select>
									</div>
								</div>

								<div class="form-group row">
									<label for="title" class="col-sm-3 col-form-label">내용</label>
									<div class="col-sm-9">
										<textarea class="form-control" id="exampleTextarea1" name="contents" rows="40"></textarea>
									</div>
								</div>
								
								
								<c:if test="${param.questionType eq '자주'}">
									<!-- <input type="hidden" name="questionState" value="null"> -->
									<div class="form-group row">
										<label class="col-sm-3 col-form-label">답변 내용</label>
										<div class="col-sm-9">
											<textarea class="form-control" id="exampleTextarea1" name="reply" rows="10"></textarea>
										</div>
									</div>
								</c:if>
							  <button type="button" class="btn btn-primary mr-2 addQ">등&nbsp;록</button>
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