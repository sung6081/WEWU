<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
			window.onload = function() {
				// form 데이터 가져오기
	        	var form = document.getElementById('getGroupBoardList');
	        	var formData = new FormData(form);

	        	// JSON으로 변환
	        	var jsonData = Object.fromEntries(formData);
				//모임 리스트
				$.ajax ({
					  url	: "/app/group/getGroupBoardList", // (Required) 요청이 전송될 URL 주소
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
						  var str = "";
						  for(var i = 0 ; i < data.length ; i ++){
							  str += "<a href=javascript:getGroupBoard(" + data[i].typeNo + ")>"+ data[i].boardName +"</a><br>";
						  }
						  $('#boardList').append(str);
						  str = "";
					  },
					  error	: function(xhr, status, error) {
					    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					  },
					  complete : function(xhr, status) {
					    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					  }
				});
			}
			
			function addApplJoin(){
				var form = document.getElementById("addApplJoin");
				form.action="/group/addApplJoin";
				form.submit();
			}
			
			function updateApplJoinForm(){
				var form = document.getElementById("updateApplJoinForm");
				form.action="/group/updateApplJoinForm";
				form.submit();
			}
			
			function addGroupBoard(){
				var form = document.getElementById("addGroupBoard");
				form.action="/group/addGroupBoard";
				form.submit();
			}
			
			function getGroupBoard(typeNo){
				var form = document.getElementById("getGroupBoard");
				var str = "<input type=hidden name=typeNo value=" + typeNo +">";
				$('#getGroupBoard').append(str);
				form.action="/group/getGroupBoard";
				form.submit();
			}
		</script>
		<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<h1>모임 정보</h1>
				${group}
				<br><br>
				모임 명 : ${group.groupName}
				<br>
				모임소개 : ${group.groupIntro} 
				<br>
				해시태그 : ${group.groupHash} 
				<br>
				모임주소 : ${group.groupAddr} 
				<br>
				모임계획 : ${group.groupPlan} 
				<br>
				모임원수 : ${group.groupPers} 
				<br>
				<h1>게시판 종류</h1>
				<div id="boardList">
				
				</div>
				<br><br>
				<a href="/">index</a>
				<br>
				<form id="addApplJoin" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
					<a href="javascript:addApplJoin();">가입신청하기</a>
				
				<form id=updateApplJoinForm method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
					<a href="javascript:updateApplJoinForm();">가입신청질문 변경</a>
					
				<form id=addGroupBoard method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
					<a href="javascript:addGroupBoard();">게시판 추가하기</a>
					
				<form id=getGroupBoardList method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id=getGroupBoard method="post">
				
				</form>
        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>