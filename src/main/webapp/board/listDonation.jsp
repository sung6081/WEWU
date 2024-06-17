<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후원 목록 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
</script>

</head>
<body>
<input type="hidden" name="payType" value="${param.payType}" >
	<table>
	<thead>
		<tr>No</tr>
		<tr>이름</tr>
		<tr>이메일</tr>
		<tr>전화번호</tr>
		<tr>생년월일</tr>
		<tr>후원 날짜</tr>
		<tr>결제 수단</tr>
		<tr>사용처</tr>
		<tr>금액</tr>
	</thead>
	<tbody>
		<c:forEach var="donation" items="${list}">
		<tr>
			<td>${donation.payNo}</td>
			<td>${donation.userName}</td>
			<td>${donation.email}</td>
			<td>${donation.phoneNum}</td>
			<td>${donation.userBirth}</td>
			<td>${donation.payDate}</td>
			<td>${donation.payOption}</td>
			<td>${donation.payType}</td>
			<td>${donation.payAmount}</td>

		</tr>
		</c:forEach>
	</tbody>
</table>
	
	<br/>

</body>
</html>