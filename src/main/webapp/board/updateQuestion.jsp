<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 수정</title>
</head>
<body>
<form method="post" action="/board/updateQuestion" encType="multipart/form-data" >
<input type="text" name="questionNo" value="${question.questionNo}" >
<input type="text" name="questionType" value="${question.questionType}" >
	<h2>제목</h2>
	<input type="text" name="title" value="${question.title}">
	<br/>	
	
	<h2>내용</h2>
	<input type="text" name="contents" value="${question.contents}">
	<br/>

	<h2>질문 종류</h2>
	<input type="text" name="questionType" value="${question.questionType}">
	<br/>
	
	<h2>문의 카테고리</h2>
	<input type="text" name="questionCategory" value="${question.questionCategory}">
	<br/>
	
	<h2>사용자 닉네임</h2>
	<input type="text" name="nickName" value="${question.nickName}">
	<br/>
	
	<input type="submit" value="수정하기">

</form>
</body>
</html>