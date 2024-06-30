<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script>
		
		function pay()
		{
			$.ajax
			({
				url : "/app/pay/kakaoPay",
				method : "GET",
				dataType: "json",
				data : 
				{
					item_name: '초코파이',
                    quantity: "4",
                    total_amount: "8800",
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
	<body>
		<div class="main-panel">
        	<div class="content-wrapper">
	        	<button onclick="javascript:pay();">카카오페이</button>
	        	<button id="chatBot">버튼</button>
        	</div>
        </div>
        <div class="overlay" id="overlay"></div>
		<div class="popup" id="popup">
		    <span class="close" onclick="closePopup()">&times;</span>
		    <div id="popup-content"></div>
		</div>
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>