<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script>
	
	function deleteItem(itemNo){
		
	    if(!confirm("정말 삭제하시겠습니까?")){
			return;
			
	    }else{
	    	
	    	//모임 리스트
			$.ajax ({
				url	: "/app/item/deleteItem", // (Required) 요청이 전송될 URL 주소
				type  : "POST", // (default: ‘GET’) http 요청 방식
				async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				data  : JSON.stringify(
				 			{itemNo:itemNo}
				 		), // 요청 시 전달할 데이터
				processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				beforeSend  : function () {
				  // XHR Header 포함, HTTP Request 하기전에 호출
				  
				},
				success : function(data, status, xhr) {
					if(data.flag == "Y"){
						alert("삭제 완료");
						location.href="/item/getItemList";
					}else{
						alert("삭제 실패");
					}
				},
				error	: function(xhr, status, error) {
				  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				},
				complete : function(xhr, status) {
				  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				}
			});
	    }
	}
	
	function addShoppingCart(itemNo){
		
    	var input = "<input type=hidden name=itemNo value="+itemNo+">";
		input+= "<input type=hidden name=nickname value='nick1'>";
		$("#addShoppingCart").append(input);
	
    	// form 데이터 가져오기
       	var form = document.getElementById('addShoppingCart');
       	var formData = new FormData(form);

       	// JSON으로 변환
       	var jsonData = Object.fromEntries(formData);
       	
    	//모임 리스트
		$.ajax ({
			url	: "/app/item/addShoppingCart", // (Required) 요청이 전송될 URL 주소
			type  : "POST", // (default: ‘GET’) http 요청 방식
			async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
			cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
			timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
			data  : JSON.stringify(
						jsonData
			 		), // 요청 시 전달할 데이터
			processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
			contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
			dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
			beforeSend  : function () {
			  // XHR Header 포함, HTTP Request 하기전에 호출
			  
			},
			success : function(data, status, xhr) {
				if(data.flag == "Y"){
					alert("등록완료");
					
				}else{
					alert("실패");
				}
			},
			error	: function(xhr, status, error) {
			  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
			},
			complete : function(xhr, status) {
			  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
			}
		});
	    
	}
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="i" value="0" />
	<c:forEach var="item" items="${item}">
		<c:set var="i" value="${ i+1 }" />
		${ i } == ${item.itemNo } === ${item.itemName } === 
		<a href="/item/updateItem?itemNo=${item.itemNo}">수정하기</a>=== 
		<a href="javascript:deleteItem(${item.itemNo })">삭제하기</a>===
		<a href="/item/getItem?itemNo=${item.itemNo}">상세보기</a>===
		<!-- <a href="/item/addShoppingCart?itemNo=${item.itemNo}">장바구니</a>===<br>  -->
		
		<a href="javascript:addShoppingCart(${item.itemNo})">장바구니</a>===<br>
	</c:forEach>
	<br>
	<a href="/item/addItem">아이템 등록하기</a>
	<a href="/item/deleteItem">아이템 삭제하기</a>  <!-- 지금 안 되는 게 맞음.  -->
	<form id="getItemList" method="post" action="/item/getItemList">
		<input type="hidden" name="searchCondition" value="N">
		<input type="hidden" name="searchKeyword" value="추추">
		<input type="submit" value="검색하기">
	</form>
	<a href="/item/getRefundPointList?buyerNickname=nick1">환불내역 목록</a> <!-- 누구의 환불내역인지 보여주려면 buyernickname이 들어가야 하므로. 나중엔 session 넣을 것임.  -->
	<a href="/item/getItemSalesHistoryList">판매내역 목록</a>
	<a href="/item/getItemPurchaseHistoryList?buyerNickname=nick1">구매내역 목록</a>
	
	<form id="addShoppingCart" method="post" action="/item/addShoppingCart">
	
	</form>
	
	<a href="/item/getShoppingCartList?nickname=nick1">장바구니 목록</a>
	
	
	
</body>
</html>