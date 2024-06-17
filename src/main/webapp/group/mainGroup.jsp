<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
	        window.onload = function() {
	            // 페이지 로드 시 실행되는 함수
	
	            // AJAX 요청 함수
	            function sendAjaxRequest(url, searchCondition, searchKeyword, targetElementId) {
	                $.ajax({
	                    url: url,
	                    type: "POST",
	                    async: true,
	                    cache: true,
	                    timeout: 3000,
	                    data: JSON.stringify({
	                        searchCondition: searchCondition,
	                        searchKeyword: searchKeyword
	                    }),
	                    processData: true,
	                    contentType: "application/json",
	                    dataType: "json",
	                    beforeSend: function() {
	                        // AJAX 요청 전에 실행되는 함수
	                    },
	                    success: function(data, status, xhr) {
	                        // AJAX 요청 성공 시 실행되는 함수
	                        var str = "";
	                        for (var i = 0; i < data.length; i++) {
	                            str += "<option>" + data[i].groupName + "</option>";
	                        }
	                        $('#' + targetElementId).append(str);
	                    },
	                    error: function(xhr, status, error) {
	                        // AJAX 요청 실패 시 실행되는 함수
	                    },
	                    complete: function(xhr, status) {
	                        // AJAX 요청 완료 후 실행되는 함수
	                    }
	                });
	            }
	
	            // 모임 리스트
	            sendAjaxRequest("/app/group/getGroupList", "T", "", "getGroupList");
	
	            // 모임 랭킹 리스트
	            sendAjaxRequest("/app/group/getGroupRankingList", "Ranking", "", "getGroupRankingList");
	
	            // 내 모임 신청정보
	            sendAjaxRequest("/app/group/getGroupList", "My", "nick1", "getMyGroupList");
	
	            // 모든 모임 신청정보(개설대기)
	            sendAjaxRequest("/app/group/getGroupList", "E", "", "getGroupListWait");
	
	            // 모든 모임 신청정보(개설승인)
	            sendAjaxRequest("/app/group/getGroupList", "T", "", "getMyGroupListTrue");
	
	            // 모든 모임 신청정보(개설거부)
	            sendAjaxRequest("/app/group/getGroupList", "F", "", "getMyGroupListNone");
	
	            // 내 모임 가입신청 정보
	            sendAjaxRequest("/app/group/getApplJoinList", "user", "nick2", "getApplJoinList");
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
        		<div>
			        <h1>모임목록 ( 승인된 모임만 )</h1>
			        <select id="getGroupList"></select>
			
			        <h1>모임랭킹 ( 승인된 모임만 등급 및 인원 별 order by )</h1>
			        <select id="getGroupRankingList"></select>
			
			        <h1>내 모임 신청정보( 내 모든 모임신청 정보 )</h1>
			        <select id="getMyGroupList"></select>
			
			        <h1>모든 모임 (개설대기)</h1>
			        <select id="getGroupListWait"></select>
			
			        <h1>모든 모임 (개설승인)</h1>
			        <select id="getMyGroupListTrue"></select>
			
			        <h1>모든 모임 (개설거부)</h1>
			        <select id="getMyGroupListNone"></select>
			
			        <h1>내 모임 가입신청 정보</h1>
			        <select id="getApplJoinList"></select>
			    </div>
        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>