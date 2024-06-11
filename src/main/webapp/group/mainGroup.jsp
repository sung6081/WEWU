<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
		window.onload = function() {
			//모임 리스트
			$.ajax ({
				  url	: "/app/group/getGroupList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
				  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				  data  : JSON.stringify({
					  		searchCondition : "T"
					  	}), // 요청 시 전달할 데이터
				  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				  beforeSend  : function () {
				    // XHR Header 포함, HTTP Request 하기전에 호출
				  },
				  success : function(data, status, xhr) {
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<option>"+ data[i].groupName +"</option>";
					  }
					  $('#getGroupList').append(str);
					  str = "";
				  },
				  error	: function(xhr, status, error) {
				    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				  },
				  complete : function(xhr, status) {
				    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				  }
			});
			
			//모임 랭킹 리스트
			$.ajax ({
				  url	: "/app/group/getGroupRankingList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
				  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				  data  : JSON.stringify({
					  		searchCondition : "Ranking"
					  	}), // 요청 시 전달할 데이터
				  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				  beforeSend  : function () {
				    // XHR Header 포함, HTTP Request 하기전에 호출
				  },
				  success : function(data, status, xhr) {
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<option>"+ data[i].groupName +"</option>";
					  }
					  $('#getGroupRankingList').append(str);
					  str = "";
				  },
				  error	: function(xhr, status, error) {
				    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				  },
				  complete : function(xhr, status) {
				    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				  }
			});
			
			//내 모임 신청정보
			$.ajax ({
				  url	: "/app/group/getGroupList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
				  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				  data  : JSON.stringify({
					  		searchCondition : "My",
					  		searchKeyword : "nick1"
					  	}), // 요청 시 전달할 데이터
				  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				  beforeSend  : function () {
				    // XHR Header 포함, HTTP Request 하기전에 호출
				  },
				  success : function(data, status, xhr) {
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<option>"+ data[i].groupName +"</option>";
					  }
					  $('#getMyGroupList').append(str);
					  str = "";
				  },
				  error	: function(xhr, status, error) {
				    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				  },
				  complete : function(xhr, status) {
				    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				  }
			});
			
			//모든 모임 신청정보(개설대기)
			$.ajax ({
				  url	: "/app/group/getGroupList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
				  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				  data  : JSON.stringify({
					  		searchCondition : "E",
					  	}), // 요청 시 전달할 데이터
				  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				  beforeSend  : function () {
				    // XHR Header 포함, HTTP Request 하기전에 호출
				  },
				  success : function(data, status, xhr) {
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<option>"+ data[i].groupName +"</option>";
					  }
					  $('#getGroupListWait').append(str);
					  str = "";
				  },
				  error	: function(xhr, status, error) {
				    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				  },
				  complete : function(xhr, status) {
				    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				  }
			});
			
			//모든 모임 신청정보(개설승인)
			$.ajax ({
				  url	: "/app/group/getGroupList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
				  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				  data  : JSON.stringify({
					  		searchCondition : "T",
					  	}), // 요청 시 전달할 데이터
				  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				  beforeSend  : function () {
				    // XHR Header 포함, HTTP Request 하기전에 호출
				  },
				  success : function(data, status, xhr) {
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<option>"+ data[i].groupName +"</option>";
					  }
					  $('#getMyGroupListTrue').append(str);
					  str = "";
				  },
				  error	: function(xhr, status, error) {
				    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				  },
				  complete : function(xhr, status) {
				    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				  }
			});
			
			//모든 모임 신청정보(개설거부)
			$.ajax ({
				  url	: "/app/group/getGroupList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
				  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				  data  : JSON.stringify({
					  		searchCondition : "F",
					  	}), // 요청 시 전달할 데이터
				  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				  beforeSend  : function () {
				    // XHR Header 포함, HTTP Request 하기전에 호출
				  },
				  success : function(data, status, xhr) {
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<option>"+ data[i].groupName +"</option>";
					  }
					  $('#getMyGroupListNone').append(str);
					  str = "";
				  },
				  error	: function(xhr, status, error) {
				    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				  },
				  complete : function(xhr, status) {
				    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				  }
			});
			
			//내 모임 가입신청 정보
			$.ajax ({
				  url	: "/app/group/getApplJoinList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
				  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				  data  : JSON.stringify({
					  		searchCondition : "user",
					  		searchKeyword : "nick2"
					  	}), // 요청 시 전달할 데이터
				  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				  beforeSend  : function () {
				    // XHR Header 포함, HTTP Request 하기전에 호출
				  },
				  success : function(data, status, xhr) {
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<option>"+ data[i].groupNo +"===="+ data[i].memberNickName+"</option>";
					  }
					  $('#getApplJoinList').append(str);
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
	</script>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
</head>
	<body>
		<div>
			<h1>모임목록 ( 승인된 모임만 )</h1>
			<select id="getGroupList">
				
			</select>
			
			<h1>모임랭킹 ( 승인된 모임만 등급 및 인원 별 order by )</h1>
			<select id="getGroupRankingList">
				
			</select>
			
			<h1>내 모임 신청정보( 내 모든 모임신청 정보 )</h1>
			<select id="getMyGroupList">
				
			</select>
			
			<h1>모든 모임 (개설대기)</h1>
			<select id="getGroupListWait">
				
			</select>
			
			<h1>모든 모임 (개설승인)</h1>
			<select id="getMyGroupListTrue">
				
			</select>
			
			<h1>모든 모임 (개설거부)</h1>
			<select id="getMyGroupListNone">
				
			</select>
			
			<h1>내 모임 가입신청 정보</h1>
			<select id="getApplJoinList">
				
			</select>
		</div>
	</body>
</html>