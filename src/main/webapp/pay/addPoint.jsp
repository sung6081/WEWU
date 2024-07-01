<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>포인트 충전</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">


	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->

	<script>
	
	function pay()
	{
		var amount = $("#pointAmount").val();
		$.ajax
		({
			url : "/app/pay/kakaoPay",
			method : "GET",
			dataType: "json",
			data : 
			{
				item_name: "포인트",
                quantity: "1",
                total_amount: amount,
                tax_free_amount: "0",
			},
			beforeSend  : function () {
			  // XHR Header 포함, HTTP Request 하기전에 호출
			  
			},
			success : function(JSONData) {
				let pc_url = JSONData.next_redirect_pc_url;
				location.href=pc_url;
			},
			error	: function(xhr, status, error) {
			  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
			},
			complete : function(xhr, status) {
			  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
			}
		}); 
		
	}
	
		
	
	</script>
	</head>
	<body bgcolor="#ffffff" text="#000000">
			
					
				<div class="main-panel">
		       		<div class="content-wrapper">
		       		
			       		 <div class="col-12 grid-margin stretch-card">
			              <div class="card">
			                <div class="card-body">
						
					     <h4 class="card-title" style="font-size: 22px;">포인트 충전</h4>
					                  <p class="card-description">
					                       
					                  </p>
					                  <br>
					                  <form class="forms-sample" encType="multipart/form-data">
					                    <div class="form-group">
					                      <label for="exampleitemName" style="font-size: 15px;">충전할 포인트 양</label>
					                      <input type="text" name="pointAmount" class="form-control" id="pointAmount">
					                    </div>
					                    
					                     <div class="form-group row">
					                     <label for="exampleInputPassword2" class="col-sm-3 col-form-label" style="font-size: 15px;">현재 포인트</label>
					                     <div class="col-sm-12">
					                     	<label for="exampleInputUsername2" class="form-control">${user.currentPoint}p</label>
					                     </div>
					                   </div>
					                   
					                  <h4 style="font-size: 15px;">결제 수단</h4>
					                   
					                    <div class="text-right mt-4">
						                      <button type="button" class="btn btn-success" style="float: right; margin-left: 10px;" onclick="javascript:pay();">카카오페이</button>
	        							</div> 
	        							
	        							<%-- 넣을지말지 고민
	        							  <div class="overlay" id="overlay"></div>
										  <div class="popup" id="popup">
										    <span class="close" onclick="closePopup()">&times;</span>
										    <div id="popup-content"></div>
										  </div>
										--%>  
	        						
								</form>
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

