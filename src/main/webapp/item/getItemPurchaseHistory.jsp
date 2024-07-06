<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>구매내역 상세조회</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	
	<script type="text/javascript">
	
	$(function() {
		 $( "button.btn-success:contains('목록')" ).on("click" , function() {
			location.href="/item/getItemPurchaseHistoryList?buyerNickname=${user.nickname}";
		 }); //여기부터 작업
	});
	
	</script>
	
	<body bgcolor="#ffffff" text="#000000">
	
	<jsp:include page="ItemSideBar.jsp"/>
	
		<div class="main-panel">
		        	<div class="content-wrapper">
			        			<div class="row">
				                    <div class="col-lg-12 grid-margin stretch-card">
				                        <div class="card">
				                            <div class="card-body">
				                                <h4 class="card-title">구매내역 상세조회</h4>
				                                <p class="card-description">
				                                   
		        								</p>
			                                <div class="table-responsive">
			                                    <table class="table">
			                                        <thead>
			                                            <tr>
			                                            	<th>환불신청날짜</th>
			                                            	<th>환불완료날짜</th>
															<th>아이템명</th>
															<th>개수</th>
															<th>가격</th>
															<th>아이템 사용상태</th>
															<th>구매상태</th>
															<th>환불된 포인트</th>
															<th>환불 전 포인트</th>
															<th>환불 후 포인트</th>
															
														</tr>
													</thead>
												<tbody>
														<tr>
													 	  <td>${itemPurchase.refundAskdate}</td>
													 	  <td>${itemPurchase.refundCompdate}</td>
													 	  <td>${itemPurchase.itemName}</td>
													 	  <td>${itemPurchase.itemCnt}</td>
													 	  <td>${itemPurchase.itemPrice}</td>
													 	  <td>
													 	  	<c:choose>
			                                                        <c:when test="${itemPurchase.itemCnt == itemPurchase.itemStock}">
			                                                        미사용
			                                                        </c:when>
			                                                        <c:when test="${itemPurchase.itemCnt != itemPurchase.itemStock}">
			                                                        사용 완료
			                                                        </c:when>
			                                               	</c:choose>
											 	 	 	 </td>
											 	 	 	 <td>
												 	     <c:choose>
		                                                        <c:when test="${itemPurchase.refundFlag == 'Y'}">
		                                                        환불 완료
		                                                        </c:when>
		                                                        <c:when test="${itemPurchase.refundFlag == 'Z'}">
		                                                        환불 실패
		                                                        </c:when>
		                                                        <c:otherwise>
	                                                            환불 미신청
	                                                        	</c:otherwise>
		                                               	</c:choose>
												 	    </td>
												 	    <td>${itemPurchase.refundPoint}</td>
												 	    <td>${itemPurchase.beforeRefundpoint}</td>
												 	    <td>${itemPurchase.afterRefundpoint}</td>
												 	    
												 	  
												 	  
												 	  
													 	</tr>
				                                     </tbody>
				                                   	</table>
				                               	</div>
				                                <div class="text-right mt-4">
				     		 						<button type="button" class="btn btn-success">목록</button>
			   		 					   		</div>
				                            </div>
				                        </div>
				                    </div>
				                </div>
				            </div>
				        </div>
				    
	    
	    	<!-- FOOTER -->
		    <jsp:include page="/footer.jsp" />
		    <!-- FOOTER -->
	</body>
</html>
											
																						
													 	 



