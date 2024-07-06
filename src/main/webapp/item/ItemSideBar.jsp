<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<script>
var loginCheck = "F";
if(${empty user == true})
{
	loginCheck = "Y";
}
$(function(){
	$( ".nav-link" ).hover(function(){
		$(this).css("cursor","pointer"); 
	 });
	
	$( ".nav-link:contains('아이템 구매내역')" ).on("click" , function() {
		if(loginCheck == "Y")
		{
			alert("로그인 후 사용할 수 있습니다.");
			return;
		}
		location.href="/item/getItemPurchaseHistoryList?buyerNickname=${user.nickname}";
	 });
	 
	 $( ".nav-link:contains('장바구니 목록')" ).on("click" , function() {
		if(loginCheck == "Y")
		{
			alert("로그인 후 사용할 수 있습니다.");
			return;
		}
		location.href="/item/getShoppingCartList?nickname=${user.nickname}";
	 });
	 
	 $( ".nav-link:contains('포인트 충전')" ).on("click" , function() {
		if(loginCheck == "Y")
		{
			alert("로그인 후 사용할 수 있습니다.");
			return;
		}
		location.href="/pay/addPoint.jsp";
	 });
	 
	 $( ".nav-link:contains('충전내역')" ).on("click" , function() {
		if(loginCheck == "Y")
		{
			alert("로그인 후 사용할 수 있습니다.");
			return;
		}
		location.href="/pay/getPointChargeList?buyerNickname=${user.nickname}";
	 });
})

</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container-fluid">
<div class="row">
	<nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="#">
              <i class="mdi mdi-checkbox-multiple-marked menu-icon"></i>
              <span class="menu-title">아이템 구매내역</span>
            </a>
          </li>
      
          <li class="nav-item">
            <a class="nav-link" href="#" >
              <i class="mdi mdi-cart menu-icon"></i>
              <span class="menu-title">장바구니 목록</span>
            </a>
          </li>
          
          <li class="nav-item">
	          <a class="nav-link"  href="#">
	            <i class="mdi mdi-square-inc-cash menu-icon"></i>
	            <span class="menu-title">포인트 충전</span>
	          </a>
         </li>
        
          <li class="nav-item">
            <a class="nav-link"  href="#">
              <i class="mdi mdi-credit-card menu-icon"></i>
              <span class="menu-title">충전내역</span>
            </a>
         </li>
         
	     
         <c:if test="${isAdmin}">
         <%-- 
			<li class="nav-item">
		       <a class="nav-link" href="/item/addItem">
		       	<i class="icon-paper menu-icon"></i>
		         <span class="menu-title">판매 아이템 등록</span>
		       </a>
		     </li>
		     
		     <li class="nav-item">
		       <a class="nav-link" href="/item/updateItem?itemNo=1">
		       	<i class="icon-paper menu-icon"></i>
		         <span class="menu-title">판매 아이템 수정</span>
		       </a>
		     </li>
		     --%>
	     	 <li class="nav-item">
		       <a class="nav-link" href="/item/getItemSalesHistoryList">
		       	<i class="mdi mdi-store menu-icon"></i>
		         <span class="menu-title">아이템 판매내역</span>
		       </a>
	     	</li>          
         </c:if>
        </ul>
      </nav>

</body>
</html>