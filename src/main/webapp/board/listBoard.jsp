<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WEWU</title>
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->

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

.jumbotron {
	background-color: #00A06C;
		margin-top:160px;
	margin-bottom: 0;
	background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
	background-image: url('/images/plant1.jpg'); /* 배경 이미지 경로 */
	background-size: cover; /* 이미지가 컨테이너를 덮도록 */
	background-position: center; /* 이미지가 중앙에 위치하도록 */
}
.sidebar-offcanvas{
margin-top:0px;
}
.main-panel{
margin-top:0px;
}
.container-fluid.page-body-wrapper{
margin-top:0px;
}
b {
    color: white;
}
</style>
<script type="text/javascript">
    var currentPage = 1;
    var isLoading = false;
 
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

        $("button.add-btn").on("click", function() {
            self.location = "/board/addBoard?boardType=${param.boardType}";
        });
        
        $(".searchBtn").on("click",function(){
        	//alert(${search.searchKeyword}));
    		fncGetList(1);
    	})

        // 수정된 부분: 이벤트 위임을 사용하여 동적으로 추가된 요소에도 이벤트 적용
       /*  $(document).on("click", "div.thumbnail", function() {
            var boardNo = $(this).data("board-no");
            self.location = "/board/listBoard?boardType=${param.boardType}";
        }); */
    });
    function addBookmark(boardNo) {    	
        var bookmark = {
            boardNo: boardNo,
            nickName: '${sessionScope.user.nickname}'
        };		
        $.ajax({
            type: "POST",
            url: "/app/board/addBookmark", 
            data: JSON.stringify(bookmark),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                if (response.flag === "Y") {
                    alert("북마크 등록 완료");
                } else {
                    alert("북마크 등록 실패");
                }
            },
            error: function(xhr, status, error) {
                if (xhr.status === 401) {
                    alert("로그인이 필요합니다.");
                } else {
                    console.error("Error occurred while adding bookmark: " + error);
                }
            }
        });
    }

    function deleteBookmark(boardNo) {
        var data = {
            boardNo: boardNo
        };

        $.ajax({
            type: "POST",
            url: "/app/board/deleteBookmark", 
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                if (response.flag === "Y") {
                    alert("북마크 삭제 완료");
                } else {
                    alert("북마크 삭제 실패");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error occurred while deleting bookmark: " + error);
            }
        });
    }


    $(function(){
        $("div.boardClick").on("click",function(){
            self.location ="/board/getBoard?boardType=${param.boardType}&boardNo="+$($(this).children()).val();
        });
    });
    
    function fncGetList(page) {
        var form = $('form#listSearchForm');
        form.find('.currentPage').val(page);
        form.attr("method", "GET").attr("action",
				"/board/listBoard?boardType=${param.boardType}").submit();      

        // 검색 후 텍스트 입력창 비우기
        form.find('input[name="searchKeyword"]').val('');
    }  
 
