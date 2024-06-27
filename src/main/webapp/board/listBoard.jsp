<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.thumbnail {
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	transition: transform 0.2s;
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

.caption h3 {
	font-size: 1.2em;
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
<script type="text/javascript">
	var currentPage = 1;
	var isLoading = false;

	function loadMoreData() {
		if (isLoading) return;
		isLoading = true;
		currentPage++;

		$.ajax({
			url: "/app/board/listBoard",
			type: "GET",
			data: {
				boardType: "${param.boardType}",
				page: currentPage
			},
			dataType: "json",
			success: function(data) {
				if (data.length > 0) {
					var newContent = "";
					$.each(data, function(index, board) {
						var file = board.fileName ? board.fileName : "/images/back.png";
						newContent += `
						<div class="col-sm-6 col-md-4 col-lg-3 mb-4">
							<div class="thumbnail">
								<img src="${file}" alt="${file}">
								<div class="caption">
								
									<h3>${board.title}</h3>
									<p>
										<strong>${board.nickName}</strong><br> 
										${board.regDate}<br>
										<i class="mdi mdi-star"></i> ${board.bookmarkCnt} 
										<i class="mdi mdi-eye"></i> ${board.views} 
										<i class="mdi mdi-comment"></i> ${board.commentCnt}
									</p>
									<p>
										<a href="/board/getBoard?boardType=${board.boardType}&boardNo=${board.boardNo}" class="btn btn-primary" role="button">보기</a>
										<a href="#" class="btn btn-secondary" role="button" onclick="addBookmark(${board.boardNo})">북마크</a>
									</p>
								</div>
							</div>
						</div>`;
					});
					$('.row').append(newContent);
				} else {
					$(window).off('scroll', onScroll);
				}
				isLoading = false;
			},
			error: function() {
				isLoading = false;
			}
		});
	}

	function onScroll() {
		if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
			loadMoreData();
		}
	}

	$(function() {
		$(window).on('scroll', onScroll);

		$("td:nth-child(2)").on("click", function() {
			self.location = "/board/getBoard?boardType=${param.boardType}" + "&boardNo=" + $($(this).children()).val();
		});

		$("button.btn.btn-outline-primary").on("click", function() {
			self.location = "/board/addBoard?boardType=${param.boardType}";
		});
	});
	
	$(function(){
		$("div.thumbnail").on("click",function(){
			self.location ="/board/getBoard?boardType=${param.boardType}&boardNo="+$($(this).children()).val();
		});
	});
</script>
</head>
<body>
	<input type="hidden" name="boardType" value="${param.boardType}">
	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->

	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />

		<div class="main-panel">
			<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title">
							<c:if test="${param.boardType eq '1'}"> 공지 사항 </c:if>
							<c:if test="${param.boardType eq '2'}"> 모임 홍보 </c:if>
							<c:if test="${param.boardType eq '3'}"> 모임 후기 </c:if>
							<c:if test="${param.boardType eq '4'}"> 후원 </c:if>
						</h1>

						<div class="row">
							<c:set var="index" value="0" />
							<c:forEach var="board" items="${list}" varStatus="loop">
								<div class="col-sm-6 col-md-4 col-lg-3 mb-4">
									<div class="thumbnail">
										<input type="hidden" value="${board.boardNo}">
										<c:if test="${empty file[loop.index].fileName}">
											<img src="/images/back.png" alt="Default Thumbnail">
										</c:if>
										<c:if test="${not empty file[loop.index].fileName}">
											<img src="${file[loop.index].fileName}"
												alt="${file[loop.index].fileName}">
										</c:if>
										<hr>
										<div class="caption">
											<h3>${board.title}</h3>
											<p>
												<strong>${board.nickName}</strong><br> ${board.regDate}<br>
												<i class="mdi mdi-star"></i> ${board.bookmarkCnt} <i
													class="mdi mdi-eye"></i> ${board.views} <i
													class="mdi mdi-comment"></i> ${board.commentCnt}
											</p>
											<p>
												
												
												<a href="#" class="btn btn-secondary" role="button"
													onclick="addBookmark(${board.boardNo})">북마크</a>
											</p>

										</div>
									</div>
								</div>
							</c:forEach>
						</div>

						<div class="card mt-4">
							<div class="card-body">
								<c:if
									test="${sessionScope.user.role eq '1' && param.boardType eq '1'}">
									<button type="button" class="btn btn-outline-primary btn-fw">공지
										글 등록하기</button>
								</c:if>
								<c:if
									test="${(sessionScope.isAdmin || sessionScope.user.role eq '3') && param.boardType eq '2'}">
									<button type="button" class="btn btn-outline-primary btn-fw">모임
										홍보 글 등록하기</button>
								</c:if>
								<c:if
									test="${sessionScope.user.role eq '2' && param.boardType eq '3'}">
									<button type="button" class="btn btn-outline-primary btn-fw">모임
										후기 글 등록하기</button>
								</c:if>
								<c:if test="${sessionScope.isAdmin && param.boardType eq '4'}">
									<button type="button" class="btn btn-outline-primary btn-fw">후원
										글 등록하기</button>
								</c:if>
							</div>
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
