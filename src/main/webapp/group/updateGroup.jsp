<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>모임정보 수정 View 페이지</h1>
	${group }<br>
	<input type="hidden" name="groupNo" value="${group.groupNo}">
	닉네임 : <input type="text" name="leaderNick" value="${group.leaderNick}">
	<br>
	모임명 : <input type="text" name="groupName" value="${group.groupName}">
	<br>
	소개  : <input type="text" name="groupIntro" value="${group.groupIntro}">
	<br>
	태그  : <input type="text" name="groupHash" value="${group.groupHash}">
	<br>
	주소  : <input type="text" name="groupAddr" value="${group.groupAddr}" disabled>
	<br>
	계획  : <input type="text" name="groupPlan" value="${group.groupPlan}" disabled>
	<br>
	인원수 : <input type="text" name="groupPers" value="${group.groupPers}" disabled>
	<br>
	등급  : <input type="text" name="groupLevel" value="${group.groupLevel}" disabled>
</body>
</html>