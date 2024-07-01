<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원 목록 조회</title>
    <link rel="shortcut icon" href="../../images/favicon.png" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <style>
        .navbar {
            margin-bottom: 0; /* .navbar의 margin-bottom을 제거 */
            background-color: #007bff; /* 네비게이션 바 색상 */
        }
        .container {
            font-size: 1.2em; /* 글자 크기를 조정 */
        }
        .table {
            font-size: 1.2em; /* 테이블 글자 크기 조정 */
            width: 100%; /* 테이블 폭을 100%로 설정 */
            background-color: #f8f9fa; /* 테이블 배경색 */
            border: 2px solid #ddd; /* 테이블 경계선 추가 */
        }
        
        .table th, .table td {
            text-align: center; /* 텍스트 중앙 정렬 */
            vertical-align: middle; /* 수직 중앙 정렬 */
        }

        .table th {
            background-color: #007bff; /* 테이블 헤더 배경색 */
            color: white; /* 테이블 헤더 글자색 */
        }

        .btn {
            height: 40px; /* 높이 조정 */
            font-size: 1em; /* 글자 크기 조정 */
            border-radius: 0; /* 둥근 테두리 제거 */
            background-color: #007bff; /* 버튼 색상 */
            color: white; /* 버튼 글자색 */
        }
        h3 {
            font-size: 4.5em; /* 글자 크기 조정 */
            color: #007bff; /* 글자 색상 */
        }
        .page-header {
            margin: 20px 0; /* 여백 조정 */
        }
        .main-panel, .content-wrapper {
            margin: 0; /* main-panel과 content-wrapper의 여백을 없앰 */
            padding-bottom: 0; /* 하단 여백 제거 */
        }
        .content-wrapper {
            min-height: calc(100vh - 50px); /* 화면 높이에 맞추어 최소 높이 설정 */
            padding-bottom: 0; /* 하단 여백 제거 */
        }
        .footer {
            margin-top: 10px; /* 푸터와 내용 사이에 여백 추가 */
        }
        .pagination > li > a, .pagination > li > span {
            background-color: white; /* 페이지네이션 배경색 */
            color: #007bff; /* 페이지네이션 글자색 */
            font-size: 1.5em; /* 폰트 크기 조정 */
            padding: 10px 20px; /* 버튼 크기 조정 */
        }
        .pagination > .active > a, .pagination > .active > span, .pagination > .active > a:hover, .pagination > .active > span:hover, .pagination > .active > a:focus, .pagination > .active > span:focus {
            background-color: #0052ff; /* 활성화된 페이지 배경색 (진한 푸른색) */
            color: white; /* 활성화된 페이지 글자색 */
            border-color: #003366; /* 활성화된 페이지 테두리색 */
            font-size: 1.5em; /* 폰트 크기 조정 */
            padding: 10px 20px; /* 버튼 크기 조정 */
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->

<div class="main-panel">
     <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-left">
                    <div class="page-header text-info">
                        <h3 style="font-size : 2.5rem;">회원목록조회</h3>
                        <p class="text-primary" style="font-size : 1.3rem;">
                        전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
                    	</p>
                    </div>
                </div>
                <div class="col-md-6 text-right">
					<form class="form-inline" name="detailForm" style="float:right; position: relative; top: 45px;">
                        <div class="form-group">
                            <select class="form-control" name="searchCondition" style="height: 40px; font-size: 1em;">
                                <option value="0" ${search.searchCondition == 0 ? "selected" : ""}>회원ID</option>
                                <option value="1" ${search.searchCondition == 1 ? "selected" : ""}>회원명</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="searchKeyword">검색어</label>
                            <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="${search.searchKeyword}" style="height: 40px; font-size: 1em;">
                        </div>
                        <button type="submit" class="btn btn-default" style="height: 40px; font-size: 1em;">검색</button>
                        <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}" />
                    </form>
                </div>
                <div class="col-md-12 text-right">
                <!-- table Start -->
	            <table class="table table-hover table-striped">
	                <thead>
	                    <tr>
	                        <th>No</th>
	                        <th>회원 ID</th>
	                        <th>회원명</th>
	                        <th>닉네임</th>
	                        <th>성별</th>
	                        <th>핸드폰번호</th>
	                        <th>이메일</th>
	                        <th>현재 포인트</th>
	                        <th>주소</th>
	                        <th>상태</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:set var="i" value="0" />
	                    <c:forEach var="user" items="${list}">
	                        <c:set var="i" value="${i + 1}" />
	                        <tr>
	                            <td>${i}</td>
	                            <td title="Click : 회원정보 확인"><a href="#" onclick="fncGetUser('${user.userId}')">${user.userId}</a></td>
	                            <td>${user.userName}</td>
	                            <td>${user.nickname}</td>
	                            <td>${user.gender}</td>
	                            <td>${user.phoneNum}</td>
	                            <td>${user.email}</td>
	                            <td>${user.currentPoint}</td>
	                            <td>${user.addr}</td>
	                            <td>
	                                <c:choose>
	                                    <c:when test="${user.role == 1}">관리자</c:when>
	                                    <c:when test="${user.role == 2}">사용자</c:when>
	                                    <c:when test="${user.role == 3}">그룹장</c:when>
	                                    <c:when test="${user.role == 4}">탈퇴</c:when>
	                                    <c:when test="${user.role == 5}">정지</c:when>
	                                    <c:otherwise>알 수 없음</c:otherwise>
	                                </c:choose>
	                            </td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	            <!-- table End -->
            </div>
            </div>
    		
    
            <!-- 페이지 네비게이션 Start -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center" >
                    <c:if test="${resultPage.currentPage > 1}">
                        <li>
                            <a href="#" onclick="fncGetList(${resultPage.currentPage - 1})" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" var="i">
                        <c:choose>
                            <c:when test="${i == resultPage.currentPage}">
                                <li class="active"><a href="#">${i}</a></li>
                                </c:when>
                            <c:otherwise>
                                <li><a href="#" onclick="fncGetList(${i})">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${resultPage.currentPage < resultPage.maxPage}">
                        <li>
                            <a href="#" onclick="fncGetList(${resultPage.currentPage + 1})" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
            <!-- 페이지 네비게이션 End -->
    
        </div>
    </div>
</div>
    <!-- FOOTER -->
    <div class="footer" style="display: none;">
        <jsp:include page="/footer.jsp" />
    </div>
    <!-- FOOTER -->

    <script type="text/javascript">
        function fncGetList(currentPage) {
            document.getElementById('currentPage').value = currentPage;
            document.detailForm.submit();
        }
        
        function fncGetUser(userId) {
            window.location.href = "/user/getUser?userId=" + userId;
        }
    </script>
</body>
</html>