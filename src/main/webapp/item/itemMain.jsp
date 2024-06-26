<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script>
	function deleteItem(itemNo){ //restcontroller의 function은 $(function(){ 형식에서 괄호 앞에는 메소드, 괄호 안에는 인자인가?
		
	    if(!confirm("정말 삭제하시겠습니까?")){
			return;
			
	    }else{
	    	
	    	//모임 리스트
			$.ajax ({
				url	: "/app/item/deleteItem", // (Required) 요청이 전송될 URL 주소
				type  : "POST", // (default: ‘GET’) http 요청 방식
				async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				data  : JSON.stringify(
				 			{itemNo:itemNo}
				 		), // 요청 시 전달할 데이터
				processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				beforeSend  : function () {
				  // XHR Header 포함, HTTP Request 하기전에 호출
				  
				},
				success : function(data, status, xhr) {
					if(data.flag == "Y"){
						alert("삭제 완료");
						location.href="/item/getItemList";
					}else{
						alert("삭제 실패");
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
	}
	
	
	
	function addShoppingCart(itemNo){
		
    	var input = "<input type=hidden name=itemNo value="+itemNo+">";
		input+= "<input type=hidden name=nickname value='${user.nickname}'>";
		$("#addShoppingCart").html(input);
    	// form 데이터 가져오기
       	var form = document.getElementById('addShoppingCart'); //var은 데이터를 담는 변수. 다른 이름이어도 가능. 
		var formData = new FormData(form);

       	// JSON으로 변환
       	var jsonData = Object.fromEntries(formData);
		$.ajax ({
			url	: "/app/item/addShoppingCart", // (Required) 요청이 전송될 URL 주소
			type  : "POST", // (default: ‘GET’) http 요청 방식
			async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
			cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
			timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
			data  : JSON.stringify(
						jsonData
			 		), // 요청 시 전달할 데이터
			processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
			contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
			dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
			beforeSend  : function () {
			  // XHR Header 포함, HTTP Request 하기전에 호출
			  
			},
			success : function(data, status, xhr) {
				if(data.flag == "Y"){
					alert("장바구니 담기 완료");
					
				}else{
					alert("실패");
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
		 $( ".btn-fw:contains('전체')" ).on("click" , function() {
			location.href="/item/getItemList" 
		 });
	});
	
	
	$(function() {
		 $( ".btn-fw:contains('식물 아이템')" ).on("click" , function() {
			location.href="/item/getItemList?searchCondition=식물" 
		 });
	});
	
	
	$(function() {
		 $( ".btn-fw:contains('장식 아이템')" ).on("click" , function() {
			location.href="/item/getItemList?searchCondition=장식" 
		 });
	});
	
	
	$(function() { 
		$( ".btn-sm:contains('Search')" ).on("click" , function() {
			
			location.href="/item/getItemList?searchKeyword="+$(".form-control").val() 
		
		});	 
	});
	
	<%--나는 location.href="/item/getItemList?searchKeyword="+${search.SearchKeyword}로 했는데 그러면 안 됨. 왜냐하면 이 uri는 값을 injection하기 위한 것임. 예를 들어, 아이템을 카테고리별로 보여줄 때는 searchCondition을 장식으로 injection해서 보내고 있음. 그러나 itemController의 getItemList 부분에, 값을 injection 할(?) 보내줄(?) 게 없음. (@ModelAttribute Search search , Model model)이라 Search search 앞에 " " 없으면, Search의 allias인 "search"로 값을 보내긴 함. 그러나 아직 한 번도 검색 안 했으므로 search 이용해서 못 가져옴(?). 그런데 뭘 검색할지 searchKeyword를 알려주긴 해야함. 그래서 밑에 있는 "form-control"의 val(밸류.value)를 가져와서, searchKeyword가 뭔지 알려줌.--%> 
		
	
	
	
	</script>
</head>
<body>
	
	
	
	<div class="container-fluid page-body-wrapper">
	<jsp:include page="ItemSideBar.jsp"/>
	
	
	<div class="main-panel">
	       	<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 grid-margin stretch-card">
						<div class="col-lg-4 col-md-4">
			                <div class="section-title">
			                    <h4>아이템 상점</h4>
			                </div>
			           	</div>
					</div>
		       	</div>
		       	
		       	
	    <div class="form-group">
        <div class="input-group">
          <input type="text" class="form-control"  aria-label="search" value="${search.searchKeyword}"> <%--form-control은 css의 많은 스타일들 중 어떤 걸 사용할지 알려줌. 그리고 여기의 value는 사용자가 어떤 걸 입력하는지 나타냄. 이게 있어야 검색어 입력하고 검색 버튼 눌렀을 때, 검색 결과 보여주고 검색결과 보여줄 때 검색어를 유지해서 보여줌.  --%>
          <div class="input-group-append">
            <button class="btn btn-sm btn-primary" type="button">Search</button>
         </div>
       </div>
     </div> 		       	
     
			
		  <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
            
                <div class="btn-group" role="group" aria-label="Basic example">
                 <div id="test">
     	
     </div>
                  <button type="button" class="btn btn-outline-primary btn-fw">전체</button> 
                  <button type="button" class="btn btn-outline-primary btn-fw">식물 아이템</button>
                  <button type="button" class="btn btn-outline-primary btn-fw">장식 아이템</button>
                </div>
                <br>  
                <br>      
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:set var="i" value="0" />
                    <c:forEach var="item" items="${item}">
	                    <div class="col mb-5">
	                        <div class="card h-100">
	                            <!-- Product image-->
	                            <img class="card-img-top" src="${item.itemImg}" alt="${item.itemName}" />
	                            <!-- Product details-->
	                            <div class="card-body p-4">
	                                <div class="text-left">
	                                 	<h5 class="fw-bolder">${item.itemCategory}</h5> 
	                                    <!-- Product name-->
	                                    <h5 class="fw-bolder">${item.itemName}</h5>
	                                    <!-- Product price-->
	                                    <h5 class="fw-bolder">${item.itemPrice}p</h5>   
	                                </div>
	                                <!-- Product actions-->
		                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
		                                <div class="text-center"><button class="btn btn-outline-dark mt-auto" type="button" onclick="addShoppingCart(${item.itemNo})">장바구니</button>
		                           		</div>
		                            	<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
		                               		<div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">구매하기</a></div>
		                            	</div>
	                            	</div>
	                        	</div>
	                    	</div> 
	                    </div>
                    </c:forEach>
                </div>
           	 </div>
           </section>   
          </div>
      </div>
    
     <form id="addShoppingCart" method="post" action="/item/addShoppingCart">
  	 </form> 
   
	        
	       <%-- 
	        		
	        		<a href="/item/updateItem?itemNo=${item.itemNo}">수정하기</a>=== 
					<a href="javascript:deleteItem(${item.itemNo })">삭제하기</a>===
					<a href="/item/getItem?itemNo=${item.itemNo}">상세보기</a>===
					
				<br>
				<a href="/item/deleteItem">아이템 삭제하기</a>  <!-- 지금 안 되는 게 맞음.  -->
		
				
	
       	--%> 
	
        </div>
	</div>
	                    
	<!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
</body>
</html>
