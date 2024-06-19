<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UpdateQuest</title>
<style>
/* h1 요소에 앞 여백 추가 */
.custom-title-space {
	padding-left: 20px; /* 20px의 왼쪽 여백을 설정 */
}
</style>
</head>
<body>
	<jsp:include page="/header.jsp" flush="true" />
	<jsp:include page="/side.jsp" />
	<div class="main-panel">
		<div class="content-wrapper">
			<form action="/quest/updateQuest" method="POST">
				<div class="row mt-5">
					<div class="col-lg-6 grid-margin stretch-card mx-auto">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">퀘스트 수정</h4>
								<p class="card-description">Basic form elements</p>
								<div class="form-group">
									<label for="questContents">Quest Contents ( 퀘스트 내용)</label>
										<input type="text" class="form-control" name="questContents" value="${quest.questContents}">
								</div>
								<div class="form-group">
									<label for="questTarget">Quest Target ( 퀘스트 목표 )</label>
										<input type="text" class="form-control" name="questTarget" value="${quest.questTarget}">
								</div>
								<div class="form-group">
									<label for="questReward">Quest Reward ( 퀘스트 보상 )</label>
										<input type="text" class="form-control" name="questReward" value="${quest.questReward}">
								</div>
								<div class="form-group">
									<label for="questState">Quest Count ( 퀘스트 목표치)</label>
										<input type="text" class="form-control" name="questState" value="${quest.questTargetCnt}">
								</div>
									<button type="submit" class="btn btn-primary mr-2">수정완료</button>
									<button class="btn btn-light">Cancel</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	<!-- FOOTER -->
</body>
</html>