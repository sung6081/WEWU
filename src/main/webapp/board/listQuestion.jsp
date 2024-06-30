<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WEWU</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function() {

		//검색 event연결 처리부분
		//dom object get 3가지 방법: $(tagName)/(#id)/$(.className)
		//$("tagName.className:filter함수")사용함
		$("button:contains('검색')").on("click", function() {
			//alter($("td.ct_btn01:contains('검색')").html());
			//fncGetUserList(1);
		});

		$("td:nth-child(2)")
				.on(
						"click",
						function() {
							self.location = "/board/getQuestion?questionType=${param.questionType}"
									+ "&questionNo="
									+ $($(this).children()).val();

						});

		$(".ct_list_pop:nth-child(4n-6)").css("background-color", "whitesmoke");
		$('footer').removeClass('fixed-bottom');

		$(function() {
			$("button.btn.btn-outline-primary").on("click", function() {
				self.location = "/board/addQuestion?questionType=문의"
			});

		});
		$(function() {
			$("button.btn.btn-inverse-primary").on("click", function() {
				self.location = "/board/addQuestion?questionType=자주"
			});

		});

	});
	
	function fncQuestionList(page) {
        var form = $('form');
        form.method = 'GET';
        form.action = '/board/listQuestion';

        $('.currentPage').val(page);

        form.submit();
    }
</script>
<style type="text/css">
.jumbotron {
	margin: 0 !important; /* 기본 마진 제거 */
	background-color: #00A06C;
}
</style>
</head>
<body>
	<input type="hidden" name="questionType" value="${param.questionType}">

	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->

	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />


		<div class="main-panel mb-5">
			<div class="col-12 grid-margin stretch-card">

				<div class="card">
					<div class="card-body">
					<div class="jumbotron">
						<div class="container">
							<p class="display-4">
								<b><h3><c:if test="${param.questionType eq '자주'}"> 자주하는 질문 </c:if>
							<c:if test="${param.questionType eq '문의'}"> 1:1 문의  </c:if></h3></b>
							</p>
						</div>
					</div>
						<br>
						<br>
						<br>

						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>No</th>
										<th>제목</th>
										<th>닉네임</th>
										<th>등록일</th>
										<th><c:if test="${param.questionType eq '문의'}">답변 상태</c:if>
										</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="i" value="0" />
									<c:forEach var="question" items="${list}">
										<c:set var="i" value="${ i+1 }" />
										<tr>
											<td>${i}</td>
											<td>${question.title} <input type="hidden"
												value="${question.questionNo}">
											</td>
											<td>${question.nickName}</td>
											<td>${question.regDate}</td>
											<td><c:if test="${question.replyState eq '1'}">접수 완료</c:if>
												<c:if test="${question.replyState eq '3'}">답변 완료</c:if></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<%-- <div align="center">
                            <div class="btn-group" role="group" aria-label="Basic example">
                                <c:if test="${resultPage.currentPage > 1}">
                                    <button type="button" class="btn btn-outline-secondary" onclick="fncGetList(${resultPage.currentPage - 1})">&lt;</button>
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
                        </div> --%>
					
					<div class="card">
						<div class="card-body">

							<c:if
								test="${param.questionType eq '자주' && sessionScope.isAdmin}">
								<button type="button" class="btn btn-inverse-primary btn-fw">
									FAQ 등록</button>
							</c:if>
							<c:if test="${param.questionType eq '문의'}">
								<button type="button" class="btn btn-outline-primary btn-fw">
									1:1 문의하기</button>
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