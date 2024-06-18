<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 등록</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>

<form method="post" action="/board/addQuestion" encType="multipart/form-data" >
<input type="hidden" name="questionNo" value="${parma.questionNo}" >
<input type="hidden" name="questionType" value="${parma.questionType}" >
	<h2>제목</h2>
	<input type="text" name="title" >
	<br/>	
	
	<h2>내용</h2>
	<input type="text" name="contents" >
	<br/>

	<h2>질문 종류</h2>
	<input type="text" name="questionType" >
	<br/>
	
	<h2>문의 카테고리</h2>
	<input type="text" name="questionCategory" >
	<br/>
	
	<h2>사용자 닉네임</h2>
	<input type="text" name="nickName">
	<br/>
	
	
	<h2>이메일 주소</h2>
	<input type="text" name="email">
	<br/>
	
	<h2>전화 번호</h2>
	<input type="text" name="phoneNum">
	<br/>
	
	
	<input type="submit" value="등록하기">

</form>

</body>
</html>