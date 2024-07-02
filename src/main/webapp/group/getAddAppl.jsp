<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<style>
			.sideIcon
			{
				width:20px;
				height:20px;
				margin:0 10px 0 0;
			}	
		</style>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script>
			$(document).ready(function() {
				if("${user}" == "")
				{
					alert("모임은 WEWU 회원만 사용 가능합니다!");
					location.href="/";
				}
			})
			
			function updateAddAppl(){
				var form = document.getElementById("updateAddAppl");
				form.action="/group/updateAddAppl";
				form.submit();
			}
		</script>

	</head>
	<body>
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="col-12">
        			<div class="row">
	        			<div class="col-md-2 grid-margin stretch-card">
						</div>
			        	<div class="col-md-8 grid-margin stretch-card">
			              <div class="card">
			                <div class="card-body">
			                  <div class="col-md-12">
				                  <h1 class="card-title">개설신청서 조회</h1>
				                  <form class="forms-sample" id="updateAddAppl" method="post" action="/group/updateAddAppl">
				                  	<input type="hidden" name="groupNo" value="${group.groupNo}">
									<input type="hidden" name="leaderNick" value="${group.leaderNick}">
									<input type="hidden" name="groupName" value="${group.groupName}">
									<input type="hidden" name="groupIntro" value="${group.groupIntro}">
									<input type="hidden" name="groupHash" value="${group.groupHash}">
									<input type="hidden" name="groupAddr" value="${group.groupAddr}">
									<input type="hidden" name="groupPlan" value="${group.groupPlan}">
									<input type="hidden" name="groupNo" value="${group.groupNo}">
									<input type="hidden" name="groupPers" id="groupPers" value="${group.groupPers}">
									<input type="hidden" name="groupLevel" id="groupLevel" value="${group.groupLevel}">
				                    <div class="form-group">
				                      <label>모임명</label>
				                      <h4>${group.groupName}</h4>
				                    </div>
				                    <div class="form-group">
				                      <label>모임소개</label>
				                      <h4>${group.groupIntro}</h4>
				                    </div>
				                    <div class="form-group">
				                      <label>모임태그</label>
				                      <h4>#${group.groupHash}</h4>
				                    </div>
				                    <div class="form-group">
				                      <label>모임주소</label>
				                      <h4>${group.groupAddr}</h4>
				                    </div>
				                    <div class="form-group">
				                      <label>모임계획</label>
				                      <h4>${group.groupPlan}</h4>
				                    </div>
				                  </form>
				                  <form id="getAddAppl" method="post" action="/group/getAddAppl">
								
								  </form>
				                <button onclick="javascript:updateAddAppl();"  class="btn btn-primary mr-2">수정</button>
				    			<button onclick="javascript:history.go(-1);" class="btn btn-light">뒤로가기</button>
				                </div>
				             </div>
			              </div>
			            </div>
			            <div class="col-md-2 grid-margin stretch-card">
						</div>
					</div>
		        </div>
        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>