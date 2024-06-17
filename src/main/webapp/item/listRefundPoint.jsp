<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>환불내역 목록조회</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncListRefundPoint(){
		
	$("form").attr("method" , "POST").attr("action" , "/item/getRefundPointList").submit();
}

	$(function() {
		 $( "td.ct_btn01:contains('상세조회')" ).on("click" , function() {
			 //fncListRefundPoint();
			 location.href="/item/getRefundPoint"
		});
	});	

	 $(function() {
			 $( "td.ct_btn01:contains('목록')" ).on("click" , function() {
				location.href="/item/getItemList"
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
	</thead>
	<tbody>
	<c:set var="i" value="0" />
		<c:forEach var="itemPurchase" items="${list}"> <!-- 향상된 for문 돌릴 때 값을 저장하는 곳의 이름을 itemPurchase라고 한다는 의미. 따라서 refundCompdate, itemName도 저장된 곳의 이름인 itemPurchase. 으로 가져옴.   -->
		<tr>
			<td>${itemPurchase.refundCompdate}</td>
			<td><a href="/item/getRefundPoint?itemPurchaseNo=${itemPurchase.itemPurchaseNo}">${itemPurchase.itemName}</a></td>
			<td>${itemPurchase.refundPoint}</td>
		</tr>
		</c:forEach>
	</tbody>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>					
					<td width="17" height="23">
					
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
					상세조회
					</td>
					<td width="17" height="23">
					
					</td>
					<td width="30"></td>					
					<td width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
					목록
					</td>
					<td width="14" height="23">
					
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	
	
	
	
</table>



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