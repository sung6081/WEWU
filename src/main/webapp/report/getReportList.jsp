<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		
		<script>
			$(function() 
			{
				getReportList();
			})
			
			$(document).ready(function() {
					
			    $(document).on('mouseenter', '.report', function() {
			        $(this).css('cursor', 'pointer');
			    });
			    
			    $(document).on('click', '.report', function() {
			    	getReport($(this).attr("id"));
			    });
			   
			});
		
			function getReportList()
			{
				$.ajax ({
					  url	: "/app/report/getReportList", // (Required) 요청이 전송될 URL 주소
					  type	: "POST", // (default: ‘GET’) http 요청 방식
					  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					  data  : JSON.stringify(
					 				{
					 					searchCondition:"1"
					 				}
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
							  
							  str += "<tr class ='report' id="+data[i].reportNo+">" +
						          		 "<td>" + data[i].reportNickname +"</td>" +
						          		 "<td>" + data[i].targetNickname +"</td>" +
						          		 "<td>" + data[i].reportNote +"</td>" +
						          		 "<td>" + data[i].reportType +"</td>" +
						          		 "<td>" + data[i].rsltDate +"</td>";
						          		if(data[i].rsltFlag == "T")
		                        		{
		                        			str +=  "<td><label class='badge badge-success'>처리완료</label></td>";
		                        		}else
		                        		if(data[i].rsltFlag == "F"){
		                        			str +=  "<td><label class='badge badge-danger'>신고기각</label></td>";
		                        		}
		                        		else
		                        		if(data[i].rsltFlag == "E"){
		                        			str +=  "<td><label class='badge badge-info'>신고대기</label></td>";
		                        		}
					          		 "</tr>";
						  }
						  $('#reportList').html(str);
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
			
			function getReport(reportNo)
			{
				var form = document.getElementById("getReport");
				var str = "<input type=hidden name=reportNo value=" + reportNo +">";
				$('#getReport').append(str);
				form.action="/report/getReport";
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
        		<div class="col-lg-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
						    <h4 class="card-title">신고조회</h4>
							<div class="table-responsive">
							  	<table class="table table-striped table-hover">
								    <thead>
								      <tr>
								        <th>
								          신고자
								        </th>
								        <th>
								          신고대상자
								        </th>
								        <th>
								          신고내용
								        </th>
								        <th>
								          신고종류
								        </th>
								        <th>
								          신고/처리일
								        </th>
								        <th>
								          처리상태
								        </th>
								      </tr>
								    </thead>
								    <tbody id="reportList">
								    
								    </tbody>
							    </table>
							</div>
						</div>
						<div class="container">
						  <div class="row justify-content-center">
						    <div id="paging" style="float:center;"></div>
						  </div>
						</div>
						<form id="getReport" method="post">
							<input type="hidden" name="groupNo" value="${group.groupNo}">
						</form>
					</div>
				</div>
		        		
        	</div>
        	
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>