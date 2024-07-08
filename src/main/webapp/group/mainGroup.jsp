<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<style>
			.card-body {
				height:450px;
		    }
		    .list-wrapper{
		    	
		    }
		    
			.sideIcon
			{
				width:30px;
				height:30px;
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
			.group_nav:hover 
			{ 
				color: black;
				text-decoration-line: none;
				background: rgba(3,199,90,.12);
			}
			
			.jumbotron
			{
			    padding: 6rem 2rem;
				background-color: #00A06C;
				margin-top:160px;
				margin-bottom:0;
				background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
				background-image: url('/group/img/illustration.jpg'); /* 배경 이미지 경로 */
				background-size: cover; /* 이미지가 컨테이너를 덮도록 */
				background-position: center; /* 이미지가 중앙에 위치하도록 */
			}
			.main-panel
			{
				margin:0;
			}
			
			.display-4 
			{
			  color: #459BF6; /* 원하는 색상으로 변경 */
			}
		</style>
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
					 
					if("${user}" == "")
					{
						alert("모임은 WEWU 회원만 사용 가능합니다!");
						location.href="/";
					}
					
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
	                        					"<th></th>" +
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
				               					"<th></th>" +
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
				               					"<th></th>" +
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
				               					"<th></th>" +
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
				               					"<th></th>" +
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
		                        		str +=  "<tr class=groupNo id=" + data[i].groupNo + ">";
		                        		if(data[i].groupImg != null)
		                        		{
		                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
		                        		}else
		                        		{
		                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
		                        		}
		                        		str +=  "  <td>"+ data[i].groupName +"</td>";
		                        		str +=  "  <td>#"+ data[i].groupHash +"</td>";
		                        		str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
		                        		str +=  "  <td>"+ data[i].groupPers +"</td>";
		                        		str +=  "  <td>"+ data[i].openDate +"</td>";
		                        		str +=  "</tr>";
		                        	}else
		                        	if(targetElementId == "getGroupRankingList"){
		                        		str +=  "<tr class=groupNo id=" + data[i].groupNo + ">";
		                        				if(i == 0)
		                        				{
		                        					str +=  "  <td><img class='sideIcon' src='/group/img/medal_1.png'></td>";
		                        				}else
		                        				if(i == 1)
		                        				{
		                        					str +=  "  <td><img class='sideIcon' src='/group/img/medal_2.png'></td>";
		                        				}else
		                        				if(i == 2)
		                        				{
		                        					str +=  "  <td><img class='sideIcon' src='/group/img/medal_3.png'></td>";
		                        				}else
		                        				{
		                        					str +=  "  <td>"+(i+1)+"</td>";
		                        				}
		                        				if(data[i].groupImg != null)
				                        		{
				                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
				                        		}else
				                        		{
				                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
				                        		}
		                        				str +=  "  <td>"+ data[i].groupName +"</td>";
		                        				str +=  "  <td>"+ data[i].groupHash +"</td>";
		                        				str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
		                        				str +=  "  <td>"+ data[i].groupPers +"</td>";
		                        				str +=  "  <td>"+ data[i].openDate +"</td>";
		                        				str +=  "</tr>";
		                        	}else
		                        	if(targetElementId == "getMyGroupList"){
		                        		
		                        		if(data[i].groupRslt == "T")
		                        		{
		                        			str +=  "<tr class='getGroup' id=" + data[i].groupNo + ">";
		                        		}else
		                        		{
		                        			str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">";
		                        		}
		                        		if(data[i].groupImg != null)
		                        		{
		                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
		                        		}else
		                        		{
		                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
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
							            	if(data[i].groupImg != null)
			                        		{
			                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
			                        		}else
			                        		{
			                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
			                        		}
			                        		str += "  <td>"+ data[i].groupName +"</td>";
			                        		str += "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
							            	str += "  <td>"+ data[i+1].applDate +"</td>";
							            	str += " <td><label class='badge badge-info'>가입대기</label></td>";
							            }else
							            if(data[i+1].joinFlag == "T"){
							            	str +=  "<tr class='getMemberGroup' id=" + data[i+1].memberNo + " name=" + data[i].groupNo + ">";
							            	if(data[i].groupImg != null)
			                        		{
			                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
			                        		}else
			                        		{
			                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
			                        		}
			                        		str +=  "  <td>"+ data[i].groupName +"</td>";
			                        		str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
							            	str +=  "  <td>"+ data[i+1].rsltDate +"</td>";
							            	str +=  " <td><label class='badge badge-success'>가입승인</label></td>";
							            }else
							            if(data[i+1].joinFlag == "L"){
							            	if(data[i].groupRslt == "T")
							            	{
							            		str +=  "<tr class='getMemberGroup' id=" + data[i+1].memberNo + " name=" + data[i].groupNo + ">";
							            		if(data[i].groupImg != null)
				                        		{
				                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
				                        		}else
				                        		{
				                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
				                        		}
				                        		str +=  "  <td>"+ data[i].groupName +"</td>";
				                        		str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
								            	str +=  "  <td>"+ data[i+1].rsltDate +"</td>";
								            	str +=  " <td><label class='badge badge-warning'>모임장</label></td>";	
							            	}
							            	
							            }else{
							            	str +=  "<tr class='getApplJoin' id=" + data[i+1].memberNo + " name=" + data[i].groupNo + ">";
							            	if(data[i].groupImg != null)
			                        		{
			                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
			                        		}else
			                        		{
			                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
			                        		}
			                        		str +=  "  <td>"+ data[i].groupName +"</td>";
			                        		str +=  "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>";
							            	str +=  " <td>"+ data[i+1].applDate +"</td>";
							            	str +=  " <td><label class='badge badge-danger'>가입거부</label></td>";
							            }
							            i++;
							            
							            str +=  "</tr>";
		                        	}else
		                        	if(targetElementId == "getGroupListWait"){
		                        		str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">";
		                        		if(data[i].groupImg != null)
		                        		{
		                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
		                        		}else
		                        		{
		                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
		                        		}
		                        		str +=  "  <td>"+ data[i].groupName +"</td>";
		                        		str +=  "  <td class=font-weight-bold>"+ data[i].leaderNick +"</td>";
									            
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
		                        		str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">";
		                        		if(data[i].groupImg != null)
		                        		{
		                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
		                        		}else
		                        		{
		                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
		                        		}
		                        		str +=  "  <td>"+ data[i].groupName +"</td>";
		                        		str +=  "  <td class=font-weight-bold>"+ data[i].leaderNick +"</td>";
		                        		str +=  "  <td>"+ data[i].groupPers +"</td>";
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
		                        		str +=  "<tr class='getAddAppl' id=" + data[i].groupNo + ">";
		                        		if(data[i].groupImg != null)
		                        		{
		                        			str +=  "  <td><img src=/group/upload/"+ data[i].groupImg +"/></td>";	
		                        		}else
		                        		{
		                        			str +=  "  <td><img src=/group/img/team.png /></td>";	
		                        		}
		                        		str +=  "  <td>"+ data[i].groupName +"</td>";
		                        		str +=  "  <td class=font-weight-bold>"+ data[i].leaderNick +"</td>";
		                        		str +=  "  <td>"+ data[i].groupPers +"</td>";
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
				          	<a class="group_nav">
				          		<i class="menu-icon"><img class="sideIcon" src="/group/img/real-estate_13468499.png"></i>
				          		<span class="menu-title home"><b>모임홈</b></span>
				          	</a>
				          </li>
				          <li class="nav-item">
				            <a class="group_nav">
				              <i class="menu-icon"><img class="sideIcon" src="/group/img/group_745205.png"></i>
				              <span class="menu-title"><b>모임목록</b></span>
				            </a>
				          </li>
				          <li class="nav-item">
				            <a class="group_nav">
				              <i class="menu-icon"><img class="sideIcon" src="/group/img/checklist_2666436.png"></i>
				              <span class="menu-title"><b>내 모임관리</b></span>
				            </a>
				          </li>
				          <li class="nav-item">
				            <a class="group_nav">
				              <i class="menu-icon"><img class="sideIcon" src="/group/img/medal_13461118.png"></i>
				              <span class="menu-title"><b>모임랭킹</b></span>
				            </a>
				          </li>
				           <li class="nav-item">
				            <a class="group_nav">
				              <i class="menu-icon"><img class="sideIcon" src="/group/img/home_7457021.png"></i>
				              <span class="menu-title" style="font-weight: 700;"><b>모임개설신청</b></span>
				            </a>
				          </li>
				        </ul>
			        </div>
			    </nav>
		<!-- SIDE -->
		
		<!-- Main Content -->
		<div class="main-panel">
			<div class="jumbotron">
			  <div class="container">
			    <p class="display-4"></p>
			  </div>
			</div>
        	<div class="content-wrapper">
        		<div class="col-12">
					<div class="row">
						<!-- 왼쪽 1번  -->
						<div class="col-md-1 grid-margin stretch-card">
						</div>
						<div class="col-md-10 grid-margin stretch-card" id="GroupList">
						
							<div class="card">
								<div class="card-body" id="list">
									<h4 class="card-title"><img class="sideIcon" src="/group/img/group_745205.png">모임목록</h4>
					                <div class="form-group">
										<div class="input-group">
					                    	<input type="text" class="form-control searchKeyword" placeholder="모임명" aria-label="모임명">
						                    <div class="input-group-append">
						                    	<button class="btn btn-sm btn-success" type="button">Search</button>
						                    </div>
										</div>
					                </div>
									<div class="list-wrapper pt-2" style="max-height:310px;">
										<table class="table table-striped todo-list todo-list-custom table-hover">
											<thead>
												<tr>
													<th></th>
													<th>모임명</th>
													<th>모임태그</th>
													<th>모임등급</th>
													<th>인원수</th>
													<th>개설일</th>
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
							    	<p class="card-title"><img class="sideIcon" src="/group/img/checklist_2666436.png">관리</p>
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
									<h4 class="card-title"><img class="sideIcon" src="/group/img/medal_13461118.png">모임랭킹 </h4>
					                <div class="form-group">
										<code>랭킹 :: 등급과 인원 수를 기준</code>
					                </div>
									<div class="list-wrapper pt-2" style="max-height:310px;">
										<table class="table table-striped table-borderless todo-list todo-list-custom">
											<thead>
												<tr>
													<th>순위</th>
													<th></th>
													<th>모임명</th>
													<th>모임태그</th>
													<th>모임등급</th>
													<th>인원수</th>
													<th>개설일</th>
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