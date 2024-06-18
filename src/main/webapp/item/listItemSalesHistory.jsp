<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<c:set var="i" value="0" />
		<c:forEach var="itemPurchase" items="${list}"> <!-- 향상된 for문 돌릴 때 값을 저장하는 곳의 이름을 itemPurchase라고 한다는 의미. 따라서 refundCompdate, itemName도 저장된 곳의 이름인 itemPurchase. 으로 가져옴.   -->
		<tr>
			<a href="/item/getItemSalesHistory?itemPurchaseNo=${itemPurchase.itemPurchaseNo}">${itemPurchase.itemName}</a><br>
		</tr>
		</c:forEach>
</body>
</html>