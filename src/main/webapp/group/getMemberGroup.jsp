<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<style>
		.switch {
		  position: relative;
		  display: inline-block;
		  width: 60px;
		  height: 34px;
		  float:left;
		}
		
		/* Hide default HTML checkbox */
		.switch input {display:none;}
		
		/* The slider */
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 26px;
		  width: 26px;
		  left: 4px;
		  bottom: 4px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		input.default:checked + .slider {
		  background-color: #444;
		}
		input.primary:checked + .slider {
		  background-color: #2196F3;
		}
		input.success:checked + .slider {
		  background-color: #8bc34a;
		}
		input.info:checked + .slider {
		  background-color: #3de0f5;
		}
		input.warning:checked + .slider {
		  background-color: #FFC107;
		}
		input.danger:checked + .slider {
		  background-color: #f44336;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}
		</style>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script>
			$(document).ready(function() {
				
				if("${user}" == "")
				{
					alert("모임은 WEWU 회원만 사용 가능합니다!");
					location.href="/";
				}
			});
			
			$(function() 
			{
				$(document).on('mouseenter', '.getGroupAcle', function() {
			        $(this).css('cursor', 'pointer');
			    });
				
				$(document).on('click', '.getGroupAcle', function() {
					var str = "<input type hidden name=boardNo value=" + $(this).attr("id") + ">";
			        $("#getGroupAcle").append(str).attr("action","/group/getGroupAcle").attr("method","post").submit();
			    });
				
				$( "span:contains('수정')" ).on("click" , function() 
			 	{
					updateMemberGroup();
				}); 
				
				$( "span:contains('탈퇴')" ).on("click" , function() 
			 	{
					deleteMemberGroup();
				}); 
				
				$(document).on('mouseenter', '.page-comm', function() {
			        $(this).css('cursor', 'pointer');
			    });
				
				$(document).on('mouseenter', '.page-acle', function() {
			        $(this).css('cursor', 'pointer');
			    });
			    
			    $(document).on('click', '.page-comm', function() {
			    	memberCommentList($(this).attr("id"));
			    });
			    
			    $(document).on('click', '.page-acle', function() {
			    	memberGroupAcle($(this).attr("id"));
			    });
			    
				$( "#scrab" ).on("click" , function() 
			 	{
					 // 체크박스 요소를 가져옵니다.
				    let checkbox = document.getElementById('scrab');

				    // 체크 상태를 확인합니다.
				    if (checkbox.checked) {
				        updateFlag("Y");
				    } else {
				    	
				    	updateFlag("N");
				    }
				}); 
				
				memberGroupAcle(1);
				memberCommentList(1);
				myAclePaging(1);
				myCommentPaging(1);
			});
			
			function updateFlag(scrabFlag){
				
				$.ajax ({
					url	: "/app/group/updateScrab", // (Required) 요청이 전송될 URL 주소
					type  : "POST", // (default: ‘GET’) http 요청 방식
					async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					data  : JSON.stringify(
					 			{
					 				memberNo:${groupMember.memberNo eq null ? '0' : groupMember.memberNo},
					 				scrabFlag:scrabFlag
					 			}
					 		), // 요청 시 전달할 데이터
					processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
					contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
					dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
					beforeSend  : function () {
					  // XHR Header 포함, HTTP Request 하기전에 호출
					  
					},
					success : function(data, status, xhr) {
						
					},
					error	: function(xhr, status, error) {
					  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					},
					complete : function(xhr, status) {
					  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					}
				});
			}
			
			function deleteMemberGroup(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteMemberGroup');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);
	
		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteMemberGroup", // (Required) 요청이 전송될 URL 주소
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
								$("#getGroup").submit();
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
			
			function memberGroupAcle(currentPage)
			{
				$.ajax ({
					  url	: "/app/group/memberGroupAcle", // (Required) 요청이 전송될 URL 주소
					  type	: "POST", // (default: ‘GET’) http 요청 방식
					  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					  data  : JSON.stringify(
							  	{groupNo:${groupMember.groupNo},
							  	 currentPage:currentPage,
							  	 memberNickName:"${groupMember.memberNickName}"}
				 				), // 요청 시 전달할 데이터
					  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
					  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
					  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
					  beforeSend  : function () {
					    // XHR Header 포함, HTTP Request 하기전에 호출
					  },
					  success : function(data, status, xhr) {
						  var str  = "";
						  	  
						  for(var i = 0 ; i < data.length ; i ++){
							  str += "<tr class=getGroupAcle id=" + data[i].boardNo + ">";
							  str += "<td>" + data[i+1].boardName + "</td>";
						  	  str += "<td>" + data[i].acleName + "</td>";
						  	  str += "</tr>";
							  i++
						  }
						  $('#acleList').html(str);
						  str = "";
						  myAclePaging(currentPage);
					  },
					  error	: function(xhr, status, error) {
					    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					  },
					  complete : function(xhr, status) {
					    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					  }
				});
			}
			
			function memberCommentList(currentPage)
			{
				$.ajax ({
					  url	: "/app/group/memberCommentList", // (Required) 요청이 전송될 URL 주소
					  type	: "POST", // (default: ‘GET’) http 요청 방식
					  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					  data  : JSON.stringify(
							  	{groupNo:${groupMember.groupNo},
							  	 currentPage:currentPage,
							  	 memberNickName:"${groupMember.memberNickName}"}
				 				), // 요청 시 전달할 데이터
					  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
					  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
					  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
					  beforeSend  : function () {
					    // XHR Header 포함, HTTP Request 하기전에 호출
					  },
					  success : function(data, status, xhr) {
						  var str  = "";
						  	  
						  for(var i = 0 ; i < data.length ; i ++){
							  str += "<tr class=getGroupAcle id=" + data[i].boardNo + ">";
							  str += "<td>" + data[i+1].acleName + "</td>";
						  	  str += "<td>" + data[i].commentContents + "</td>";
						  	  str += "</tr>";
							  i++
						  }
						  $('#commentList').html(str);
						  str = "";
						  myCommentPaging(currentPage);
					  },
					  error	: function(xhr, status, error) {
					    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					  },
					  complete : function(xhr, status) {
					    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					  }
				});
			}
			
			function myAclePaging(currentPage)
			{
				var str = aclePagination(${acleCount}, currentPage, 5);
				
				$("#aclePaging").html(str);
			}
			
			function myCommentPaging(currentPage)
			{
				var str = commentPagination(${commentCount}, currentPage, 5);
				$("#commentPaging").html(str);
			}
			
			function aclePagination(totalPosts, current, postsPerPage) {
			    var totalPages = Math.ceil(totalPosts / postsPerPage);
			    var paginationHTML = '<nav aria-label="Page navigation" style="align:center;">\n' +
			                         '  <ul class="pagination">\n';
				var currentPage = current;
			    // 이전 버튼
			    if (currentPage > 1) {
			        paginationHTML += '    <li class="page-item">\n' +
			                          '      <a class="page-link page-acle" id=' + (+currentPage-1) + ' aria-label="Previous">\n' +
			                          '        <span aria-hidden="true">&laquo;</span>\n' +
			                          '        <span class="sr-only">Previous</span>\n' +
			                          '      </a>\n' +
			                          '    </li>\n';
			    } else {
			        paginationHTML += '    <li class="page-item disabled">\n' +
			                          '      <span class="page-link page-acle" aria-hidden="true">&laquo;</span>\n' +
			                          '    </li>\n';
			    }

			    // 페이지 번호
			    for (var i = 1; i <= totalPages; i++) {
			        if (i == currentPage) {
			            paginationHTML += '    <li class="page-item active">\n' +
			                              '      <span class="page-link page-acle" id=' + i + '>' + i + ' <span class="sr-only">(current)</span></span>\n' +
			                              '    </li>\n';
			        } else {
			            paginationHTML += '    <li class="page-item">\n' +
			                              '      <a class="page-link page-acle" id=' + i + '>' + i + '</a>\n' +
			                              '    </li>\n';
			        }
			    }

			    // 다음 버튼
			    if (currentPage < totalPages) {
			        paginationHTML += '    <li class="page-item">\n' +
			                          '      <a class="page-link page-acle" id=' + (+currentPage+1) + ' aria-label="Next">\n' +
			                          '        <span aria-hidden="true">&raquo;</span>\n' +
			                          '        <span class="sr-only">Next</span>\n' +
			                          '      </a>\n' +
			                          '    </li>\n';
			    } else {
			        paginationHTML += '    <li class="page-item disabled">\n' +
			                          '      <span class="page-link page-acle" aria-hidden="true">&raquo;</span>\n' +
			                          '    </li>\n';
			    }

			    paginationHTML += '  </ul>\n' +
			                     '</nav>';

			    return paginationHTML;
			}
			
			function commentPagination(totalPosts, current, postsPerPage) {
			    var totalPages = Math.ceil(totalPosts / postsPerPage);
			    var paginationHTML = '<nav aria-label="Page navigation" style="align:center;">\n' +
			                         '  <ul class="pagination">\n';
			    var currentPage = current;
			    // 이전 버튼
			    if (currentPage > 1) {
			        paginationHTML += '    <li class="page-item">\n' +
			                          '      <a class="page-link page-comm" id=' + i + ' aria-label="Previous">\n' +
			                          '        <span aria-hidden="true">&laquo;</span>\n' +
			                          '        <span class="sr-only">Previous</span>\n' +
			                          '      </a>\n' +
			                          '    </li>\n';
			    } else {
			        paginationHTML += '    <li class="page-item disabled">\n' +
			                          '      <span class="page-link page-comm" aria-hidden="true">&laquo;</span>\n' +
			                          '    </li>\n';
			    }

			    // 페이지 번호
			    for (var i = 1; i <= totalPages; i++) {
			        if (i == currentPage) {
			            paginationHTML += '    <li class="page-item active">\n' +
			                              '      <span class="page-link page-comm" id=' + i + '>' + i + ' <span class="sr-only">(current)</span></span>\n' +
			                              '    </li>\n';
			        } else {
			            paginationHTML += '    <li class="page-item">\n' +
			                              '      <a class="page-link page-comm" id=' + i + '>' + i + '</a>\n' +
			                              '    </li>\n';
			        }
			    }

			    // 다음 버튼
			    if (currentPage < totalPages) {
			        paginationHTML += '    <li class="page-item">\n' +
			                          '      <a class="page-link page-comm" id=' + (+currentPage+1) + ' aria-label="Next">\n' +
			                          '        <span aria-hidden="true">&raquo;</span>\n' +
			                          '        <span class="sr-only">Next</span>\n' +
			                          '      </a>\n' +
			                          '    </li>\n';
			    } else {
			        paginationHTML += '    <li class="page-item disabled">\n' +
			                          '      <span class="page-link page-comm" aria-hidden="true">&raquo;</span>\n' +
			                          '    </li>\n';
			    }

			    paginationHTML += '  </ul>\n' +
			                     '</nav>';

			    return paginationHTML;
			}
		</script>
	</head>
	<body>
		<!-- SIDEBAR -->
		<jsp:include page="/group/groupSide.jsp"></jsp:include>
		<!-- SIDEBAR -->
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="col-12 grid-margin stretch-card">
		            <div class="card">
		                <div class="card-body">
		                    <h4 class="card-title"><img class="sideIcon" src="/group/img/profile.png">내 정보</h4>
		                    <div style="float:right;">
			                    <c:if test="${groupMember.memberNickName != group.leaderNick}">
	                    			<img src="/group/img/eraser-fill.svg"><span>탈퇴</span>
	                    		</c:if>
		                    </div>
		                        ${groupMember.memberNickName}
		                    <p class="card-description">
		                        가입날짜 : #${groupMember.rsltDate}<br>
		                        
		                       	성별 : <c:if test="${groupMember.gender == 'M' ? '남성':'여성'}"></c:if>
		                    </p>
	                        
	                        <c:if test="${groupMember != null }">
		                        <!-- 모임원만 출력 -->
		                        <div class="col-md-12">
		                            <div class="card">
		                                <div class="card-body">
		                                	<h4 class="card-title">스크랩</h4>
	                                     	<label class="switch">
									        	<input type="checkbox" id="scrab" class="default" ${groupMember.scrabFlag eq 'Y' ? 'checked' : ''}>
									        	<span class="slider round"></span>
									        </label>
		                                </div>
		                            </div>
		                        </div>
		                        <!-- 모임원만 출력 -->
	                        </c:if>
	                        <div class="row">
		                        <div class="col-6">
					            	<div class="card" style="height:500px;">
						                <div class="card-body">
						                    <h4 class="card-title">내 게시글</h4>
						                	<div class="pt-2">
												<table class="table table-striped table-hover">
													<thead id="getGroupList">
														<tr>
															<th>게시판</th>
															<th>제목</th>
												        </tr>  
											        </thead>
											        <tbody id="acleList">
											           
													</tbody>
											    </table>
											</div>
						                </div>
						                <div class="container">
										  <div class="row justify-content-center">
										    <div id="aclePaging" style="float:center;"></div>
										  </div>
										</div>
						            </div>
			            		</div>
					            <div class="col-6">
					            	<div class="card" style="height:500px;">
						                <div class="card-body" >
						                    <h4 class="card-title">내 댓글</h4>
						                    <div class="pt-2">
												<table class="table table-striped table-hover">
													<thead id="getGroupList">
														<tr>
															<th>게시글제목</th>
															<th>댓글내용</th>
												        </tr>  
											        </thead>
											        <tbody id="commentList">
											           
													</tbody>
											    </table>
											</div>
						                </div>
						                <div class="container">
										  <div class="row justify-content-center">
										    <div id="commentPaging" style="float:center;"></div>
										  </div>
										</div>
						            </div>
					            </div> 
				            </div>
		                </div>
		            </div>
		        </div>
		    </div>
		        
			<form id="deleteMemberGroup" method="post">
				<input type="hidden" name="memberNo" value="${groupMember.memberNo}">
			</form>
				
			<form id="deleteMemberGroup" method="post">
				<input type="hidden" name="memberNo" value="${groupMember.memberNo}">
			</form>
			
			<form id="getGroup" method="post" action="/group/getGroup">
				<input type="hidden" name="groupNo" value="${groupMember.groupNo}">
			</form>
			
			<form id="getGroupAcle" method="post" action="/group/getGroup">
				<input type="hidden" name="groupNo" value="${groupMember.groupNo}">
			</form>
				
        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>