<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>환불내역 상세조회</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncGetRefundPoint(){
		
	$("form").attr("method" , "POST").attr("action" , "/item/getRefundPoint").submit();
}
	
	 $(function() {
			 $( "td.ct_btn01:contains('목록')" ).on("click" , function() {
				location.href="/item/getRefundPointList?buyerNickname=nick1"
		});
	});
	


</script>
</head>
<body>
<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" id="detailForm" method="post">
<input type="hidden" name="buyerNickname" value="nick1">
<input type="hidden" name="itemPurchaseNo" value="${item.itemPurchaseNo}">

	<table>
	<thead>
		<tr>환불완료날짜</tr>
		<tr>아이템명</tr>
		<tr>환불된 포인트</tr>
		<tr>환불신청날짜</tr>
		<tr>환불성공여부</tr>
		<tr>개수</tr>
		<tr>가격</tr>
		<tr>환불된 포인트</tr>
		<tr>환불 전 포인트</tr>
		<tr>환불 후 포인트</tr>
	</thead>
	<tbody>
		<td>${itemPurchase}</td>
	</tbody>
</table>
</form>


<!-- 
	<c:set var="i" value="0" />
	<c:forEach var="item" items="${item}">
		<c:set var="i" value="${ i+1 }" />
		${ i } == ${item.itemNo } === ${item.itemName } === 
		<a href="/item/updateItem?itemNo=${item.itemNo}">수정하기</a>=== 
		<a href="javascript:deleteItem(${item.itemNo })">삭제하기</a>===
		<a href="/item/getItem?itemNo=${item.itemNo}">상세보기</a>===<br>
	</c:forEach>
 -->
	

	
	
</body>
</html>