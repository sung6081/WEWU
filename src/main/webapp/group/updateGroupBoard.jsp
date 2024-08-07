<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<script>
			$(document).ready(function() {
				
				if("${user}" == "")
				{
					alert("모임은 WEWU 회원만 사용 가능합니다!");
					location.href="/";
				}
			});
			
			function updateGroupBoard()
			{
				if($("#boardName").val().trim() == "" || $("#boardName").val() == null)
	        	{
	        		alert("게시판명을 완성해서 작성하세요.");
        		    $("#boardName").focus();
        		    return;
	        	}else
	        	{
	        		var pattern = /([^가-힣a-z\x20])/i;
	        		var groupName = $("#boardName").val();
	        		if (pattern.test(groupName)) 
	        		{ 
	        		    alert("게시판명에 자음, 모음만 사용할 수 없습니다.");
	        		    $("#boardName").focus();
	        		    return;
	        		}
	        	}
				
	        	if($('input[name="boardType"]:checked').val() == null)
	        	{
	        		alert("게시판 뷰 타입을 작성하세요.");
        		    $("#boardType").focus();
        		    return;
	        	}
	        	
	        	if($("#boardIntro").val().trim() == "" || $("#boardIntro").val() == null)
	        	{
	        		alert("게시판 소개를 작성하세요.");
        		    $("#boardIntro").focus();
        		    return;
	        	}
	        	
	        	if($('input[name="boardRole"]:checked').val() == null)
	        	{
	        		alert("작성권한을 선택하세요.");
        		    $("#boardRole").focus();
        		    return;
	        	}
	        	
		        if(!confirm("정말 수정하시겠습니까?")){
					return;
					
		        }else{
		        	// form 데이터 가져오기
		        	var form = document.getElementById('updateGroupBoard');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/updateGroupBoard", // (Required) 요청이 전송될 URL 주소
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
							alert("수정이 완료되었습니다. \n변경된 내용을 확인하세요");
							var str = "";
									
							str += "<input type='hidden' name='typeNo' value = '"+ data.typeNo +"'>";
							str += "<input type='hidden' name='groupNo' value = '${group.groupNo}'>";
							$('#getGroupBoard').append(str);
							$('#getGroupBoard').submit();
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
	                  <h1 class="card-title">게시판 생성</h1>
	                  <h4 class="card-title">${group.groupName}</h4>
	                  <form class="forms-sample" id="updateGroupBoard" method="post">
	                  	<input type="hidden" name="groupNo" value="${group.groupNo}">
	                  	<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
	                  	<div class="form-group">
	                      <label>게시판 명</label>
	                      <input type="text" class="form-control" id="boardName" name="boardName" value="${groupBoard.boardName}" placeholder="게시판 명">
	                    </div>
	                    <div class="form-group">
	                      <label>게시판 타입</label>
	                      <div class="form-check">
		                    <label class="form-check-label text-muted">
		                      <input type="radio" class="form-check-input" name="boardType" value="L"
		                      ${groupBoard.boardType == 'L' ? 'checked' : ''}>
		                      리스트
		                    </label>
		                  </div>
		                  <div class="form-check">
		                    <label class="form-check-label text-muted">
		                      <input type="radio" class="form-check-input" name="boardType" value="T"
		                      ${groupBoard.boardType == 'T' ? 'checked' : ''}>
		                      썸네일
		                    </label>
		                  </div>
	                    </div>
	                    <div class="form-group">
	                      <label>게시판 소개</label>
	                      <input type="text" class="form-control"  placeholder="게시판 소개" id="boardIntro" name="boardIntro" value="${groupBoard.boardIntro}">
	                    </div>
	                    <div class="form-group">
	                      <label>게시판 권한</label>
	                      <div class="form-check">
		                    <label class="form-check-label text-muted">
		                      <input type="radio" class="form-check-input" name="boardRole" value="G"
		                      ${groupBoard.boardRole == 'G' ? 'checked' : ''}>
		                      모임장
		                    </label>
		                  </div>
		                  <div class="form-check">
		                    <label class="form-check-label text-muted">
		                      <input type="radio" class="form-check-input" name="boardRole" value="A"
		                      ${groupBoard.boardRole == 'A' ? 'checked' : ''}>
		                      전체
		                    </label>
		                  </div>
	                    </div>
	                  </form>
	                <button onclick="javascript:updateGroupBoard();"  class="btn btn-primary mr-2">수정하기</button>
	    			<button onclick="javascript:history.go(-1);" class="btn btn-light">취소</button>
	                </div>
	              </div>
	            </div>
				<form id="getGroupBoard" method="post" action="/group/getGroupBoard">
					
				</form>

        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>