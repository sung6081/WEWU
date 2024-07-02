<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<style>
		.sideIcon
		{
			width:25px;
			height:25px;
			margin:0 10px 0 0;
		}	
			
		.group_nav
		{
			display: flex;
			align-items: center;
		    white-space: nowrap;
		    padding: 0.8125rem 1.937rem 0.8125rem 1rem;
		    color: #6C7383;
		    border-radius: 8px;
		    
		}
		.sidebar .nav {
			margin : 0px;
		}
		.group_nav:hover 
		{ 
			color: black;
			text-decoration-line: none;
			background: rgba(3,199,90,.12);
		}
	</style>
	<script>
		window.onload = function() {
				
			if("${user}" == "")
			{
				alert("모임은 WEWU 회원만 사용 가능합니다!");
				location.href="/";
			}
			
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
						  str += "<li class=nav-item>" +
					          		 "<a class=group_nav href=javascript:getGroupBoard(" + data[i].typeNo + ")>";
					          		 if(data[i].boardType == "T")
					          	     {
					          			str +=   "<i class='menu-icon'><img class='sideIcon' src='/group/img/gallery.png'></i>";
					          	     }else
					          	     {
					          	    	str +=   "<i class='menu-icon'><img class='sideIcon' src='/group/img/board.png'></i>"; 	    	 
					          	     }
						            	
					          		str +=    "<span class=menu-title>" + data[i].boardName + "</span>" +
				          			 "</a>" +
				          		 "</li>";
					  }
					  $('.boardList').append(str);
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
		
		function getGroupBoard(typeNo){
			var form = document.getElementById("getGroupBoardSide");
			var str = "<input type=hidden name=typeNo value=" + typeNo +">" + 
					  "<input type=hidden name=groupNo value=" + ${group.groupNo} +">";
			$('#getGroupBoardSide').append(str);
			form.action="/group/getGroupBoard";
			form.submit();
		}
		
		$(function() 
		{
			$( "span" ).css("cursor","pointer");
			
			$( "span > img" ).on("click" , function() 
		 	{
				// 내 모임 신청정보
				addGroupBoardSide();
			}); 
			
			$( ".home" ).on("click" , function() 
		 	{
				// 내 모임 신청정보
				getGroupSide();
			}); 
			
			$(".group_nav:contains('모임정보')").on("click",function()
			{
				getGroupSide();
			});
			
			$(".group_nav:contains('내 정보')").on("click",function()
			{
				getMemberGroupSide();
			});
			
			$(".group_nav:contains('모임원목록')").on("click",function()
			{
				getMemberGroupListSide();
			});
			
			$(".group_nav:contains('가입신청서 양식')").on("click",function()
			{
				updateApplJoinFormSide();
			});
			
			$(".group_nav:contains('모임활동구역')").on("click",function()
			{
				listActive();
			});
			
			$(".group_nav:contains('신고조회')").on("click",function()
			{
				getReportListSide();
			});
		});
		
		function getGroupSide(){
			var form = document.getElementById("getGroupSide");
			form.action="/group/getGroup";
			form.submit();
		}
		
		function addGroupBoardSide(){
			var form = document.getElementById("addGroupBoardSide");
			form.action="/group/addGroupBoard";
			form.submit();
		}
		
		function getMemberGroupSide(){
			var form = document.getElementById("getMemberGroupSide");
			form.action="/group/getMemberGroupForNick";
			form.submit();
		}
		
		function updateApplJoinFormSide(){
			var form = document.getElementById("updateApplJoinFormSide");
			form.action="/group/updateApplJoinForm";
			form.submit();
		}
		
		function getMemberGroupListSide(){
			var form = document.getElementById("getMemberGroupListSide");
			form.action="/group/getMemberGroupList";
			form.submit();
		}
		
		function listActive(){
			var form = document.getElementById("listActive");
			form.action="/active/listActive";
			form.submit();
		}
		
		function getReportListSide(){
			var form = document.getElementById("getReportListSide");
			form.action="/report/getReportList";
			form.submit();
		}
		
	</script>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<!-- partial:partials/_sidebar.html -->
	    <div class="container-fluid">
	    	<div class="row">
	    		<nav class="sidebar sidebar-offcanvas" id="sidebar">
	    			<br>
		          	<a class="group_nav">
		          		<i class="menu-icon"><img class="sideIcon" src="/group/img/real-estate_13468499.png"></i>
		          		<span class="menu-title home"><b>${group.groupName }</b></span>
		          	</a>
				  <hr>
				  <h4>
				  	&nbsp;&nbsp;<b>게시판</b> 
				  	<c:if test="${!empty groupMember}">
						<c:if test="${user.nickname == group.leaderNick}">
				      		<i class="menu-icon" style="float:right;"><span><img class="sideIcon" src="/group/img/add.png"></span></i>
				      		
				    	</c:if>
				    </c:if>
				  </h4>
				  <ul class="nav boardList">
				  </ul>
				  <hr>
		          <h4>&nbsp;&nbsp;<b>관리</b></h4>
					     <a class="group_nav">
					     	<i class="menu-icon"><img class="sideIcon" src="/group/img/information.png"></i>
				            <span class="menu-title">모임정보</span>
					     </a>
				      <c:if test="${!empty groupMember && groupMember.joinFlag == 'T' || groupMember.joinFlag == 'L'}">
				        	<a class="group_nav">
					            <i class="menu-icon"><img class="sideIcon" src="/group/img/profile.png"></i>
					            <span class="menu-title">내 정보</span>
				            </a>
	                  </c:if>
				      <c:if test="${!empty groupMember}">
	                  	<c:if test="${user.nickname == group.leaderNick}">
						    	<a class="group_nav">
						        	<i class="menu-icon"><img class="sideIcon" src="/group/img/memberList.png"></i>
						            <span class="menu-title">모임원목록</span>
						        </a>
					          <a class="group_nav">
					            <i class="menu-icon"><img class="sideIcon" src="/group/img/form.png"></i>
					            <span class="menu-title">가입신청서 양식</span>
					          </a>
					          <a class="group_nav">
					            <i class="menu-icon"><img class="sideIcon" src="/group/img/attention.png"></i>
					            <span class="menu-title">신고조회</span>
					          </a>
	                	</c:if>
                     </c:if>
			            <a class="group_nav">
			              <i class="menu-icon"><img class="sideIcon" src="/group/img/globe.png"></i>
			              <span class="menu-title">모임활동구역</span>
			            </a>
			            
			    </nav>
			    
			    <form id="getGroupBoardList" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="getGroupBoardSide" method="post">
					
				</form>
				
				<form id="addGroupBoardSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="getGroupSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="updateApplJoinFormSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="getMemberGroupSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
					<input type="hidden" name="memberNickName" value="${user.nickname}">
				</form>
				
				<form id="getMemberGroupListSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="listActive" method="GET">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="getReportListSide" method="POST">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
	</body>
</html>