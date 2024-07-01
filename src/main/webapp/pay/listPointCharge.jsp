<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
<title>포인트 충전내역 목록조회</title>

	<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
	<!-- HEADER -->


<script type="text/javascript">


	$(function() {
		 $( "button.btn-success:contains('상세조회')" ).on("click" , function() {
			 //fncListRefundPoint();
			 var rslt = $("input[type='radio']:checked").val();
			 if(rslt == undefined)
			 {
			 	alert("상세조회할 충전 내역을 선택하세요.");
			 	return;
			 }else
			 {
				 //alert(rslt);
				 location.href="/pay/getPointCharge?payNo="+rslt;
			 }
			 
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
		                                <h4 class="card-title">포인트 충전내역 목록조회</h4>
		                                <p class="card-description">
		                                   
		                                </p>
		                                <div class="table-responsive">
		                                    <table class="table">
		                                        <thead>
		                                            <tr>
		                                            	<th>포인트 충전 날짜</th>
														<th>포인트 충전금액</th>
														<th>정상 결제 여부</th>
														<th> </th>
													</tr>
												</thead>
											<tbody>
											<c:set var="i" value="0" />
											<c:forEach var="pay" items="${list}"> <!-- 향상된 for문 돌릴 때 값을 저장하는 곳의 이름을 itemPurchase라고 한다는 의미. 따라서 refundCompdate, itemName도 저장된 곳의 이름인 itemPurchase. 으로 가져옴.   -->
												<tr>
											 	  <td>${pay.payDate}</td>
											 	  <td>${pay.payAmount}</td>
											 	  <td>
												 	   <c:choose>
		                                                        <c:when test="${pay.payFlag == 'T'}">
		                                                            결제 성공
		                                                        </c:when>
		                                                        <c:when test="${pay.payFlag == 'F'}">
		                                                            결제 실패
		                                                        </c:when>
		                                               </c:choose>
											 	  </td>
											 	  <td>
											 	  	<div class="form-check">
							                          <label class="form-check-label text-muted">
							                            <input type="radio" class="form-check-input" name="pno" value="${pay.payNo}">
							                          </label>
							                        </div>
												  </td>
								         		</tr>
											</c:forEach>
											 
                                        </tbody>
                                    </table>
                                </div>
                                <div class="text-right mt-4">
                                <button type="button" class="btn btn-success" style="float: right; margin-left: 10px;">상세조회</button>
                                <!-- 
							    <div class="text-right mt-4">
	     		 						<button type="button" class="btn btn-success">목록</button>
		 					   	</div>
		 					   	 -->
		 					   	
				            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>  	
    
    
    	    	<!-- FOOTER -->
		    <jsp:include page="/footer.jsp" />
		    <!-- FOOTER -->
	</body>
</html>
					
		 					   	
		 					   	
		 					   				 
											 
											
											
	
	


