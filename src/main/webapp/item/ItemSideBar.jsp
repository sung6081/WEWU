<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="/vendors/feather/feather.css">
  <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="/text/css" href="/js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="/images/favicon.png" />
<title>Insert title here</title>
</head>
<body>

	<nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item active">
            <a class="nav-link" href="/item/getItemPurchaseHistoryList?buyerNickname=nick1">
              <i class="icon-paper menu-icon"></i>
              <span class="menu-title">아이템 구매내역</span>
            </a>
          </li>
      
          <li class="nav-item">
            <a class="nav-link" href="/item/getShoppingCartList?nickname=nick1">
              <i class="icon-paper menu-icon"></i>
              <span class="menu-title">장바구니 목록</span>
            </a>
          </li>
          
          <li class="nav-item">
	          <a class="nav-link" href="/pay/addPointCharge">
	            <i class="icon-paper menu-icon"></i>
	            <span class="menu-title">포인트 충전</span>
	          </a>
         </li>
        
          <li class="nav-item">
            <a class="nav-link" href="/pay/getPointChargeList">
              <i class="icon-paper menu-icon"></i>
              <span class="menu-title">포인트 충전내역</span>
            </a>
         </li>
         
	        
	      <li class="nav-item">
	       <a class="nav-link" href="/item/getRefundPointList?buyerNickname=nick1">
	       	<i class="icon-paper menu-icon"></i>
	         <span class="menu-title">포인트 환불 내역</span>
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
		       	<i class="icon-paper menu-icon"></i>
		         <span class="menu-title">아이템 판매내역</span>
		       </a>
	     	</li>          
         </c:if>
        </ul>
      </nav>

</body>
</html>