<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>	

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	
	<script>
	<%--추가 전--%>
		function deleteShoppingCartList(shoppingCartNo)
		{
			if (!confirm("정말 삭제하시겠습니까?")) {
		        // 취소(아니오) 버튼 클릭 시 이벤트
		    	return;
			} else {
		    	location.href="/item/deleteShoppingCartList?shoppingCartNo="+shoppingCartNo;
		        // 확인(예) 버튼 클릭 시 이벤트
		    }
		}
		
		<%--추가 후--%>
		$(function() {
			 $( "button.btn-primary:contains('삭제하기')" ).on("click" , function() {
				 //fncListRefundPoint();
				 var rslt = $("input[type='radio']:checked").val();
				 if(rslt == undefined)
				 {
				 	alert("삭제할 상품을 선택하세요.");
				 	return;
				 }else
				 {
					 alert(rslt);
					 //location.href="/item/deleteShoppingCartList?shoppingCartNo=9"; //삭제할 때마다 원하는 아이템 카트 번호 넣어야 해서 이래놓음. 
				 }
				 
			});
			 
			 $( "button.btn-primary:contains('구매하기')" ).on("click" , function() {
				 //fncListRefundPoint();
				 var rslt = $("input[type='radio']:checked").attr("id"); //여기서는 구매하기는 requestParam이 itemNo고, 삭제하기는 shoppingCartNo임. 그럼 checked 되는 게 달라야 하지 않나...?
				 if(rslt == undefined)
				 {
				 	alert("구매할 상품을 선택하세요.");
				 	return;
				 }else
				 {
					 //addPurchase(rslt); 아직 없어서 이렇게 놓음. 
					 alert(rslt);
					
				 }
				 
			});
		});	
		
		
		
	</script>
	

	
	</head>
	
	<body>
	
			<div class="main-panel">
		        	<div class="content-wrapper">
						<div class="main-panel">
			        		<div class="content-wrapper">
				        		 <div class="row">
				                    <div class="col-lg-12 grid-margin stretch-card">
				                        <div class="card">
				                            <div class="card-body">
				                                <h4 class="card-title">장바구니 목록</h4>
				                                <p class="card-description">
				                                   
				                                </p>
		                                 	<div class="table-responsive">
			                                    <table class="table">
			                                        <thead>
			                                            <tr>
			                                            	<th>이미지</th>
															<th>아이템명</th>
															<th>개수</th>
															<th>가격</th>
															<th> </th>
														</tr>
													</thead>
												<tbody>
													<c:set var="i" value="0" />
													<c:forEach var="shoppingCart" items="${shoppingCart}"> <!-- 향상된 for문 돌릴 때 값을 저장하는 곳의 이름을 itemPurchase라고 한다는 의미. 따라서 refundCompdate, itemName도 저장된 곳의 이름인 itemPurchase. 으로 가져옴.   -->
														<tr>
													 	  <td>${shoppingCart.itemImg}</td>
													 	  <td>${shoppingCart.itemName}</td>
													 	  <td>${shoppingCart.itemCnt}</td>
													 	  <td>${shoppingCart.itemPrice}</td>
														  <td>
													 	  	<div class="form-check">
									                          <label class="form-check-label text-muted">
									                            <input type="radio" class="form-check-input" id="${shoppingCart.itemNo }" name="pno" value="${shoppingCart.shoppingCartNo}"> <%--shoppingCartNo여야 하나? 장바구니 삭제는 requestParam이 ShoppingCartNo이고, 구매하기는 itemNo임. --%> 
									                          </label>
									                        </div>
														  </td>
										         		</tr>
													</c:forEach>
													 
		                                        </tbody>
		                                    </table>
		                                </div>
		                                 <div class="text-right mt-4">
		                               <button type="button" class="btn btn-primary" style="float: right; margin-left: 10px;">삭제하기</button>
		                               <button type="button" class="btn btn-primary" style="float: right; margin-left: 10px;">구매하기</button>
		                     
			 					   	
					            </div>
		                       </div>
		                   </div>
		               </div>
		           </div>
		       </div>
		   </form>  	
	
	
	
	<%--
	<h1>장바구니</h1>
	<c:set var="i" value="0" />
		<c:forEach var="shoppingCart" items="${shoppingCart}"> 
			${shoppingCart.itemName}<a href="javascript:deleteShoppingCartList(12)">삭제하기</a><br>    
		</c:forEach>
		
	--%>	
	
	<!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
	
		</body>
	</html>