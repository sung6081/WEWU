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
	
	<h2>제목</h2>
	${question.title}
	<br/>	
	
	<h2>내용</h2>
	${question.contents}
	<br/>

	<h2>질문 종류</h2>
	${question.questionType}
	<br/>
	
	<h2>문의 카테고리</h2>
	${question.questionCategory}
	<br/>
	
	<h2>사용자 닉네임</h2>
	${question.nickName}
	<br/>
	
	<h2>등록일</h2>
	${question.regDate}
	<br/>
	<h2>답변</h2>
	${question.reply}
	<br/>
	<h2>답변등록일</h2>
	${question.replyDate}
	<br/>
	<button type="button" class="btn">삭제</button>
	
	<button type="button" class="btn">답변 등록</button>
</form>

</body>
</html>