<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>활동 업데이트</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>

<form method="post" action="/active/updateActive" encType="multipart/form-data" >

	<input type="hidden" name="activeNo" value="${activeNo}" >

	<h2>활동 이름</h2>
	<input type="text" name="activeName" value="${active.activeName}" >
	<br/>	
	
	<h2>그룹 번호</h2>
	<input type="text" disabled="disabled" value="${active.groupNo}" >
	<br/>

	<h2>활동 시작일</h2>
	<input type="text" name="activeStartDate" value="${active.activeStartDate}" >
	<br/>
	
	<h2>활동 종료일</h2>
	<input type="text" name="activeEndDate" value="${active.activeEndDate}" >
	<br/>
	
	<h2>위도</h2>
	<input type="text" name="activeX" value="${active.activeX}" >
	<br/>
	
	<h2>경도</h2>
	<input type="text" name="activeY" value="${active.activeY}" >
	<br/>
	
	<h2>활동 시작 시간</h2>
	<input type="text" name="activeStartTime" value="${active.activeStartTime}" >
	<br/>
	
	<h2>활동 끝 시간</h2>
	<input type="text" name="activeEndTime" value="${active.activeEndTime}" >
	<br/>
	
	<h2>활동 코멘트</h2>
	<input type="text" name="activeInfo" value="${active.activeInfo}" >
	<br/>
	
	<h2>활동 구역</h2>
	<input type="text" name="activeLocal" value="${active.activeLocal}" >
	<br/>
	
	<h2>활동 해쉬태그</h2>
	<input type="text" name="hash" value="" >
	<br/>
	
	<h2>활동 마커 이미지</h2>
	<input type="file" name="file">
	<br/>
	<br/>
	
	<input type="submit" value="등록하기">

</form>

</body>
</html>