<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

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
<script type="text/javascript">
    $(document).ready(function() {
        getCommentList();

        $("button.btn:contains('삭제')").on("click", function() {
            self.location = "/board/deleteBoard?boardType=${param.boardType}&boardNo=${param.boardNo}";
        });

        $("button.btn:contains('수정')").on("click", function() {
            self.location = "/board/updateBoard?boardType=${param.boardType}&boardNo=${param.boardNo}";
        });

        $("button.btn:contains('목록 보기')").on("click", function() {
            self.location = "/board/listBoard?boardType=${param.boardType}";
        });
    });

    function addComment() {
        var form = document.getElementById('commentForm');
        var formData = new FormData(form);
        var jsonData = {};
        formData.forEach((value, key) => { jsonData[key] = value });
        
        if (jsonData.commentContents === "") {
            alert("댓글 내용을 입력해 주세요.");
            return;
        }
        
        $.ajax({
            url: "/app/board/addComment",
            type: "POST",
            async: true,
            cache: true,
            timeout: 3000,
            data: JSON.stringify(jsonData),
            processData: false,
            contentType: "application/json",
            dataType: "json",
            success: function(data, status, xhr) {
                alert("댓글 등록 완료.");
                $("#commentList").empty();
                getCommentList();
                $("#commentContents").val("");  // 댓글 등록 후 textarea 비우기
            },
            error: function(xhr, status, error) {
                alert("댓글 등록 실패.");
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
                data: JSON.stringify({ commentNo: commentNo, boardNo: ${board.boardNo} }),
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

    function getCommentList() {
        $.ajax({
            url: "/app/board/getCommentListByBoard",
            type: "POST",
            async: true,
            cache: true,
            timeout: 3000,
            data: JSON.stringify({ boardNo: '${board.boardNo}' }),
            processData: false,
            contentType: "application/json",
            dataType: "json",
            success: function(data, status, xhr) {
                var str = "";
                for (var i = 0; i < data.length; i++) {
                    str += "<div class='comment-container'>" +
                        "<div class='comment-header'>작성자 : " + data[i].commentNickName + "</div>" +
                        "<div class='comment-content'>내용 : " + data[i].commentContents + "</div>" +
                        "<div class='comment-date'>작성날짜 : " + data[i].commentDate + "</div>" +
                        "<div class='comment-actions'>";
                    
                    if (data[i].commentNickName === '${sessionScope.user.nickname}') {
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
            error: function(xhr, status, error) {
                alert("댓글 목록 불러오기 실패.");
            }
        });
    }

    function showUpdateForm(commentNo) {
        document.getElementById('updateCommentForm_' + commentNo).style.display = 'block';
    }

    function hideUpdateForm(commentNo) {
        document.getElementById('updateCommentForm_' + commentNo).style.display = 'none';
    }
</script>
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->
</head>
<body>
	<input type="hidden" name="boardNo" value="${param.boardNo}">
	<input type="hidden" name="boardType" value="${param.boardType}">



	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />

		<div class="main-panel">
			<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<p class="card-description">
							>
							<c:if test="${param.boardType eq '1'}"> 공지 사항 </c:if>
							<c:if test="${param.boardType eq '2'}"> 모임 홍보 </c:if>
							<c:if test="${param.boardType eq '3'}"> 모임 후기 </c:if>
							<c:if test="${param.boardType eq '4'}"> 후원 </c:if>
						</p>

						<h1 class="card-title">${board.title}</h1>
						<div class="form-group row">
							<div class="col-sm-9">
								<p class="card-description">${board.nickName }&nbsp;&nbsp;
									등록일 : ${board.regDate}</p>
							</div>
							<div class="col-sm-3">
								<p class="card-description">
									<i class="mdi mdi-eye"></i> ${board.views} &nbsp;/&nbsp; <i
										class="mdi mdi-comment"></i> ${board.commentCnt} &nbsp;/&nbsp;
									<i class="mdi mdi-star"></i> ${board.bookmarkCnt }
								</p>
							</div>
						</div>
						<hr>
						<br>
						<div class="form-group row">
							<div class="col-sm-9">
								<c:forEach var="file" items="${boardFile}">
									<img src="${file.fileName}">
									
									<br>
									<br>
								</c:forEach>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-12">${board.contents}</div>
						</div>
						<div class="card-body">
							<hr>
							<p class="card-description">댓글 수 : ${board.commentCnt}</p>
							<div class="form-group row">
								<c:if
									test="${sessionScope.user != null && sessionScope.user !=''}">
									<h1 class="card-title">${sessionScope.user.nickname}</h1>
									<div class="col-sm-12">
										<form id="commentForm">
											<input type="hidden" name="commentNickName"
												id="commentNickName" value="${sessionScope.user.nickname}">
											<input type="hidden" name="boardNo" id="boardNo"
												value="${board.boardNo}">
											<textarea class="form-control" name="commentContents"
												id="commentContents" rows="4"></textarea> 
												
											<br>
										</form>
										<button class="btn btn-link btn-fw" onClick="addComment();">댓글 쓰기</button>
									</div>
								</c:if>
								<c:if
									test="${sessionScope.user == null || sessionScope.user ==''}">
									<p>로그인 후 댓글을 작성할 수 있습니다.</p>
								</c:if>
							</div>
							<div id="commentList"></div>
						</div>
						<br />
						<div class="card-body">
							<c:if
								test="${board.nickName eq sessionScope.user.nickname || sessionScope.isAdmin}">
								<button type="button" class="btn btn-primary mr-2">수정</button>

								<button type="button" class="btn btn-outline-primary btn-fw">삭제</button>

							</c:if>
							&nbsp;
							<button type="button" class="btn btn-inverse-primary btn-fw">목록 보기</button>

						</div>
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
