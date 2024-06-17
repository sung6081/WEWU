<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("button.btn:contains('삭제')").on("click",function(){
			self.location="/board/deleteDonation?payType=${param.payType}&payNo=${param.payNo}"
		});
	});
</script>

</head>
<body>
<input type="hidden" name="payType" value="${param.payType}" >
<input type="hidden" name="payNo" value="${param.payNo}" >	
	<h2>이름</h2>
	${donation.userName}
	<br/>	
	
	<h2>이메일</h2>
	${donation.email}
	<br/>

	<h2>전화번호</h2>
	${donation.phoneNum}
	<br/>
	
	<h2>생년월일</h2>
	${donation.userBirth}
	<br/>
	
	<h2>결제 날짜</h2>
	${donation.payDate}
	<br/>
	
	<h2>결제 수단</h2>
	${donation.payOption}
	<br/>
	<h2>결제 사용처</h2>
	${donation.payType}
	<br/>
	<h2>결제 금액</h2>
	${donation.payAmount}
	<br/>
	<button type="button" class="btn">삭제</button>

</form>

</body>
</html>