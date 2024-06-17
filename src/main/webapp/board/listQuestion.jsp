<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 목록 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
</script>

</head>
<body>
<input type="hidden" name="questionType" value="${param.questionType}" >
	
	<table>
	<thead>
		<tr>No</tr>
		<tr>제목</tr>
		<tr>닉네임</tr>
		<tr>등록일</tr>
		<tr>답변상태</tr>
	</thead>
	<tbody>
		<c:forEach var="question" items="${list}">
		<tr>
			<td>${question.questionNo}</td>
			<td>${question.title}</td>
			<td>${question.nickName}</td>
			<td>${question.regDate}</td>
			<td>${question.replyState}</td>

		</tr>
		</c:forEach>
	</tbody>
</table>
	
	<br/>

</body>
</html>