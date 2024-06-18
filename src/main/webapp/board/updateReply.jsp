<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 등록</title>
</head>
<body>
<form method="post" action="/board/updateReply" encType="multipart/form-data" >
<input type="text" name="questionNo" value="${param.questionNo}" >
<input type="text" name="questionType" value="${param.questionType}" >
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
	
	<h2>답변</h2>
	<input type="text" name="reply">
	<br/>
	
	<input type="submit" value="등록하기">

</form>
</body>
</html>