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
			function updateApplJoin(){
				
		        if(!confirm("정말 수정하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('updateApplJoin');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);
	
		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/updateApplJoin", // (Required) 요청이 전송될 URL 주소
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
							alert("수정이 완료되었습니다.");
							var str = "";
									
							$('#getApplJoin').submit();
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
	                  <h1 class="card-title">모임가입신청</h1>
	                  <h4 class="card-title">${group.groupName}</h4>
	                  <form class="forms-sample" id="updateApplJoin">
	                  	<input type="hidden" name="groupNo" value="${group.groupNo}">
						<input type="hidden" name="memberNickName" value="${groupMember.memberNickName }">
						<input type="hidden" name="memberNo" value="${groupMember.memberNo}">
						<input type="hidden" name="joinFlag" value="${groupMember.joinFlag}">
						<input type="hidden" name="frstQuest" value="${group.frstQuest}">
						<input type="hidden" name="scndQuest" value="${group.scndQuest}">
						<input type="hidden" name="thrdQuest" value="${group.thrdQuest}">
	                    <c:if test="${group.frstQuest != '' && group.frstQuest != null}">
							<div class="form-group">
		                      <label>${group.frstQuest}</label>
	                      	  <input type="text" class="form-control" name="frstRepl" placeholder="1번 답변" value="${groupMember.frstRepl }">
		                    </div>
						</c:if>
						<c:if test="${group.frstQuest == '' || group.frstQuest == null}">
							<div class="form-group">
		                      <label>1번 질문 없음</label>
		                    </div>
						</c:if>
						<c:if test="${group.scndQuest != '' && group.scndQuest != null}">
							<div class="form-group">
		                      <label>${group.scndQuest}</label>
	                      	  <input type="text" class="form-control" name="scndRepl" placeholder="2번 답변" value="${groupMember.scndRepl }">
		                    </div>
						</c:if>
						<c:if test="${group.scndQuest == '' || group.scndQuest == null}">
							<div class="form-group">
		                      <label>2번 질문 없음</label>
		                    </div>
						</c:if>
						<c:if test="${group.thrdQuest != '' && group.thrdQuest != null}">
							<div class="form-group">
		                      <label>${group.thrdQuest}</label>
	                     	  <input type="text" class="form-control" name="thrdRepl" placeholder="3번 답변" value="${groupMember.thrdRepl }">
		                    </div>
						</c:if>
						<c:if test="${group.thrdQuest == '' || group.thrdQuest == null}">
							<div class="form-group">
		                      <label>3번 질문 없음</label>
		                    </div>
						</c:if>
						<label>승인여부</label>
						<c:if test="${group.leaderNick == user.nickname }">
		                      <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="joinFlag" value="E"
			                      ${groupMember.joinFlag == 'E' ? 'checked' : ''}>
			                      가입대기
			                    </label>
			                  </div>
			                  <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="joinFlag" value="T"
			                      ${groupMember.joinFlag == 'T' ? 'checked' : ''}>
			                      가입완료
			                    </label>
			                  </div>
			                  <div class="form-check">
			                    <label class="form-check-label text-muted">
			                      <input type="radio" class="form-check-input" name="joinFlag" value="F"
			                      ${groupMember.joinFlag == 'F' ? 'checked' : ''}>
			                      가입거부
			                    </label>
			                  </div>
						</c:if>
						<c:if test="${group.leaderNick != user.nickname}">
			              <h4>
			              	<c:if test="${groupMember.joinFlag == 'E'}"><b style="color:#7DA0FA;">가입대기</b></c:if>
			              	<c:if test="${groupMember.joinFlag == 'T'}"><b style="color:#a8d9a8;">가입완료</b></c:if>
			              	<c:if test="${groupMember.joinFlag == 'F'}"><b style="color:#ffcbcb;">가입거부</b></c:if>
			              </h4>
			           </c:if>
	                 </form>
	                <button onclick="javascript:updateApplJoin();"  class="btn btn-primary mr-2">수정</button>
	    			<button onclick="javascript:history.go(-1);" class="btn btn-light">취소</button>
	                </div>
	              </div>
	            </div>
        	</div>
        </div>
        <form id="getApplJoin" method="post" action="/group/getApplJoin">
			<input type="hidden" name="memberNo" value="${groupMember.memberNo}">
		</form>
		
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>