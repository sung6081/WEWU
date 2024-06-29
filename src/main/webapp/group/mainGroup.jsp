<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<style>
		.card-body {
			height:450px;
	    }
	    .list-wrapper{
	    	
	    }
	     /* 스타일링은 필요에 따라 추가할 수 있습니다. */
		  #info, #section2, #section3 {
		  
		  }
		</style>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<script>
			$(function() 
			{
				
				$( "span" ).css("cursor","pointer");
				
				$( "span:contains('모임개설신청')" ).on("click" , function() 
			 	{
					$("#MyForm").attr("action","/group/addApplGroup").attr("method","POST").submit();
				}); 
				
				$( "span:contains('모임홈')" ).on("click" , function() 
			 	{
					$("#MyForm").attr("action","/group/mainGroup").attr("method","POST").submit();
				}); 
				
				$( "span:contains('모임목록')" ).on("click" , function() 
			 	{
					scrollToSection("GroupList")
				}); 
				
				$( "span:contains('내 모임관리')" ).on("click" , function() 
			 	{
					scrollToSection("MyInfo")
				}); 
				
				$( "span:contains('모임랭킹')" ).on("click" , function() 
			 	{
					scrollToSection("Ranking")
				}); 
				
				$( ".btn:contains('개설모임')" ).on("click" , function() 
			 	{
					// 내 모임 신청정보
					sendAjaxRequest("/app/group/getGroupList", "My", "${user.nickname}", "getMyGroupList");
					$(".btn-outline-secondary").attr("class","btn btn-outline-secondary btn-outline-info");
					$(this).attr("class","btn btn-outline-secondary btn-inverse-info");
				}); 
				
				$( ".btn:contains('가입모임')" ).on("click" , function() 
			 	{
					// 내 모임 가입신청 정보
		            sendAjaxRequest("/app/group/getApplJoinList", "user", "${user.nickname}", "getApplJoinList");
		            $(".btn-outline-secondary").attr("class","btn btn-outline-secondary btn-outline-info");
		            $(this).attr("class","btn btn-outline-secondary btn-inverse-info");
				}); 
				
				$( ".btn:contains('대기신청서')" ).on("click" , function() 
			 	{
					// 모든 모임 신청정보(개설대기)
		            sendAjaxRequest("/app/group/getGroupList", "E", "", "getGroupListWait");
		            $(".btn-outline-secondary").attr("class","btn btn-outline-secondary btn-outline-info");
		            $(this).attr("class","btn btn-outline-secondary btn-inverse-info");
				}); 
				
				$( ".btn:contains('승인신청서')" ).on("click" , function() 
			 	{
					// 모든 모임 신청정보(개설승인)
		            sendAjaxRequest("/app/group/getGroupList", "T", "", "getGroupListTrue");
		            $(".btn-outline-secondary").attr("class","btn btn-outline-secondary btn-outline-info");
		            $(this).attr("class","btn btn-outline-secondary btn-inverse-info");
				}); 
				
				$( ".btn:contains('거부신청서')" ).on("click" , function() 
			 	{
					// 모든 모임 신청정보(개설거부)
		            sendAjaxRequest("/app/group/getGroupList", "F", "", "getGroupListNone");
		            $(".btn-outline-secondary").attr("class","btn btn-outline-secondary btn-outline-info");
					$(this).attr("class","btn btn-outline-secondary btn-inverse-info");
					
				}); 
				
				$( ".btn:contains('Search')" ).on("click" , function() 
			 	{
					// 모든 모임 신청정보(개설거부)
					
		            sendAjaxRequest("/app/group/getGroupList", "search", $(".searchKeyword").val(), "getGroupList");
		            //$(".btn-outline-secondary").attr("class","btn btn-outline-secondary btn-outline-info");
					//$(this).attr("class","btn btn-outline-secondary btn-inverse-info");
					
				}); 
				
				$(document).ready(function() {
					 $('.searchKeyword').keypress(function(event) {
				        if (event.which === 13) {
				        	sendAjaxRequest("/app/group/getGroupList", "search", $(".searchKeyword").val(), "getGroupList");
				        }
				    });
					 
				    $(document).on('mouseenter', '.groupNo', function() {
				        $(this).css('cursor', 'pointer');
				    });
				    
				    $(document).on('mouseenter', '.getGroup', function() {
				        $(this).css('cursor', 'pointer');
				    });
				    
				    $(document).on('mouseenter', '.getAddAppl', function() {
				        $(this).css('cursor', 'pointer');
				    });
				    
				    $(document).on('mouseenter', '.getApplJoin', function() {
				        $(this).css('cursor', 'pointer');
				    });
				    
				    $(document).on('mouseenter', '.getMemberGroup', function() {
				        $(this).css('cursor', 'pointer');
				    });
				    
				    
				    if("${user.role}" == "1"){
				    	
				    	$( ".btn:contains('대기신청서')" ).attr("class" , "btn btn-outline-secondary btn-inverse-info");
				    }else
				    {
				    	$( ".btn:contains('개설모임')" ).attr("class" , "btn btn-outline-secondary btn-inverse-info"); 
				    }
				    
				    $("#map").css("height","460px");
				});
				
				$(document).on('click', '.groupNo', function() {
					var id = $(this).attr("id");
					$("#MyForm").html("<input type=hidden name=groupNo value="+id+">");
					$("#MyForm").attr("method" , "POST").attr("action" , "/group/getGroup").submit();
				});
				
				$(document).on('click', '.getGroup', function() {
					var id = $(this).attr("id");
					$("#MyForm").html("<input type=hidden name=groupNo value="+id+">");
					$("#MyForm").attr("method" , "POST").attr("action" , "/group/getGroup").submit();
				});
				
				$(document).on('click', '.getAddAppl', function() {
					var id = $(this).attr("id");
					$("#MyForm").html("<input type=hidden name=groupNo value="+id+">");
					$("#MyForm").attr("method" , "POST").attr("action" , "/group/getAddAppl").submit();
				});
				
				$(document).on('click', '.getApplJoin', function() {
					var id = $(this).attr("id");
					var name = $(this).attr("name");
					
					$("#MyForm").html("<input type=hidden name=groupNo value="+name+">"+
							  "<input type=hidden name=memberNo value="+id+">");
					$("#MyForm").attr("method" , "POST").attr("action" , "/group/getApplJoin").submit();
				});
				
				$(document).on('click', '.getMemberGroup', function() {
					var id = $(this).attr("id");
					var name = $(this).attr("name");
					
					$("#MyForm").html("<input type=hidden name=groupNo value="+name+">"+
									  "<input type=hidden name=memberNo value="+id+">");
					$("#MyForm").attr("method" , "POST").attr("action" , "/group/getMemberGroup").submit();
				});
				
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
	                        
	                        if(targetElementId == "getMyGroupList"){
	                        	str = 	"<thead>" +
	                        				"<tr>" +
	                        					"<th>모임명</th>" +
	                        					"<th>모임등급</th>" +
	                        					"<th>개설/신청일</th>" +
	                        					"<th>개설상태</th>" +
	                        				"<tr>" +
	                        			"</thead>";
	                        }else
	                        if(targetElementId == "getApplJoinList"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
				               					"<th>모임명</th>" +
				               					"<th>모임등급</th>" +
				               					"<th>가입/신청일</th>" +
				               					"<th>가입상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }else
	                        if(targetElementId == "getGroupListWait"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
				               					"<th>모임명</th>" +
				               					"<th>신청자</th>" +
				               					"<th>신청일</th>" +
				               					"<th>상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }else
	                        if(targetElementId == "getGroupListTrue"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
					               				"<th>모임명</th>" +
				               					"<th>신청자</th>" +
				               					"<th>개설일</th>" +
				               					"<th>상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }else
	                        if(targetElementId == "getGroupListNone"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
					               				"<th>모임명</th>" +
				               					"<th>신청자</th>" +
				               					"<th>거부일</th>" +
				               					"<th>상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }
	                        
	                        	
                        	if(data.length != 0){
                        		for (var i = 0; i < data.length; i++) {
                        			if(targetElementId == "getGroupList"){
		                        		str +=  "<tr class=groupNo id=" + data[i].groupNo + ">" +
			    					            "  <td>"+ data[i].groupName +"</td>" +
			    					            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
			    					            "  <td>"+ data[i].groupPers +"</td>" +
			    					            "</tr>";
		                        	}else
		                        	if(targetElementId == "getGroupRankingList"){
		                        		str +=  "<tr>" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>" +
									            "</tr>";
		                        	}else
		                        	if(targetElementId == "getMyGroupList"){
		                        		
		                        		if(data[i].groupRslt == "T")
		                        		{
		                        			str +=  "<tr class='getGroup' id=" + data[i].groupNo + ">";
		                        		}else
		                        		{
		                        			str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">";
		                        		}
		                        			str +=  "  <td>"+ data[i].groupName +"</td>" +
										            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
										            if(data[i].groupRslt == "T")
					                        		{
										            	str +=  "<td>"+ data[i].openDate +"</td>";
					                        			str +=  "<td><label class='badge badge-success'>개설완료</label></td>";
					                        		}else
					                        		if(data[i].groupRslt == "F"){
					                        			str +=  "<td>"+ data[i].rsltDate +"</td>";
					                        			str +=  "<td><label class='badge badge-danger'>개설누락</label></td>";
					                        		}
					                        		else
					                        		if(data[i].groupRslt == "E"){
					                        			str +=  "<td>"+ data[i].applDate +"</td>";
					                        			str +=  "<td><label class='badge badge-info'>개설대기</label></td>";
					                        		}
										            str += "</tr>";
		                        	}else
		                        	if(targetElementId == "getApplJoinList"){
		                        		
							            if(data[i+1].joinFlag == "E")
							            {
							            	str += "<tr class='getApplJoin' id=" + data[i+1].memberNo + " name=" + data[i].groupNo + ">";
			                        		str += "  <td>"+ data[i].groupName +"</td>";
			                        		str += "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
							            	str += "  <td>"+ data[i+1].applDate +"</td>";
							            	str += " <td><label class='badge badge-info'>가입대기</label></td>";
							            }else
							            if(data[i+1].joinFlag == "T"){
							            	str +=  "<tr class='getMemberGroup' id=" + data[i+1].memberNo + " name=" + data[i].groupNo + ">";
			                        		str +=  "  <td>"+ data[i].groupName +"</td>";
			                        		str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
							            	str +=  "  <td>"+ data[i+1].joinDate +"</td>";
							            	str +=  " <td><label class='badge badge-success'>가입승인</label></td>";
							            }else
							            if(data[i+1].joinFlag == "L"){
							            	if(data[i].groupRslt == "T")
							            	{
							            		str +=  "<tr class='getMemberGroup' id=" + data[i+1].memberNo + " name=" + data[i].groupNo + ">";
				                        		str +=  "  <td>"+ data[i].groupName +"</td>";
				                        		str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
								            	str +=  "  <td>"+ data[i+1].applDate +"</td>";
								            	str +=  " <td><label class='badge badge-warning'>모임장</label></td>";	
							            	}
							            	
							            }else{
							            	str +=  "<tr class='getApplJoin' id=" + data[i+1].memberNo + " name=" + data[i].groupNo + ">";
			                        		str +=  "  <td>"+ data[i].groupName +"</td>";
			                        		str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
							            	str +=  " <td>"+ data[i+1].applDate +"</td>";
							            	str +=  " <td><label class='badge badge-danger'>가입거부</label></td>";
							            }
							            i++;
							            
							            str +=  "</tr>";
		                        	}else
		                        	if(targetElementId == "getGroupListWait"){
		                        		str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].leaderNick +"</td>";
									            
									            if(data[i].groupRslt == "T")
				                        		{
									            	str +=  "<td>"+ data[i].open_date +"</td>";
				                        			str +=  "<td><label class='badge badge-success'>개설완료</label></td>";
				                        		}else
				                        		if(data[i].groupRslt == "F"){
				                        			str +=  "<td>"+ data[i].rslt_date +"</td>";
				                        			str +=  "<td><label class='badge badge-danger'>개설누락</label></td>";
				                        		}
				                        		else
				                        		if(data[i].groupRslt == "E"){
				                        			str +=  "<td>"+ data[i].appl_date +"</td>";
				                        			str +=  "<td><label class='badge badge-info'>개설대기</label></td>";
				                        		}
									            str += "</tr>";
		                        	}else
		                        	if(targetElementId == "getGroupListTrue"){
		                        		str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].leaderNick +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>";
									            if(data[i].groupRslt == "T")
				                        		{
				                        			str +=  "<td><label class='badge badge-success'>개설완료</label></td>";
				                        		}else
				                        		if(data[i].groupRslt == "F"){
				                        			str +=  "<td><label class='badge badge-danger'>개설누락</label></td>";
				                        		}
				                        		else
				                        		if(data[i].groupRslt == "E"){
				                        			str +=  "<td><label class='badge badge-info'>개설대기</label></td>";
				                        		}
									            str += "</tr>";
		                        	}else
		                        	if(targetElementId == "getGroupListNone"){
		                        		str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].leaderNick +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>";
									            if(data[i].groupRslt == "T")
				                        		{
				                        			str +=  "<td><label class='badge badge-success'>개설완료</label></td>";
				                        		}else
				                        		if(data[i].groupRslt == "F"){
				                        			str +=  "<td><label class='badge badge-danger'>개설누락</label></td>";
				                        		}
				                        		else
				                        		if(data[i].groupRslt == "E"){
				                        			str +=  "<td><label class='badge badge-info'>개설대기</label></td>";
				                        		}
									            str += "</tr>";
		                        	}
                        		}
                        	}else{
                        		if(targetElementId == "getGroupList"){
	                        		str +=  "<tr>" +
		    					            "  <td colspan=3>데이터가 없습니다.</td>" +
		    					            "  <td></td>" +
		    					            "  <td></td>" +
		    					            "</tr>";
	                        	}else
	                        	if(targetElementId == "getGroupRankingList"){
	                        		str +=  "<tr>" +
		    					            "  <td colspan=3>데이터가 없습니다.</td>" +
		    					            "  <td></td>" +
		    					            "  <td></td>" +
		    					            "</tr>";
	                        	}else
	                        	if(targetElementId == "getMyGroupList"){
	                        		str +=  "<tr>" +
		    					            "  <td colspan=3>데이터가 없습니다.</td>" +
		    					            "  <td></td>" +
		    					            "  <td></td>" +
		    					            "</tr>";
	                        		targetElementId = "MyInfo";        
	                        	}else
	                        	if(targetElementId == "getApplJoinList"){
	                        		str +=  "<tr>" +
			   					            "  <td colspan=3>데이터가 없습니다.</td>" +
			   					            "  <td></td>" +
			   					            "  <td></td>" +
			   					            "</tr>";
                       				targetElementId = "MyInfo";       
	                        	}else
	                        	if(targetElementId == "getGroupListWait"){
	                        		str +=  "<tr>" +
			   					            "  <td colspan=3>데이터가 없습니다.</td>" +
			   					            "  <td></td>" +
			   					            "  <td></td>" +
			   					            "</tr>";
	                        		targetElementId = "MyInfo";       
	                        	}else
	                        	if(targetElementId == "getGroupListTrue"){
	                        		str +=  "<tr>" +
			   					            "  <td colspan=3>데이터가 없습니다.</td>" +
			   					            "  <td></td>" +
			   					            "  <td></td>" +
			   					            "</tr>";
	                        		targetElementId = "MyInfo";
	                        	}else
	                        	if(targetElementId == "getGroupListNone"){
	                        		str +=  "<tr>" +
			   					            "  <td colspan=3>데이터가 없습니다.</td>" +
			   					            "  <td></td>" +
			   					            "  <td></td>" +
			   					            "</tr>";
	                        		targetElementId = "MyInfo";
	                        	}
                        	}
                        	if(targetElementId == "getMyGroupList" || targetElementId == "getApplJoinList" || targetElementId == "getGroupListWait" || 
                        			targetElementId == "getGroupListTrue" || targetElementId == "getGroupListNone")
                        	{
                        		targetElementId = "MyInfo";   
                        	}
                        	
	                        $('#' + targetElementId).html(str);
	                    },
	                    error: function(xhr, status, error) {
	                        // AJAX 요청 실패 시 실행되는 함수
	                    },
	                    complete: function(xhr, status) {
	                        // AJAX 요청 완료 후 실행되는 함수
	                    }
	                });
	            }
				
				window.onload = function() {
		            // 페이지 로드 시 실행되는 함수
		
		            // AJAX 요청 함수
		            
		
		            // 모임 리스트
		            sendAjaxRequest("/app/group/getGroupList", "T", "", "getGroupList");
		
		            // 모임 랭킹 리스트
		            sendAjaxRequest("/app/group/getGroupRankingList", "Ranking", "", "getGroupRankingList");
					
		            
		            if("1" != "${user.role}")
		            {
		            	// 내 모임 신청정보
			            sendAjaxRequest("/app/group/getGroupList", "My", "${user.nickname}", "getMyGroupList");
		            }
		            
		            if("1" == "${user.role}")
		            {
		            	// 모든 모임 신청정보(개설대기)(관리자만)
			            sendAjaxRequest("/app/group/getGroupList", "E", "", "getGroupListWait");
		            }
		
		        }
				
			});
			
			function scrollToSection(id) {
				
			  if(id == "GroupList")
			  {
				  const element = document.getElementById(id);
			      if (element) {
			        element.scrollIntoView({
			          behavior: 'smooth',
			          block: 'end' // 스크롤 위치 조정 (start, center, end 중 선택 가능)
			        });
			      } else {
			        console.warn(`Element with id "${id}" not found.`);
			      }
			  }else
			  {
				  const element = document.getElementById(id);
			      if (element) {
			        element.scrollIntoView({
			          behavior: 'smooth',
			          block: 'center' // 스크롤 위치 조정 (start, center, end 중 선택 가능)
			        });
			      } else {
			        console.warn(`Element with id "${id}" not found.`);
			      }
			  }
		      
		    }
	        
	    </script>
		<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<!-- SIDE -->
		<div class="container-fluid">
	    	<div class="row">
			    <nav class="sidebar sidebar-offcanvas" id="sidebar">
			        <div class="position-fixed">
				        <ul class="nav">
				          <li class="nav-item">
				          	<a class="nav-link">
				          		<i class="menu-icon"><img src="/group/img/house-door.svg"></i>
				          		<span class="menu-title home">모임홈</span>
				          	</a>
				          </li>
				          <li class="nav-item">
				            <a class="nav-link">
				              <i class="menu-icon"><img src="/group/img/building-add.svg"></i>
				              <span class="menu-title">모임목록</span>
				            </a>
				          </li>
				          <li class="nav-item">
				            <a class="nav-link">
				              <i class="menu-icon"><img src="/group/img/building-add.svg"></i>
				              <span class="menu-title">내 모임관리</span>
				            </a>
				          </li>
				          <li class="nav-item">
				            <a class="nav-link">
				              <i class="menu-icon"><img src="/group/img/building-add.svg"></i>
				              <span class="menu-title">모임랭킹</span>
				            </a>
				          </li>
				           <li class="nav-item">
				            <a class="nav-link">
				              <i class="menu-icon"><img src="/group/img/building-add.svg"></i>
				              <span class="menu-title">모임개설신청</span>
				            </a>
				          </li>
				        </ul>
			        </div>
			    </nav>
		<!-- SIDE -->
		<!-- Main Content -->
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="col-12" id="GroupList">
					<div class="row">
						<!-- 왼쪽 1번  -->
						<div class="col-md-1 grid-margin stretch-card">
						</div>
						<div class="col-md-10 grid-margin stretch-card">
						
							<div class="card">
								<div class="card-body" id="list">
									<h4 class="card-title">모임목록</h4>
					                <div class="form-group">
										<div class="input-group">
					                    	<input type="text" class="form-control searchKeyword" placeholder="모임명" aria-label="모임명">
						                    <div class="input-group-append">
						                    	<button class="btn btn-sm btn-primary" type="button">Search</button>
						                    </div>
										</div>
					                </div>
									<div class="list-wrapper pt-2" style="max-height:310px;">
										<table class="table table-striped todo-list todo-list-custom table-hover">
											<thead>
												<tr>
													<th>모임명</th>
													<th>모임등급</th>
													<th>인원수</th>
										        </tr>  
									        </thead>
									        <tbody id="getGroupList">
									           
											</tbody>
									    </table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-1 grid-margin stretch-card">
						</div>
					</div>
					
				</div>
				
						<!-- 왼쪽 1번  -->
						
						<!-- 오른쪽 2번  -->
				<div class="col-12" >
					<div class="row">
						<div class="col-md-1 grid-margin stretch-card" >
						</div>
					    <div class="col-md-10 grid-margin stretch-card" >
							<div class="card">
							    <div class="card-body fixed-card-body" >
							    	<div style="float:right;">
		                    			<img src="/group/img/building-add.svg"><span>&nbsp;모임개설신청</span>
				                    </div>
							    	<p class="card-title">관리</p>
									 <div class="form-group">
										<div class="btn-group" role="group" aria-label="Basic example">
										<c:if test="${user.role != '1'}">
					                        <button type="button" class="btn btn-outline-secondary btn-outline-info">내 개설모임</button>
					                        <button type="button" class="btn btn-outline-secondary btn-outline-info">내 가입모임</button>
				                        </c:if>
				                        <c:if test="${user.role == '1'}">
					                        <button type="button" class="btn btn-outline-secondary btn-outline-info">(관리자)대기신청서</button>
					                        <button type="button" class="btn btn-outline-secondary btn-outline-info">(관리자)승인신청서</button>
					                        <button type="button" class="btn btn-outline-secondary btn-outline-info">(관리자)거부신청서</button>
				                        </c:if>
				                        </div>
					                </div>
									<div class="list-wrapper pt-2" style="max-height:310px;">
								        <table class="table table-striped table-borderless table-hover" id="MyInfo">
											
										</table>
									</div>
								</div>
							</div>
					    </div>
					    <div class="col-md-1 grid-margin stretch-card" >
						</div>
					</div>
				</div>
					    <!-- 오른쪽 2번  -->
				<div class="col-12" id="Ranking">
					<div class="row">
					    <!-- 왼쪽 2번  -->
					    <div class="col-md-1 grid-margin stretch-card">
						</div>
					    <div class="col-md-10 grid-margin stretch-card" id="ranking">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">모임랭킹 <code>* 상위 10위</code></h4>
					                <div class="form-group">
										<div class="btn-group" role="group" aria-label="Basic example">
				                        <button type="button" class="btn btn-outline-secondary btn-inverse-info">인원 수</button>
				                        </div>
					                </div>
									<div class="list-wrapper pt-2" style="max-height:310px;">
										<table class="table table-striped table-borderless todo-list todo-list-custom">
											<thead>
												<tr>
													<th>모임명</th>
													<th>모임등급</th>
													<th>인원수</th>
										        </tr>  
									        </thead>
									        <tbody id="getGroupRankingList">
									          
											</tbody>
									    </table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-1 grid-margin stretch-card">
						</div>
						<!-- 왼쪽 2번  -->
						
					</div>
				</div>
			</div>
		</div>
		<form id="MyForm">
		
		</form>
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>