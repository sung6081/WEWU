<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후원 등록</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>

<form method="post" action="/board/addDonation" encType="multipart/form-data" >
<input type="hidden" name="payType" value="후원" >

	<h2>이름</h2>
	<input type="text" name="userName" >
	<br/>	
	
	<h2>이메일</h2>
	<input type="text" name="email" >
	<br/>

	<h2>전화번호</h2>
	<input type="text" name="phoneNum" >
	<br/>
	
	<h2>생년월일</h2>
	<input type="text" name="userBirth" >
	<br/>
	
	<h2>결제수단</h2>
	<input type="text" name="payOption">
	<br/>
	
	
	<h2>결제 금액</h2>
	<input type="text" name="payAmount">
	<br/>
	
	
	
	<input type="submit" value="결제 하기">

</form>

</body>
</html>