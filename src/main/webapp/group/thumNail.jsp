<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>WEWU</title>
	<style>
	.thumbnail {
		padding: 10px;
		border: 1px solid #ddd;
		border-radius: 5px;
		transition: transform 0.2s;
		cursor: pointer; /* 클릭 가능하도록 커서 추가 */
	}
	
	.thumbnail img {
		width: 100%;
		height: 300px;
		border-radius: 5px;
	}
	
	.thumbnail:hover {
		transform: scale(1.05);
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
	}
	
	.caption {
		padding: 10px 0;
	}
	
	.caption h4 {
		padding: 5px;
		margin-bottom: 10px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	.caption p {
		font-size: 0.9em;
		color: #555;
	}
	
	.caption .btn {
		margin-right: 5px;
	}
	</style>
	
	</head>
	<body>
		<div class="col-lg-12 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">${groupBoard.boardName}</h4>
				    <div style="float:right;">
				    	<c:if test="${!empty groupMember && groupMember.joinFlag == 'T' || groupMember.joinFlag == 'L'}">
				    	
				    		<c:if test="${groupBoard.boardRole == 'G' }">
				    			<c:if test="${user.nickname == group.leaderNick}">
				    				<img src="/group/img/pencil.svg"><span>작성</span>&nbsp;
				    			</c:if>
				    		</c:if>
				    		
				    		<c:if test="${groupBoard.boardRole == 'A' }">
				    			<img src="/group/img/pencil.svg"><span>작성</span>&nbsp;
				    		</c:if>
				    		
				           	<c:if test="${user.nickname == group.leaderNick}">
					           	<img src="/group/img/arrow-repeat.svg"><span>게시판 수정</span>&nbsp;
					           	<img src="/group/img/eraser-fill.svg"><span>게시판 삭제</span>
					       </c:if>
					       
				        </c:if>
				        
			        </div>
					<div class="col-lg-12 grid-margin stretch-card">
			        	<div class="col-lg-2">
			        	</div>
			        	<div class="col-lg-8" style="margin-top:20px;">
				        	<div class="form-group">
								<div class="input-group">
			                    	<input type="text" class="form-control searchKeyword" placeholder="게시글 이름" aria-label="게시글 이름">
				                    <div class="input-group-append">
				                    	<button class="btn btn-sm btn-success" type="button">Search</button>
				                    </div>
								</div>
			                </div>
		                </div>
		                <div class="col-lg-2">
			        	</div>
			        </div>		
				</div>
				<div class="row" id="thumList">
					
				</div>
				
				<div class="container">
				  <div class="row justify-content-center">
				    <div id="paging" style="float:center;"></div>
				  </div>
				</div>
			</div>
		</div>
	</body>
</html>
