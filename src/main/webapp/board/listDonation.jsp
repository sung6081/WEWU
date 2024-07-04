<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
<style type="text/css">
.jumbotron {
	background-color: #00A06C;
	margin-top:160px;
	margin-bottom: 0;
	background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
	background-image: url('/images/beach.jpg'); /* 배경 이미지 경로 */
	background-size: cover; /* 이미지가 컨테이너를 덮도록 */
	background-position: center; /* 이미지가 중앙에 위치하도록 */
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
$(function() {

	//검색 event연결 처리부분
	//dom object get 3가지 방법: $(tagName)/(#id)/$(.className)
	//$("tagName.className:filter함수")사용함
	$("button:contains('검색')").on("click", function() {
		//alter($("td.ct_btn01:contains('검색')").html());
		//fncGetUserList(1);
	});

	$("td:nth-child(2)").on(
			"click",
			function() {
				self.location = "/board/getDonation?payType=B"
						+"&payNo="
						+ $($(this).children()).val();

	});

	$(".ct_list_pop:nth-child(4n-6)").css("background-color", "whitesmoke");

});
</script>

</head>
<body>
<input type="hidden" name="payType" value="${param.payType}" >
<div class="jumbotron">
						<div class="container">
							<p class="display-4">
								<b>후원 내역 보기</b>
							</p>
						</div>
						
					</div>	

	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />

		<div class="main-panel">
			<div class="col-12 grid-margin stretch-card">

				<div class="card">
					<div class="card-body">
						
					<br>
						<br>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>No</th>
										<th>이름</th>
										<th>이메일</th>
										<th>후원 날짜</th>
										<th>결제 수단</th>
										<th>금액</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="i" value="0" />
									<c:forEach var="donation" items="${list}">
										<c:set var="i" value="${ i+1 }" />
										<tr>
											<td>${i}</td>
											<td>${donation.userName} <input type="hidden"
												value="${donation.payNo}">
											</td>
											<td>${donation.email}</td>
											<td>${donation.payDate}</td>
											<td><c:if test="${donation.payOption eq 'P'}">카카오 페이</c:if></td>
											<td>${donation.payAmount}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
					</div>
					<div align="center">
                            <div class="btn-group" role="group" aria-label="Basic example">
                                <c:if test="${resultPage.currentPage > 1}">
                                    <button type="button" class="btn btn-outline-secondary" onclick="fncQuestionList(${resultPage.currentPage - 1})">&lt;</button>
                                </c:if>
                                <c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}">
                                    <c:choose>
                                        <c:when test="${i == resultPage.currentPage}">
                                            <button type="button" class="btn btn-primary">${i}</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-outline-secondary" onclick="fncQuestionList(${i})">${i}</button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
                                    <button type="button" class="btn btn-outline-secondary" onclick="fncQuestionList(${resultPage.currentPage + 1})">&gt;</button>
                                </c:if>
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