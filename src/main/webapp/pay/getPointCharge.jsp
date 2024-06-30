<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
	<title>포인트 충전내역 상세조회</title>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
	<!-- HEADER -->

	<script type="text/javascript">
	
		
	 $(function() {
			 $( "button.btn-primary:contains('목록')" ).on("click" , function() {
				location.href="/pay/getPointChargeList?buyerNickname=${user.nickname}"
			 });
	});
	


	</script>
	</head>
	<body>
						
				<div class="main-panel">
	        		<div class="content-wrapper">
		        		 <div class="row">
		                    <div class="col-lg-12 grid-margin stretch-card">
		                        <div class="card">
		                            <div class="card-body">
		                                <h4 class="card-title">포인트 충전내역 상세조회</h4>
		                                <p class="card-description">
		                                   
		                                </p>
		                                <div class="table-responsive">
		                                    <table class="table">
		                                        <thead>
		                                            <tr>
		                                            	<th>포인트 충전 날짜</th>
		                                            	<th>포인트 충전 금액</th>
														<th>충전된 포인트</th>
														<th>충전 후 포인트</th>
														<th>결제수단</th>
														<th>정상 결제 여부</th>
													</tr>
												</thead>
											<tbody>
											  <tr>
	                                                <td>${pay.payDate}</td>
											 	  	<td>${pay.payAmount}원</td>
											 	  	<td>${pay.payAmount}p</td>
											 	  	<td>${pay.afterChargePoint}p</td>
											 	  	<td>${pay.payOption}</td>
											 	  	<td>${pay.payFlag}</td>
	                                                <td>
	                                            </tr>
	                                        </tbody>
	                                    </table>
	                                </div>
	                                <div class="text-right mt-4">
	     		 						<button type="button" class="btn btn-primary">목록</button>
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
											
										
										
			

	
