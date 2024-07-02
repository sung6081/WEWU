<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
<title>포인트 충전 결과</title>

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	
	<script type="text/javascript">
	
		function fncAddPurchase(){
			if ("${user.currentPoint}" > ${item.itemPrice}) { <%--식물아이템은 구매가능. 장식아이템은 한 번 구매 기록이 있으면 구매 불가--%>
		        alert("구매 완료되었습니다.");
		      }else
		      {
	    		alert("포인트가 부족해 구매에 실패했습니다.");
	        	return;
		      }
			
			var form = document.getElementById("forms-sample")
			form.action="/item/addPurchase";
			form.submit();
		}
		
		$(function() {
			 $( "button.btn-success:contains('목록')" ).on("click" , function() {
				location.href="/item/getShoppingCartList?nickname=${user.nickname}"
			 });
		});
		
	</script>
	

</head>

<body>
	<div class="main-panel">
     	<div class="content-wrapper">
     	
     
            <div class="col-md-12 grid-margin stretch-card">
             <div class="card">
               <div class="card-body">
                 <h4 class="card-title">포인트 충전 결과</h4>
                 <p class="card-description">
                  축하드립니다. 포인트 충전을 성공하셨습니다. 
                 
                  
                 </p>
                 <form id="forms-sample" method="POST">
                 	<input type="hidden" name="buyerNickname" value="nick1">
					<input type="hidden" name="payNo" value="${pay.payNo}">
                   <div class="form-group row">
                     <label for="exampleInputUsername2" class="col-sm-3 col-form-label">충전된 포인트</label>
                     <div class="col-sm-9">
                       <label for="exampleInputUsername2" class="col-sm-3 col-form-label">${pay.payAmount}p</label>
                     </div>
                   </div>
                   <div class="form-group row">
                     <label for="exampleInputPassword2" class="col-sm-3 col-form-label">현재 포인트</label>
                     <div class="col-sm-9">
                     	<label for="exampleInputUsername2" class="col-sm-3 col-form-label">${user.currentPoint}p</label>
                     </div>
                   </div>
                   
             
                   	   			  
                 </form>
               </div>
             </div>
           </div>
          </div> 
          
    	
	<!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
</body>

</html>
