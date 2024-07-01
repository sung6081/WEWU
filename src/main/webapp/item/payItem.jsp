<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
<title>아이템 구매하기</title>

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	
	<script type="text/javascript">
	
		window.onload=function()
		{
			var cp = "${itemPurchase.currentPoint}";
			
		}
		
	
		function fncAddPurchase(){
			//alert("${user.currentPoint}" + " ===== " + "${item.itemPrice}");
			
			if ("${user.currentPoint}" > "${item.itemPrice}") { <%--식물아이템은 구매가능. 장식아이템은 한 번 구매 기록이 있으면 구매 불가--%>
		        alert("구매 완료되었습니다."); //사용자쪽에 현재 포인트 정보 넣어준 뒤, 잘 뜨게 하기. 
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
                  <h4 class="card-title">아이템 구매</h4>
                  <p class="card-description">
                  </p>
                  <div class="col-md-2">
                  	<img class="card-img-top mb-5 mb-md-0" src="${item.itemImg}" alt="${item.itemName}" />
                  </div>
	              <div class="col-md-2">
                  	<form class="forms-sample">
                  	
	                    <div class="form-group row">
	                     	<label for="exampleInputUsername2" class="col-sm-4 col-form-label">${item.itemName}</label>
	                    </div>
	                    
	                    <div class="form-group row">
	                    
	                    </div>
	                    
	                    <div class="form-group row">
	                    	<label for="exampleInputEmail2" class="col-sm-5 col-form-label">수량: 1개</label>
	                    </div>
	                    
	                    <br>
	                    
	                    <div class="form-group row">
	                    	<label for="exampleInputMobile" class="col-sm-3 col-form-label">${item.itemPrice}p</label>
	                    </div>
	                    
                     </form>	
                   </div> 
                </div>
              </div>
              </div>
            </div>
            <div class="col-md-12 grid-margin stretch-card">
             <div class="card">
               <div class="card-body">
                 <h4 class="card-title">구매 정보</h4>
                 <p class="card-description">
                  
                 </p>
                 <form id="forms-sample" method="POST">
                 	<input type="hidden" name="buyerNickname" value="nick1">
					<input type="hidden" name="itemNo" value="${item.itemNo}">
                   <div class="form-group row">
                     <label for="exampleInputUsername2" class="col-sm-3 col-form-label">구매 아이템</label>
                     <div class="col-sm-9">
                       <label for="exampleInputUsername2" class="col-sm-3 col-form-label">${item.itemPrice}p</label>
                     </div>
                   </div>
                   <div class="form-group row">
                     <label for="exampleInputPassword2" class="col-sm-3 col-form-label">최종 결제 가격</label>
                     <div class="col-sm-9">
                     	<label for="exampleInputUsername2" class="col-sm-3 col-form-label">${item.itemPrice}p</label>
                     </div>
                   </div>
                   
             
                   <button type="button" class="btn btn-success mr-2" onclick="javaScript:fncAddPurchase();" >구매하기</button>
        	  	   <button type="button" class="btn btn-success">장바구니 목록</button>
	   			  
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
