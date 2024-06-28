<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<style>
	.comment-container {
		margin-bottom: 20px;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		background-color: #f9f9f9;
	}
	
	.comment-header {
		font-weight: bold;
	}
	
	.comment-content {
		margin: 10px 0;
	}
	
	.comment-date {
		color: #888;
		font-size: 0.9em;
	}
	
	.comment-actions {
		margin-top: 10px;
	}
	
	.comment-actions a {
		margin-right: 10px;
		color: #007bff;
		text-decoration: none;
	}
	
	.comment-actions a:hover {
		text-decoration: underline;
	}
	
	.comment-form {
		margin-top: 10px;
		display: none;
	}
	
	.comment-form textarea {
		width: 100%;
		height: 60px;
		margin-bottom: 10px;
	}
	
	.comment-form button {
		background-color: #007bff;
		color: white;
		border: none;
		padding: 5px 10px;
		cursor: pointer;
		border-radius: 3px;
	}
	
	.comment-form button:hover {
		background-color: #0056b3;
	}
	
	</style>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<script>
			$(document).ready(function() {
				getCommentList();
			});
			
			$(function() 
			{
				$( "span:contains('신고')" ).on("click" , function() 
			 	{
					addReport();
				}); 
				
				$( "span:contains('수정')" ).on("click" , function() 
			 	{
					updateGroupAcle();
				}); 
				
				$( "span:contains('삭제')" ).on("click" , function() 
			 	{
					deleteGroupAcle();
				}); 
			});

			function deleteGroupAcle(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteGroupAcle');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteGroupAcle", // (Required) 요청이 전송될 URL 주소
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
								$('#getGroupBoard').submit();
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
			
			function getCommentList()
			{
				$.ajax ({
					  url	: "/app/board/getCommentListByBoard", // (Required) 요청이 전송될 URL 주소
					  type	: "POST", // (default: ‘GET’) http 요청 방식
					  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					  data  : JSON.stringify(
					 				{boardNo:'${groupAcle.boardNo}'}
				 				), // 요청 시 전달할 데이터
					  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
					  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
					  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
					  beforeSend  : function () {
					    // XHR Header 포함, HTTP Request 하기전에 호출
					  },
					  success : function(data, status, xhr) {
						  
						  var str = "";
			                for (var i = 0; i < data.length; i++) {
			                    str += "<div class='comment-container'>" +
			                        "<div class='comment-header'>작성자 : " + data[i].commentNickName + "</div>" +
			                        "<div class='comment-content'>내용 : " + data[i].commentContents + "</div>" +
			                        "<div class='comment-date'>작성날짜 : " + data[i].commentDate + "</div>" +
			                        "<div class='comment-actions'>";
			                    
			                    if (data[i].commentNickName === '${user.nickname}') {
			                        str += "<a href='javascript:deleteComment(" + data[i].commentNo + ");'>댓글 삭제</a>" +
			                               "<a href='javascript:showUpdateForm(" + data[i].commentNo + ");'>댓글 수정</a>";
			                    }

			                    str += "</div>" +
			                        "<form id='updateCommentForm_" + data[i].commentNo + "' class='comment-form'>" +
			                        "<input type='hidden' name='commentNo' value='" + data[i].commentNo + "'>" +
			                        "<input type='hidden' name='boardNo' value='" + '${board.boardNo}' + "'>" +
			                        "<input type='hidden' name='commentNickName' value='" + data[i].commentNickName + "'>" +
			                        "<textarea name='commentContents'>" + data[i].commentContents + "</textarea>" +
			                        "<button type='button' onClick='updateComment(" + data[i].commentNo + ");'>수정</button>" +
			                        "&nbsp;&nbsp;" +
			                        "<button type='button' onClick='hideUpdateForm(" + data[i].commentNo + ");'>취소</button>" +
			                        "</form>" +
			                        "</div><br>";
			                }
			                $('#commentList').append(str);
					  },
					  error	: function(xhr, status, error) {
					    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					  },
					  complete : function(xhr, status) {
					    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					  }
				});
			}
			
			function addComment(){
				// form 데이터 가져오기
		    	var form = document.getElementById('commentForm');
		    	var formData = new FormData(form);

		    	// JSON으로 변환
		    	var jsonData = Object.fromEntries(formData);

		    	//모임 리스트
				$.ajax ({
					url	: "/app/board/addComment", // (Required) 요청이 전송될 URL 주소
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
						alert("댓글 등록 완료.");
						
					    $("#commentList").empty();
						getCommentList();
						 
					},
					error	: function(xhr, status, error) {
					  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					},
					complete : function(xhr, status) {
					  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					}
				});
		    }
			
			function updateGroupAcle(){
				var form = document.getElementById("updateGroupAcle");
				form.action="/group/updateGroupAcle";
				form.submit();
			}
			
			function addReport(){
				var form = document.getElementById("addReport");
				form.action="/report/addReport";
				window.open("", "report", "width=600,height=850");
				form.target="report";
				form.submit();
			}
			
			function showUpdateForm(commentNo) {
		        document.getElementById('updateCommentForm_' + commentNo).style.display = 'block';
		    }

		    function hideUpdateForm(commentNo) {
		        document.getElementById('updateCommentForm_' + commentNo).style.display = 'none';
		    }
		    
		    function updateComment(commentNo) {
		        var form = document.getElementById('updateCommentForm_' + commentNo);
		        var formData = new FormData(form);
		        var jsonData = {};
		        formData.forEach((value, key) => { jsonData[key] = value });

		        $.ajax({
		            url: "/app/board/updateComment",
		            type: "POST",
		            async: true,
		            cache: true,
		            timeout: 3000,
		            data: JSON.stringify(jsonData),
		            processData: false,
		            contentType: "application/json",
		            dataType: "json",
		            success: function(data, status, xhr) {
		                alert("댓글 수정 완료.");
		                $("#commentList").empty();
		                getCommentList();
		            },
		            error: function(xhr, status, error) {
		                alert("댓글 수정 실패.");
		            }
		        });
		    }
		    
		    function deleteComment(commentNo) {
		        if (!confirm("댓글을 삭제하시겠습니까?")) {
		            return;
		        } else {
		            $.ajax({
		                url: "/app/board/deleteComment",
		                type: "POST",
		                async: true,
		                cache: true,
		                timeout: 3000,
		                data: JSON.stringify({ commentNo: commentNo, boardNo: ${groupAcle.boardNo} }),
		                processData: false,
		                contentType: "application/json",
		                dataType: "json",
		                success: function(data, status, xhr) {
		                    alert("삭제가 완료되었습니다.");
		                    $("#commentList").empty();
		                    getCommentList();
		                },
		                error: function(xhr, status, error) {
		                    alert("삭제 실패.");
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
        		<div class="card">
	                <div class="card-body">
	                    <h4 class="card-title">${groupBoard.boardName}</h4>
	                    <div style="float:right;">
	                    	<c:if test="${!empty groupMember && groupMember.joinFlag == 'T' || groupMember.joinFlag == 'L'}">
		                    	<img src="/group/img/person-fill-add.svg"><span>신고</span>&nbsp;
		                    	<c:if test="${user.nickname == group.leaderNick || user.nickname == groupAcle.wrteName}">
			                    	<img src="/group/img/arrow-repeat.svg"><span>수정</span>&nbsp;
			                    	<img src="/group/img/eraser-fill.svg"><span>삭제</span>
		                    	</c:if>
	                    	</c:if>
	                    </div>
	                    <hr>
	                    <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                <h5 class="card-title">${groupAcle.acleName}</h5>
                                    <b>${groupAcle.wrteName}</b>
                                    <p class="card-description">
                                    	${groupAcle.wrteDate}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                	<h5 class="card-title">${groupAcle.acleContents}</h5>
                                </div>
                            </div>
                        </div>
                        <hr>
                        
                       <div class="col-md-12">
                           <div class="card">
                               <div class="card-body">
                               		<div class="form-group row">
										<c:if
											test="${user != null && user !=''}">
											<h1 class="card-title">${user.nickname}</h1>
											<div class="col-sm-12">
												<form id="commentForm">
													<input type="hidden" name="commentNickName"
														id="commentNickName" value="${user.nickname}">
													<input type="hidden" name="boardNo" id="boardNo"
														value="${groupAcle.boardNo}">
													<textarea name="commentContents" class="form-control"
														id="commentContents"></textarea>
													<br>
												</form>
												<button class="btn btn-link btn-fw" onClick="addComment();">댓글
													쓰기</button>
											</div>
										</c:if>
										<c:if
											test="${groupMember == null || groupMember ==''}">
											<p>로그인 후 댓글을 작성할 수 있습니다.</p>
										</c:if>
									</div>
	                               	<div id="commentList">
	                               	
									</div>
                               </div>
                           </div>
                       </div>
	                </div>
	            </div>
				
				<form id="deleteGroupAcle" method="post">
					<input type="hidden" name="boardNo" value="${groupAcle.boardNo}">
				</form>
					
				<form id="updateGroupAcle" method="post">
					<input type="hidden" name="boardNo" value="${groupAcle.boardNo}">
					<input type="hidden" name="typeNo" value="${groupAcle.typeNo}">
				</form>
					
				<form id="getGroupBoard" method="post" action="/group/getGroupBoard">
					<input type="hidden" name="typeNo" value="${groupAcle.typeNo}">
				</form>
				
				<form id="addReport" method="post" action="/report/addReport">
					<input type="hidden" name="targetNo" value="${groupAcle.boardNo}">
					<input type="hidden" name="reportType" value="B">
				</form>

        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>