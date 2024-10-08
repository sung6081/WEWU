<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<!-- 클라이언트 소스 로드 -->
		<link rel="stylesheet" href="/group/css/group.css" type="text/css" />
		<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
		<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
		
		<script>
			$(document).ready(function() {
				
				if("${user}" == "")
				{
					alert("모임은 WEWU 회원만 사용 가능합니다!");
					location.href="/";
				}
			});
			
		 	Dropzone.options.myGreatDropzone = { // camelized version of the `id`
		 			
	        	paramName: "file", // The name that will be used to transfer the file
			    acceptedFiles: ".jpg, .jpeg, .png, .pdf",
			    addRemoveLinks: true,
			    maxFilesize: 2, // MB
			    maxFiles: 1, // MB
			    init: function() {
			    	
			    },
			 	accept: function(file, done) {
		            done();
		        }
		 	}
		 	
		 	
			function updateGroup()
			{
		 		if($("#groupName").val().trim() == "" || $("#groupName").val() == null)
	        	{
	        		alert("모임명을 완성해서 작성하세요.");
        		    $("#groupName").focus();
        		    return;
	        	}else
	        	{
	        		var pattern = /([^가-힣a-z\x20])/i;
	        		var groupName = $("#groupName").val();
	        		if (pattern.test(groupName)) 
	        		{ 
	        		    alert("모임명에 자음, 모음만 사용할 수 없습니다.");
	        		    $("#groupName").focus();
	        		    return;
	        		}
	        	}
	        	
	        	if($("#groupIntro").val().trim() == "" || $("#groupIntro").val() == null)
	        	{
	        		alert("모임소개를 작성하세요.");
        		    $("#groupIntro").focus();
        		    return;
	        	}
	        	
	        	if($("#groupHash").val().trim() == "" || $("#groupHash").val() == null)
	        	{
	        		alert("모임태그를 작성하세요.");
        		    $("#groupHash").focus();
        		    return;
	        	}
	        	
	        	if($("#groupAddr").val().trim() == "" || $("#groupAddr").val() == null)
	        	{
	        		alert("모임주소를 작성하세요.");
        		    $("#groupAddr").focus();
        		    return;
	        	}
	        	
	        	if($("#groupPlan").val().trim() == "" || $("#groupPlan").val() == null)
	        	{
	        		alert("모임주소를 작성하세요.");
        		    $("#groupPlan").focus();
        		    return;
	        	}
	        	
		        if(!confirm("정말 수정하시겠습니까?")){
					return;
					
		        }else{
		        	// form 데이터 가져오기
		        	var form = document.getElementById('updateGroup');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/updateGroup", // (Required) 요청이 전송될 URL 주소
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
							alert("수정이 완료되었습니다.");
							$("#getGroup").submit();
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
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>

		<!-- SIDEBAR -->
		<jsp:include page="/group/groupSide.jsp"></jsp:include>
		<!-- SIDEBAR -->
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="col-md-12 grid-margin stretch-card">
	              <div class="card">
	                <div class="card-body">
	                  <h1 class="card-title"><img class="sideIcon" src="/group/img/change.png">모임수정</h1>
	                  <h4 class="card-title">${group.groupName}</h4>
	                  <form class="forms-sample" id="updateGroup">
	                  	<input type="hidden" name="groupNo" value="${group.groupNo}">
						<input type="hidden" name="memberNickName" value="${user.nickname}">
						<input type="hidden" name="frstQuest" value="${group.frstQuest}">
						<input type="hidden" name="scndQuest" value="${group.scndQuest}">
						<input type="hidden" name="thrdQuest" value="${group.thrdQuest}">
						<div class="form-group">
	                      <label>모임명</label>&nbsp;&nbsp;<img class="sideIcon arrow" src="/group/img/important.png">
	                      <p class="arrow_box">독특한 자신만의 모임명을 작성하세요!</p>
	                      <input type="text" class="form-control" id="groupName" name="groupName" value="${group.groupName}" placeholder="모임이름">
	                    </div>
	                    <div class="form-group">
	                      <label>모임소개</label>&nbsp;&nbsp;<img class="sideIcon arrow" src="/group/img/important.png">
	                      <p class="arrow_box">내 모임을 소개할 특별한 내용을 작성하세요!</p>
	                      <input type="text" class="form-control" id="groupIntro" name="groupIntro" value="${group.groupIntro}" placeholder="모임소개">
	                    </div>
	                    <div class="form-group">
	                      <label>모임태그</label>&nbsp;&nbsp;<img class="sideIcon arrow" src="/group/img/important.png">
	                      <p class="arrow_box">모임명과 함께 검색에 사용할 모임을 설명할 수 있는 태그를 작성하세요!</p>
	                      <input type="text" class="form-control" id="groupHash" name="groupHash" value="${group.groupHash}" placeholder="모임태그">
	                    </div>
	                     <div class="form-group">
	                      <label>모임주소</label>&nbsp;&nbsp;<img class="sideIcon arrow" src="/group/img/important.png">
	                      <p class="arrow_box">자주 모임을 가질 주소를 입력하세요!</p>
	                      <input type="text" class="form-control" id="groupAddr" name="groupAddr" value="${group.groupAddr}" placeholder="모임계획">
	                    </div>
	                    <div class="form-group">
	                      <label>모임계획</label>&nbsp;&nbsp;<img class="sideIcon arrow" src="/group/img/important.png">
	                      <p class="arrow_box">내 모임의 활동 계획을 작성하세요!</p>
	                      <input type="text" class="form-control" id="groupPlan" name="groupPlan" value="${group.groupPlan}" placeholder="모임계획">
	                    </div>
	                  </form>
	                  <label>모임사진</label>
	                  <br> 기존 : <br>
	                  <img style="width:250px; height:220px;" src="/group/upload/${group.groupImg }"/>
	                  <br>
	                  <form action="/group/groupImg" class="dropzone" id="my-great-dropzone" style="width:19%;">
	                  	<input type="hidden" name="groupNo" value="${group.groupNo}">
	                  </form>
					  <br>
	                  <button onclick="javascript:updateGroup();" class="btn btn-primary mr-2">수정</button>
	    			  <button onclick="javascript:history.go(-1);" class="btn btn-light">취소</button>
	                </div>
	              </div>
	            </div>
				<form id="getGroup" method="post" action="/group/getGroup">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
					<input type="hidden" name="memberNickName" value="${groupMember.memberNickName }">
				</form>
        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>