<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Skydash Admin</title>
	<!-- plugins:css -->
	<link rel="stylesheet" href="/vendors/feather/feather.css">
	<link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
	<link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
	<!-- endinject -->
	<!-- Plugin css for this page -->
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<link rel="stylesheet" href="/css/vertical-layout-light/style.css">
	<!-- endinject -->
	<link rel="shortcut icon" href="/images/favicon.png" />
	 <!-- plugins:js -->
	<script src="/vendors/js/vendor.bundle.base.js"></script>
	<script src="/js/off-canvas.js"></script>
	<script src="/js/hoverable-collapse.js"></script>
	<script src="/js/template.js"></script>
	<script src="/js/settings.js"></script>
	<script src="/js/todolist.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
		$(function() 
		{
			$(".btn:contains('제출')").on("click",function()
			{
				addReport();
			});
		});
		function addReport()
		{
	        if(!confirm("정말 신고 하시겠습니까?")){
				return;
				
	        }else{
	        	// form 데이터 가져오기
	        	var form = document.getElementById('addReport');
	        	var formData = new FormData(form);

	        	// JSON으로 변환
	        	var jsonData = Object.fromEntries(formData);

	        	//모임 리스트
				$.ajax ({
					url	: "/app/report/addReport", // (Required) 요청이 전송될 URL 주소
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
						alert("신고 완료되었습니다.");
						window.close();
						 
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
		<div class="container-scroller">
		    <div class="container-fluid page-body-wrapper full-page-wrapper">
		      <div class="content-wrapper d-flex align-items-center auth px-0">
		        <div class="row w-100 mx-0">
		          <div class="col-lg-4 mx-auto">
		            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
		              <div class="brand-logo">
		                <img src="../../images/logo.svg" alt="logo">
		              </div>
		              <form class="pt-3" id="addReport">
		              	<input type="hidden" name="targetNo" value="${targetNo}">
						<input type="hidden" name="reportNickname" value="nick1">
						<input type="hidden" name="reportType" value="${reportType}">
						<input type="hidden" name="targetNickname" value="${groupAcle.wrteName }">
						<input type="hidden" name="reportContents" value="${groupAcle.acleContents }">
			            <div class="col-md-12 grid-margin stretch-card">
			              <div class="card">
			                <div class="card-body">
			                  <h4 class="card-title">신고하기</h4>
			                  <p class="card-description">
								<c:if test="${reportType eq 'B'}">
									게시글 내용
					  			</c:if>
								<c:if test="${reportType eq 'C'}">
									댓글 내용
								</c:if>
								<c:if test="${reportType eq 'O'}">
									채팅 내용
								</c:if>
			                  </p>
			                  <blockquote class="blockquote">
			                    <p class="mb-0">
			                    	${groupAcle.acleContents}
			                    </p>
			                  </blockquote>
			                </div>
			                <div class="card-body">
			                  <p class="card-description">
								신고사유
			                  </p>
			                  <blockquote class="blockquote blockquote-primary" style="height:200px;">
			                    <textarea name="reportNote" style="width:100%; height:100%; border:0px; font-size:12px;" placeholder="사유를 입력하세요"></textarea>
			                  </blockquote>
			                </div>
			              </div>
			            </div>
		                <div class="mb-4">
		                  <div class="form-check">
		                    <label class="form-check-label text-muted">
		                      <input type="checkbox" class="form-check-input">
		                      신고대상 "${groupAcle.wrteName}" 신고에 동의합니다.
		                    </label>
		                  </div>
		                </div>
		                <div class="mt-3">
		                  <a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">제출</a>
		                </div>
		              </form>
		              <form id="getReport" method="post" action="/report/getReport">
					
					  </form>
		            </div>
		          </div>
		        </div>
		      </div>
		      <!-- content-wrapper ends -->
		    </div>
    <!-- page-body-wrapper ends -->
  		</div>
	</body>
</html>