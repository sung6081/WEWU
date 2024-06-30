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
	function deleteItem(itemNo){ 	//function은 restcontroller이든, 그냥 controller이든 상관 없음. 이 형태로 function 만들면, function 이름 호출해서 사용 가능함. function deleteItem(itemNo)에서 괄호 앞에는 function 이름, 괄호 안에는 인자. 인자가 있어야 function 작동시킬 수 있으므로. 얘네는 function을 호출해야 쓸 수 있음.  
		
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

	
	<%--  컨트롤러 종류 상관없음. 이렇게 링크 이동시키는 것도 위의 function과 같은 형태로 만들 수 있음. 이렇게!! 근데 굳이 그렇게 하면 밑에 onclick은 onclick대로 걸어주고, 위에 호출해야 쓸수 있는 function은 그 function대로 만들어줘야 하므로 귀찮음. 3줄 써야함. 그래서 그냥 $(function() { 이런 타입으로 적은 것임. 
	function getItemList(){
		location.href="/item/getItemList"
	}
	--%>
	
	$(function() {  //얘는 실행하기 위한 조건 없음. function의 이름 없음. 괄호 안에 인자도 없음.왜 앞에  $ 쓰는지는 jquery라서 아직 설명 불가.   function을 작동하기 위한 조건 없음. 그리고 온클릭하면 바로 작동함. 즉 위의 호출되는 function처럼 호출을 해야 작동하는 게 아니라, 이미 호출되어 있는 상태임. 그래서 온클릭 이벤트만 발생하면 바로 작동하는 것. 일반 controller라서 이렇게 쓴 게 아님. 일반 컨트롤러든 restcontroller든 종류 상관없음. 쓸 수 있음. 그리고 여러 function들을 함께 적어놓은 것도, 이 function들이 모두 조건이 없고, 온클릭 이벤트 발생하면 바로 작동하므로 가능함(이미 호출되어 있으므로 온클릭 하면 호출할 필요 없이 바로 function이 기능함). 
		 $( ".btn-fw:contains('전체')" ).on("click" , function() {
			location.href="/item/getItemList" 
		 });
	
		 $( ".btn-fw:contains('식물 아이템')" ).on("click" , function() {
			location.href="/item/getItemList?searchCondition=식물" 
		 });
		 
		 $( ".btn-fw:contains('장식 아이템')" ).on("click" , function() {
				location.href="/item/getItemList?searchCondition=장식" 
	     });
		 
		 $( ".btn-sm:contains('Search')" ).on("click" , function() {
				
				location.href="/item/getItemList?searchKeyword="+$(".form-control").val() 
		 });
		 
		
		 
		 $( ".mt-auto:contains('구매하기')" ).on("click" , function() {
				
			 var itemNo = $(this).attr("id");
			 
			 location.href="/item/addPurchase?itemNo="+itemNo;
						
		 });
		 
		 $( "button.btn-primary:contains('아이템 수정')" ).on("click" , function() {
		//$( ".update" ).on("click" , function() {
			 //fncListRefundPoint();
			 var rslt = $("input[type='radio']:checked").val();
			 if(rslt == undefined)
			 {
			 	alert("수정할 아이템을 선택하세요.");
			 	return;
			 }else
			 {
				 //alert(rslt);
				 location.href="/item/updateItem?itemNo="+rslt;
			 }
			 
		 });
		
		 $( "button.btn-primary:contains('아이템 삭제')" ).on("click" , function() {
				//$( ".delete" ).on("click" , function() {
					 //fncListRefundPoint();
					 var rslt = $("input[type='radio']:checked").val();
					 if(rslt == undefined)
					 {
					 	alert("삭제할 아이템을 선택하세요.");
					 	return;
					 }else
					 {
						 deleteItem(rslt);
					 }
					 
				 });
				 
			 
		 $( "button.btn-primary:contains('아이템 등록')" ).on("click" , function() {
				location.href="/item/addItem"
		 });	 
			
		 <%--걍 예시임. 
		 $( ".btn-outline-dark:contains('구매하기')" ).on("click" , function() {
				getItemList()
		 });
		 --%>
	});
	
	<%--나는 location.href="/item/getItemList?searchKeyword="+${search.SearchKeyword}로 했는데 그러면 안 됨. 왜냐하면 이 uri는 값을 injection하기 위한 것임. 예를 들어, 아이템을 카테고리별로 보여줄 때는 searchCondition을 장식으로 injection해서 보내고 있음. 그러나 itemController의 getItemList 부분에, 값을 injection 할(?) 보내줄(?) 게 없음. (@ModelAttribute Search search , Model model)이라 Search search 앞에 " " 없으면, Search의 allias인 "search"로 값을 보내긴 함. 그러나 아직 한 번도 검색 안 했으므로 search 이용해서 못 가져옴(?). 그런데 뭘 검색할지 searchKeyword를 알려주긴 해야함. 그래서 밑에 있는 "form-control"의 val(밸류.value)를 가져와서, searchKeyword가 뭔지 알려줌.--%> 
		
	</script>
	
	<style>
     .btn-consistent {
            width: 100%; /* 버튼을 카드의 너비에 맞추어 일관되게 설정 */
            padding: 10px;
            font-size: 1rem;
            margin-top: 10px; /* 버튼 간의 간격 조절 */
        }

        .card-footer {
            text-align: center;
        }
        
        .search-button {
            width: 30px; /* 원하는 너비로 설정 */
        }
        
        .btn-yoon{
        	height:40px;
        	width: 130px
     
        }
    </style>
    
</head>
<body>
	
	
	
	<div class="container-fluid page-body-wrapper">
	<jsp:include page="ItemSideBar.jsp"/>
	
	
	<div class="main-panel">
	       	<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-12 grid-margin stretch-card">
						<div class="col-lg-4 col-md-6">
			                <div class="section-title">
			                    <h4><b>아이템 상점</b></h4>
			                </div>
			                
			                
			           	</div>
					</div>
		       	</div>
    
     
     <div class="col-lg-12 stretch-card">
     	<div class="col-lg-8 stretch-card">
		    	
	    </div>	
	    <div class="col-lg-4 grid-margin stretch-card">
		    <c:if test="${isAdmin}">
				<button type="button" class="btn btn-primary btn-yoon delete" style="float: right; margin-left: 10px;">아이템 삭제</button>
		    	<button type="button" class="btn btn-primary btn-yoon update" style="float: right; margin-left: 10px;">아이템 수정</button>
		        <button type="button" class="btn btn-primary btn-yoon" style="float: right; margin-left: 10px;">아이템 등록</button>
	     	</c:if>	
	    </div>
	</div>
	<div class="col-lg-14 stretch-card">
	<div class="col-lg-4 stretch-card" style="margin:0 0 20px 0;">
		<div class="btn-group" role="group" aria-label="Basic example">
			 <button type="button" class="btn btn-outline-secondary btn-yoon btn-fw">전체</button> 
             <button type="button" class="btn btn-outline-secondary btn-yoon btn-fw">식물 아이템</button>
             <button type="button" class="btn btn-outline-secondary btn-yoon btn-fw">장식 아이템</button>
        </div>
    </div>
    <div class="col-lg-5 stretch-card" style="margin:0 0 20px 0;">
	</div>
    <div class="col-lg-3 stretch-card" style="margin:0 0 20px 0x; ">
    <div class="form-group">
	        <div class="input-group">
	          <input type="text" class="form-control" aria-label="search" value="${search.searchKeyword}"> <%--form-control은 css의 많은 스타일들 중 어떤 걸 사용할지 알려줌. 그리고 여기의 value는 사용자가 어떤 걸 입력하는지 나타냄. 이게 있어야 검색어 입력하고 검색 버튼 눌렀을 때, 검색 결과 보여주고 검색결과 보여줄 때 검색어를 유지해서 보여줌.  --%>
	          <div class="input-group-append">
	            <button class="btn btn-sm btn-primary" type="button">Search</button>
	         </div>
	       </div>
	     </div> 
	</div>
	</div>
	
	<div class="col-lg-12 stretch-card">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:set var="i" value="0" />
                    <c:forEach var="item" items="${item}">
	                    <div class="col mb-5">
	                        <div class="card h-100">
	                            <!-- Product image-->
	                             <c:if test="${isAdmin}">
	                            <div class="mb-4" style="margin: 0 0 0 10px;">
					                  <div class="form-check">
					                    <label class="form-check-label text-muted">
					                      <input type="radio" class="form-check-input" name="pno" value="${item.itemNo}">
					                     
					                    </label>
					                  </div>
					                </div>
					             </c:if>   
	                            <img class="card-img-top" src="${item.itemImg}" alt="${item.itemName}" />
	                            <!-- Product details-->
	                            <div class="card-body p-4">
	                                <div class="text-left">
	                                 	<h5 class="fw-bolder">${item.itemCategory}아이템</h5> 
	                                    <!-- Product name-->
	                                    <h5 class="fw-bolder"><a href="/item/getItem?itemNo=${item.itemNo}" style="font-weight: bold;">${item.itemName}</a></h5>
	                                    <!-- Product price-->
	                                    <h5 class="fw-bolder">${item.itemPrice}p</h5>   
	                                </div>
	                                <!-- Product actions-->
		                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
		                                <div class="text-center">
		                                	<button class="btn btn-outline-dark mt-auto btn-consistent" type="button" onclick="addShoppingCart(${item.itemNo})">장바구니</button> <%--이 버튼은 on click을 여기서 잡아줌. 그래서 onclick 어디서 거는지는 따로 안 넣어줘도 됨. 대신 function 호출하는 건 있어야 함.   --%>
		                           		</div>
		                           	</div>
	                            	<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                               			<div class="text-center">
                               				<button class="btn btn-outline-dark mt-auto btn-consistent" type="button" id="${item.itemNo}" >구매하기</button><%-- card-footer가 약간의 여백과 함께 공간 잡아줌. 처음에 card footer 안에, 또 card footer 넣어서 모양 안 잡혔음.--%>
                            			</div>  
                            		</div>
	                            </div>
	                    	</div> 
	                    </div>
                    </c:forEach>
                </div>
           	 </div>
          </div>
      </div>
    
     <form id="addShoppingCart" method="post" action="/item/addShoppingCart">
  	 </form> 
   
	        
	       <%-- 
	        		
					<a href="/item/getItem?itemNo=${item.itemNo}">상세보기</a>===
					
		
				
	
       	--%> 
	
        </div>
	</div>
	                    
	<!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
</body>
</html>
