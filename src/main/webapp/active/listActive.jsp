<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>활동 목록 조회</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>

<table>
	<thead>
		<tr>No</tr>
		<tr>활동명</tr>
		<tr>활동 시작일</tr>
		<tr>활동 종료일</tr>
		<tr>활동 등록일</tr>
		<tr>활동 종료 여부</tr>
	</thead>
	<tbody>
		<c:forEach var="active" items="${list}">
		<tr>
			<td>${active.activeNo}</td>
			<td>${active.activeName}</td>
			<td>${active.activeStartDate}</td>
			<td>${active.activeEndDate}</td>
			<td>${active.activeRegDate}</td>
			<td>${active.stateFlag}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>

</body>
</html>