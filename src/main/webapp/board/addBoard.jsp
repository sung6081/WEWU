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

<form method="post" action="/board/addBoard" encType="multipart/form-data" >

<input type="hidden" name="boardType" value="${param.boardType}" >

	<h2>사용자 닉네임</h2>
	<input type="text" name="nickName" >
	<br/>

	<h2>제목</h2>
	<input type="text" name="title" >
	<br/>
	
	<h2>사용자 모임 명</h2>
	<input type="text" name="userGroupNo" >
	<br/>
	
	<h2>내용</h2>
	<input type="text" name="contents">
	<br/>
	
	<h2>파일이름</h2>
	<input type="text" name="fileName">
	<br/>
	
	
	<h2>파일UUID</h2>
	<input type="text" name="fileUUID">
	<br/>
	
	<h2>파일EXT</h2>
	<input type="text" name="fileExt">
	<br/>
	
	
	<input type="submit" value="등록하기">

</form>

</body>
</html>