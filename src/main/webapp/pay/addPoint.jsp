<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
   <meta charset="UTF-8">
   <title>포인트 충전</title>



   <!-- HEADER -->
   <jsp:include page="/header.jsp"/>
   <!-- HEADER -->
   
   <!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
   <!-- 포트원 결제 -->
   
   <script>
   
   function pay() {
      
   if($('input[name="pamount"]:checked').val() == null)
  	{
  		alert("충전할 포인트를 선택하세요.");
	    return;
  	}
   
	  <%--
      var pointAmount = $("#pointAmount").val();
      
      if(pointAmount == "" || pointAmount == 0 || pointAmount == null)
      {
         alert("충전할 액수를 입력하세요");
         return;
      }
      --%>
      
      
       if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
          
          var IMP = window.IMP;
          let uuid = self.crypto.randomUUID();
            IMP.init("imp04155511"); // 가맹점 식별코드
            IMP.request_pay({
                pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택
                pay_method: 'card', // 결제 방식
                merchant_uid: uuid, // 결제 고유 번호
                name: '포인트', // 제품명
                amount: $('input[name="pamount"]:checked').val(), // 가격
                //구매자 정보 ↓
                buyer_name: "${user.userName}",
                
            }, async function (rsp) { // callback
               console.log(rsp);
               if(rsp.success == true)
               {
                  console.log(rsp);
                  //성공
                  $("#buyerNickname").val("${user.nickname}");
                  if(rsp.pg_provider == "kakaopay")
                  {
                     $("#payOption").val("P");
                  }else
                  {
                     $("#payOption").val("Q");
                  }
                  
                  if(rsp.name == "포인트")
                  {
                     $("#payType").val("A");
                  }else
                  {
                     $("#payType").val("B");
                  }
                  
                  $("#payAmount").val(rsp.paid_amount);
                  $("#currentPoint").val("${user.currentPoint}");
                  $("#payFlag").val("T");
                  
                  $(".paySuccess").attr("method","POST").attr("action","/pay/kakaoPay/success").submit();
               }else
               {
            	   location.href="/pay/kakaoPay/fail";
                  //실패
                  
               }
            });
       } else { // 구매 확인 알림창 취소 클릭시 돌아가기
           return false;
       }
   }
   </script> 
   </head>
   <body bgcolor="#ffffff" text="#000000">
         
         <jsp:include page="/item/itemSideBar.jsp"/>
               
            <div class="main-panel">
                   <div class="content-wrapper">
                   
                       <div class="col-12 grid-margin stretch-card">
                       <div class="card">
                         <div class="card-body">
                  
                    <h4 class="card-title" style="font-size: 22px;">포인트 충전</h4>
                                 <p class="card-description">
                                      
                               </p>
                               <br>
                              <div class="form-group">
                                 <label for="exampleInputPassword2" class="col-sm-3 col-form-label" style="font-size: 15px;">현재 포인트</label>
                                 <div class="col-sm-12">
                                     <label for="exampleInputUsername2" class="form-control">${user.currentPoint}p</label>
                                  </div>
                             </div>
                             
                            <br>
                            <div class="col-sm-12">
                             <div class="form-group">
		                      <label>충전할 포인트</label>		                     
		                      <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="pamount" id="pamount" value="100">
			                      100p
			                    </label>
			                  </div>
		                      <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="pamount" id="pamount" value="500">
			                      500p
			                    </label>
			                  </div>
			                  <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="pamount" id="pamount" value="1000">
			                      1000p
			                    </label>
			                  </div>
			                  <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="pamount" value="5000">
			                      5000p
			                    </label>
			                  </div>
		                    </div>
                             <%-- 
                              <div class="form-group">
                                <label for="exampleitemName" class="col-sm-3 col-form-label" style="font-size: 15px;">충전할 포인트</label>
                                <div class="col-sm-12">
                                <input type="text" name="pointAmount" class="form-control" id="pointAmount">
                                </div>
                              </div>                           	                         	
                          	--%>
                          	
                             <br>
                             <br> 
                             <div class="text-right mt-4">
                                  <button type="button" class="btn btn-success" style="float: right; margin-left: 10px;" onclick="javascript:pay();">충전하기</button>
                            </div> 
                            <br>
                            <br>
                            <form class="paySuccess">
                               <input type="hidden" name="buyerNickname" id="buyerNickname">   <!-- 구매자 닉네임 -->
                               <input type="hidden" name="payOption" id="payOption">      <!-- 카카오? 네이버? -->
                               <input type="hidden" name="payType" id="payType">      <!-- 후원? 포인트? -->
                               <input type="hidden" name="payAmount" id="payAmount">      <!-- 충전금액 -->
                               <input type="hidden" name="currentPoint" id="currentPoint">   <!-- 현재 포인트 -->
                               <input type="hidden" name="payFlag" id="payFlag">      <!-- 성공여부 -->
                            </form>
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

