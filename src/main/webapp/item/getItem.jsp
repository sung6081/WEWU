<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	<title>Insert title here</title>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		
		<script>
		function addShoppingCart(itemNo){
			
			$.ajax ({
				url	: "/app/item/addShoppingCart", // (Required) 요청이 전송될 URL 주소
				type  : "POST", // (default: ‘GET’) http 요청 방식
				async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				data  : JSON.stringify(
							{nickname:"${user.nickname}",
							 itemNo:itemNo}
				 		), // 요청 시 전달할 데이터
				processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				beforeSend  : function () {
				  // XHR Header 포함, HTTP Request 하기전에 호출
				  
				},
				success : function(data, status, xhr) {
					if(data.flag == "Y"){
						alert("장바구니 담기가 완료되었습니다.");
						
					}else{
						alert("로그인 후 시도하세요.");
					}
				},
				error	: function(xhr, status, error) {
				  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				},
				complete : function(xhr, status) {
				  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				}
			});
		    
		}
		
		$(function() {
			$( "button.btn-primary:contains('구매하기')" ).on("click" , function() {
				location.href="/item/addPurchase?itemNo="+${item.itemNo}
		 	});	 
		});
		
		</script>
		
		<style>
	     .btn-consistent {
	            margin-top: 50px; /* 버튼 간의 간격 조절 */ 
	     }
	     
	    .large.mb-1 {
        		color: grey; /* 회색으로 설정할 색상 */
   		 }
   		  
	    </style>
	    
	</head>
	<body>
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="card">
        			<div class="card-body">
        				<div class="col-lg-12 stretch-card">
        					<div class="col-lg-6 grid-margin stretch-card">
        						<img class="card-img-top mb-5 mb-md-0" style="width:572.111px; height:398.958px;" src="${item.itemImg}" alt="${item.itemName}" />
        					</div>
        					
        					<div class="col-lg-5 grid-margin">
		                        <br>
		                        <h1 class="display-5 fw-bolder" style="font-weight: bold; font-size: 2rem;">${item.itemName}</h1>
		                        <br>
		                        <br>
		                        <div class="fs-5 mb-5" style="font-size: 1.3rem; font-style: italic;">${item.itemPrice} p</div>
	                           <div class="form-group">
				                    <label for="exampleFormControlSelect1" style="font-size: 1.1rem;">개수</label>
				                    <select class="form-control form-control" id="exampleFormControlSelect1" style="font-size: 1.1rem;">
				                      <option>1</option>
				                    </select>
				                </div>
		                        <br>
		                        <p class="lead" style="font-style: italic;">"${item.itemEffect}"</p>
		                        <div class="d-flex">
		                            <button class="btn btn-primary btn-consistent" type="button" onclick="addShoppingCart(${item.itemNo})">
		                             장바구니 담기
		                            </button>
		                            <button class="btn btn-primary btn-consistent" type="button">
		                             구매하기
		                            </button>
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







<%-- 
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	${item}<br>
	<a href="/item/addPurchase?itemNo=${item.itemNo}">�����ϱ�</a>
</body>
</html>
--%>