<%@ page language="java" contentType="text/html; charset=UTF8"
    pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
	<head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script>
		
			function addGroupBoard()
			{
		        if(!confirm("정말 개설신청 하시겠습니까?")){
					return;
					
		        }else{
		        	// form 데이터 가져오기
		        	var form = document.getElementById('addGroupBoard');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/addGroupBoard", // (Required) 요청이 전송될 URL 주소
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
							alert("게시판 개설이 완료되었습니다");
							var str = "";
							str += "<input type='hidden' name='typeNo' value = '"+ data.typeNo +"'>";
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
		<meta charset="UTF8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>모임 게시판 추가 View</h1>
		<br>
		<form id="addGroupBoard">
			<input type="hidden" name="groupNo" value="${groupNo}">
			게시판 명 : <input type="text" name="boardName">
			<br>
			게시판 타입 <br>
			 리스트 : <input type="radio" name="boardType" value="L"> 
			 썸네일 : <input type="radio" name="boardType" value="T"> 
			<br>
			게시판 소개 : <input type="text" name="boardIntro">
			<br>
			게시판 권한 <br>
			 모임장 : <input type="radio" name="boardRole" value="G"> 
			 전체 : <input type="radio" name="boardRole" value="A">
		</form>
		
		<form id="getGroupBoard" method="post" action="/group/getGroupBoard">
			
		</form>
		<a href="javascript:addGroupBoard();">게시판 개설하기</a>
	</body>
</html>
