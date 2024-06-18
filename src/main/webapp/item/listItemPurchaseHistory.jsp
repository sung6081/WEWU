<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script>
	window.onload=function()
	{
		var flag = "${flag}";
		if (flag != "") {
	        if(flag == "Y"){
	        	alert("구매취소 완료");
	        }else{
	        	alert("구매취소 실패");
	        }
		}else {
			
	    }
	}
	
	function updatePurchase(itemPurchaseNo)
	{
		if (!confirm("정말 구매를 취소하시겠습니까?")) {
	        // 취소(아니오) 버튼 클릭 시 이벤트
	    	return;
		} else {
	    	location.href="/item/updatePurchase?itemPurchaseNo="+itemPurchaseNo;
	        // 확인(예) 버튼 클릭 시 이벤트
	    }
	}

</script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<c:set var="i" value="0" />
	<c:forEach var="itemPurchase" items="${list}"> <!-- 향상된 for문 돌릴 때 값을 저장하는 곳의 이름을 itemPurchase라고 한다는 의미. 따라서 refundCompdate, itemName도 저장된 곳의 이름인 itemPurchase. 으로 가져옴.   -->
	<tr>
		<a href="/item/getItemSalesHistory?itemPurchaseNo=${itemPurchase.itemPurchaseNo}">${itemPurchase.itemName}</a> ==== <a href="javascript:updatePurchase(${itemPurchase.itemPurchaseNo})">구매취소</a><br>
	</tr>
	</c:forEach>
</body>
</html>