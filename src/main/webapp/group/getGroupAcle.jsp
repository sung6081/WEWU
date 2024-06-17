<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script>
			function deleteGroupAcle(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteGroupAcle');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteGroupAcle", // (Required) 요청이 전송될 URL 주소
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
								alert("삭제가 완료되었습니다");
								$('#getGroupBoard').submit();
							}else{
								alert("삭제 실패 : 기타 원인.");
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
			
			function updateGroupAcle(){
				var form = document.getElementById("updateGroupAcle");
				form.action="/group/updateGroupAcle";
				form.submit();
			}
			
			function addReport(){
				var form = document.getElementById("addReport");
				form.action="/report/addReport";
				form.submit();
			}
		</script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		${groupAcle}
		<h1>게시글 조회</h1>
		제목 : ${groupAcle.acleName}
		<br>
		내용 : ${groupAcle.acleContents}
		
		<form id="deleteGroupAcle" method="post">
			<input type="hidden" name="boardNo" value="${groupAcle.boardNo}">
		</form>
			<a href="javascript:deleteGroupAcle();">삭제하기</a>
			
		<form id="updateGroupAcle" method="post">
			<input type="hidden" name="boardNo" value="${groupAcle.boardNo}">
		</form>
			<a href="javascript:updateGroupAcle();">수정하기</a>
			
		<form id="getGroupBoard" method="post" action="/group/getGroupBoard">
			<input type="hidden" name="typeNo" value="${groupAcle.typeNo}">
		</form>
		
		<form id="addReport" method="post" action="/report/addReport">
			<input type="hidden" name="targetNo" value="${groupAcle.boardNo}">
			<input type="hidden" name="reportType" value="B">
		</form>
			<a href="javascript:addReport();">신고하기</a>
	</body>
</html>