<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("button.btn:contains('삭제')").on("click",function(){
			self.location="/board/deleteQuestion?questionType=${param.questionType}&questionNo=${param.questionNo}"
		});
	});
	
	$(function(){
		$("button.btn:contains('답변등록')").on("click",function(){
			self.location="/board/updateRely?questionType=${param.questionType}&questionNo=${param.questionNo}"
		});
	});
</script>

</head>
<body>
<input type="hidden" name="questionNo" value="${param.questionNo}" >
<input type="hidden" name="questionType" value="${param.questionType}" >

		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title">${question.title}</h1>
						<p class="card-description">
							<c:if test="${param.questionType eq '1'}"> 자주하는 질문 </c:if>
							<c:if test="${param.questionType eq '2'}"> 1:1 문의</c:if>
							/ ${question.questionCategory}
							<hr>
						</p>
					
						<br>
						<br>
						<h2 class="card-title">문의 내용</h2>
						<p class="card-description">
							닉네임 : ${question.nickName} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 등록일 : ${question.regDate}
						</p>
						<blockquote class="blockquote">
							<p class="mb-0">
								${question.contents}
							</p>
						</blockquote>
							<br>
						<br>
						
						<c:if test="${not empty question.reply }">
							<h2 class="card-title">답변 내용</h2>
							<p class="card-description">
								답변등록일 : ${question.replyDate}
							</p>
							<blockquote class="blockquote">
								<p class="mb-0">
									${question.reply}
								</p>
							</blockquote>
						</c:if>
				
						<br/>
						<c:if test="${question.nickName eq session.user.role || session.user.role eq '1'}">
						<button type="button" class="btn btn-primary mr-2">삭제</button>
						</c:if>
						<c:if test="${question.questionType eq '2' && sessionScope.user.role eq '1'}">
							<button type="button" class="btn btn-primary mr-2">답변 등록</button>
						</c:if>
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