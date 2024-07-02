<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<style>
			.sideIcon
			{
				width:20px;
				height:20px;
				margin:0 10px 0 0;
			}	
		</style>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script>
		
			function addApplGroup()
			{
		        if(!confirm("정말 개설신청 하시겠습니까?")){
					return;
					
		        }else{
		        	// form 데이터 가져오기
		        	var form = document.getElementById('addApplGroup');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/addApplGroup", // (Required) 요청이 전송될 URL 주소
						type	: "POST", // (default: ‘GET’) http 요청 방식
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
							alert("개설이 완료되었습니다. \n변경된 내용을 확인하세요");
							var str = "";
									
							str += "<input type='hidden' name='groupNo' value = '"+ data.groupNo +"'>";
							$('#getAddAppl').append(str);
							$('#getAddAppl').submit();
							 
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
		</script>
	</head>
	<body>
		
		<div class="main-panel">
        	<div class="content-wrapper">
	        	<div class="col-12">
        			<div class="row">
	        			<div class="col-md-2 grid-margin stretch-card">
						</div>
			        	<div class="col-md-8 grid-margin stretch-card">
			              <div class="card">
			                <div class="card-body">
			                  <h1 class="card-title"><img class="sideIcon" src="/group/img/home_7457021.png">모임개설신청</h1>
			                  <form class="forms-sample" id="addApplGroup" method="post" action="/group/addApplGroup">
			                  	
			                  	<input type="hidden" name="leaderNick" id="leaderNick" value="${user.nickname }">
			                    <div class="form-group">
			                      <label>모임명</label>&nbsp;&nbsp;<img class="sideIcon" src="/group/img/important.png">
			                      <input type="text" class="form-control" name="groupName" placeholder="모임명">
			                    </div>
			                    <div class="form-group">
			                      <label>모임소개</label>&nbsp;&nbsp;<img class="sideIcon" src="/group/img/important.png">
			                      <input type="text" class="form-control" name="groupIntro" placeholder="모임소개">
			                    </div>
			                    <div class="form-group">
			                      <label>모임태그</label>&nbsp;&nbsp;<img class="sideIcon" src="/group/img/important.png">
			                      <input type="text" class="form-control" name="groupHash" placeholder="모임태그">
			                    </div>
			                    <div class="form-group">
			                      <label>모임주소</label>&nbsp;&nbsp;<img class="sideIcon" src="/group/img/important.png">
			                      <input type="text" class="form-control" name="groupAddr" placeholder="모임주소">
			                    </div>
			                    <div class="form-group">
			                      <label>모임계획</label>&nbsp;&nbsp;<img class="sideIcon" src="/group/img/important.png">
			                      <input type="text" class="form-control" name="groupPlan" placeholder="모임계획">
			                    </div>
			                  </form>
			                  <form id="getAddAppl" method="post" action="/group/getAddAppl">
							
							  </form>
			                <button onclick="javascript:addApplGroup();"  class="btn btn-success mr-2">신청</button>
			    			<button onclick="javascript:history.go(-1);" class="btn btn-light">취소</button>
			                </div>
			              </div>
			              <div class="col-md-2 grid-margin stretch-card">
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