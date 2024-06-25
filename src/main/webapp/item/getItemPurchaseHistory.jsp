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
		 $( "button.btn-primary:contains('목록')" ).on("click" , function() {
			location.href="/item/getItemPurchaseHistoryList?buyerNickname=nick1"
		 });
	});
	
	</script>
	
	<body bgcolor="#ffffff" text="#000000">
	
		<div class="main-panel">
		        	<div class="content-wrapper">
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
			                                            	<th>구매날짜</th>
															<th>아이템명</th>
															<th>개수</th>
															<th>가격</th>
														</tr>
													</thead>
												<tbody>
														<tr>
													 	  <td>${itemPurchase.itemPurchaseDate}</td>
													 	  <td>${itemPurchase.itemName}</td>
													 	  <td>${itemPurchase.itemCnt}</td>
													 	  <td>${itemPurchase.itemPrice}</td>
													 	</tr>
				                                     </tbody>
				                                   	</table>
				                               	</div>
				                                <div class="text-right mt-4">
				     		 						<button type="button" class="btn-primary">목록</button>
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
											
																						
													 	 



