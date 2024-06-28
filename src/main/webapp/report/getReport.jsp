<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<script>
			function updateReport()
			{
		        if(!confirm("정말 수정하시겠습니까?")){
					return;
					
		        }else{
		        	// form 데이터 가져오기
		        	var form = document.getElementById('updateReport');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);
	
		        	//모임 리스트
					$.ajax ({
						url	: "/app/report/updateReport", // (Required) 요청이 전송될 URL 주소
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
							getReportList();
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
			
			function deleteReport(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteReport');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);
	
		        	//모임 리스트
					$.ajax ({
						url	: "/app/report/deleteReport", // (Required) 요청이 전송될 URL 주소
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
								$('#getReportList').submit();
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
			
			function getReportList(){
				var form = document.getElementById("getReportList");
				form.action="/report/getReportList";
				form.submit();
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
        		<div class="card">
	                <div class="card-body">
	                    <h4 class="card-title">신고상세조회</h4>
	                    	<p class="card-description">
                            	${report.rsltDate }
                            </p>
	                    <hr>
	                    <form id="updateReport">
	                    	<input type="hidden" name="reportNo" value="${report.reportNo}">
							<input type="hidden" name="reportType" value="${report.reportType}">
		                    <div class="col-md-12">
	                            <div class="card">
	                                <div class="card-body">
		                                <h5 class="card-title">
		                                	<b>신고 : ${report.reportNickname }</b>
		                                    &nbsp;<img src="/group/img/arrow-right-square-fill.svg">&nbsp;
		                                    <b>대상 : ${report.targetNickname }</b>
		                                </h5>
		                                
		                                <div class="card-body">
						                  <p class="card-description">
											신고글
						                  </p>
			                                <blockquote class="blockquote">
							                    <p class="mb-0">
							                    	${report.reportContents}
							                    </p>
					                    	</blockquote>
					                    </div>
				                    	<div class="card-body">
						                  <p class="card-description">
											신고사유
						                  </p>
						                  <blockquote class="blockquote blockquote-primary" style="height:200px;">
						                    ${report.reportNote }
						                  </blockquote>
						                </div>
						                <div class="card-body">
						                  <p class="card-description">
											신고답변
						                  </p>
						                  <blockquote class="blockquote blockquote-primary" style="height:200px;">
						                     <textarea name="rsltRepl" style="width:100%; height:100%; border:0px; font-size:12px;" placeholder="신고답변">${report.rsltRepl}</textarea>
						                  </blockquote>
						                </div>
	                                </div>
	                            </div>
	                        </div>
                       		<div class="form-group">
		                      <label>처리여부</label>
		                       <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="rsltFlag" value="E"
			                      ${report.rsltFlag == 'E' ? 'checked' : ''}>
			                      처리대기
			                    </label>
			                  </div>
		                      <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="rsltFlag" value="T"
			                      ${report.rsltFlag == 'T' ? 'checked' : ''}>
			                      처리완료
			                    </label>
			                  </div>
			                  <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="rsltFlag" value="F"
			                      ${report.rsltFlag == 'F' ? 'checked' : ''}>
			                      처리기각
			                    </label>
			                  </div>
		                    </div>
		                </form>
	                    <button onclick="javascript:updateReport();"  class="btn btn-primary mr-2">처리</button>
	                    <button onclick="javascript:deleteReport();"  class="btn btn-danger mr-2">삭제</button>
    					<button onclick="javascript:history.go(-1);"  class="btn btn-light">취소</button>
                        <hr>
	                </div>
	            </div>
				<form id="getReportList" method="POST">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				

        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>