</script>
</head>
<body>
	<input type="hidden" name="boardType" value="${param.boardType}">
	<div class="jumbotron">
		<div class="container">
			<p class="display-4">
				<b><h3>
						<c:if test="${param.boardType eq '1'}"> 공지 사항 </c:if>
						<c:if test="${param.boardType eq '2'}"> 모임 홍보 </c:if>
						<c:if test="${param.boardType eq '3'}"> 모임 후기 </c:if>
						<c:if test="${param.boardType eq '4'}"> 후원 </c:if>
					</h3></b>
			</p>
		</div>
	</div>
	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />

		<div class="main-panel">

			<div class="row">
				<div class="col-12 grid-margin stretch-card">


					<div class="card">
						<div class="card-body">


							<br> <br>

							<!-- 검색 폼 -->
							<div class="form-group">
								<div class="col-md-6 text-left">
									<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재
										${resultPage.currentPage} 페이지</p>
								</div>

								<form id="listSearchForm" action="/board/listBoard" method="get">
									<div class="input-group">
										<!-- <div class="dropdown show">
										<button type="button" class="btn btn-success dropdown-toggle"
											id="dropdownMenuIconButton9" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="true">
											<i class="ti-user"></i>
										</button>
										<div class="dropdown-menu show"
											aria-labelledby="dropdownMenuIconButton9"
											style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 46px, 0px);"
											x-placement="bottom-start">
											<h6 class="dropdown-header">Settings</h6>
											<a class="dropdown-item" href="#">Action</a> <a
												class="dropdown-item" href="#">Another action</a> <a
												class="dropdown-item" href="#">Something else here</a>
											<div class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">Separated link</a>
										</div>
									</div> -->
										<input type="hidden" class="currentPage" name="currentPage"
											value="${search.currentPage}"> <input type="text"
											class="form-control" placeholder="검색어 입력"
											aria-label="Recipient's username" name="searchKeyword"
											value="${!empty search.searchKeyword ? search.searchKeyword: '' }">

										<input type="hidden" name="boardType"
											value="${param.boardType}">
										<div class="input-group-append">
											<button class="btn btn-sm btn-success searchBtn"
												type="button">Search</button>
										</div>
									</div>
								</form>
							</div>
							<!-- 검색 폼 끝 -->

							<!-- <button type="button" class="btn btn-success" name="" value="0">Success</button>
						<button type="button" class="btn btn-success" name="" value="1">Success</button>
						<button type="button" class="btn btn-success" name="" value="2">Success</button> -->
							<div class="row">
								<c:set var="index" value="0" />
								<c:forEach var="board" items="${list}" varStatus="loop">
									<div class="col-sm-6 col-md-4 col-lg-3 mb-4">
										<div class="thumbnail" data-board-no="${board.boardNo}">
											<div class="boardClick">
												<input type="hidden" name="boardNo" value="${board.boardNo}">
												<c:if test="${empty board.fileName}">
													<img src="/images/back.png" alt="Default Thumbnail">
												</c:if>
												<c:if test="${not empty board.fileName}">
													<img src="${board.fileName}" alt="${board.fileName}">
												</c:if>

												<div class="caption">
													<h4 class="card-title">${board.title}</h4>
													<p>
														<strong>${board.nickName}</strong><br>
														${board.regDate}<br> <i class="mdi mdi-star"></i>
														${board.bookmarkCnt} <i class="mdi mdi-eye"></i>
														${board.views} <i class="mdi mdi-comment"></i>
														${board.commentCnt}
													</p>

												</div>
											</div>
											<div class="caption">
												<c:if test="${board.bookmarkFlag}">
													<button class="btn btn-outline-danger btn-fw"
														onclick="deleteBookmark(${board.boardNo});">북마크
														삭제</button>
												</c:if>
												<c:if test="${!board.bookmarkFlag}">
													<button class="btn btn-outline-primary btn-fw"
														onclick="addBookmark(${board.boardNo});">북마크</button>
												</c:if>
											</div>
										</div>
									</div>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>
							</div>

							<div align="center">
								<div class="btn-group" role="group" aria-label="Basic example">
									<c:if test="${resultPage.currentPage > 1}">
										<button type="button" class="btn btn-outline-secondary"
											onclick="fncGetList(${resultPage.currentPage - 1})">&lt;</button>
									</c:if>
									<c:forEach var="i" begin="${resultPage.beginUnitPage}"
										end="${resultPage.endUnitPage}">
										<c:choose>
											<c:when test="${i == resultPage.currentPage}">
												<button type="button" class="btn btn-primary">${i}</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-outline-secondary"
													onclick="fncGetList(${i})">${i}</button>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
										<button type="button" class="btn btn-outline-secondary"
											onclick="fncGetList(${resultPage.currentPage + 1})">&gt;</button>
									</c:if>
								</div>
							</div>
							<div class="card mt-4">
								<div class="card-body">
									<c:if
										test="${sessionScope.user.role eq '1' && param.boardType eq '1'}">
										<button type="button"
											class="btn btn-outline-primary btn-fw add-btn">공지 글
											등록하기</button>
									</c:if>
									<c:if
										test="${(sessionScope.isAdmin || sessionScope.user.role eq '3') && param.boardType eq '2'}">
										<button type="button"
											class="btn btn-outline-primary btn-fw add-btn">모임 홍보
											글 등록하기</button>
									</c:if>
									<c:if
										test="${sessionScope.user.role eq '2' && param.boardType eq '3'}">
										<button type="button"
											class="btn btn-outline-primary btn-fw add-btn">모임 후기
											글 등록하기</button>
									</c:if>
									<c:if test="${sessionScope.isAdmin && param.boardType eq '4'}">
										<button type="button"
											class="btn btn-outline-primary btn-fw add-btn">후원 글
											등록하기</button>
									</c:if>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>