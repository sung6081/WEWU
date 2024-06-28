<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->
<style>
/* h1 요소에 앞 여백 추가 */
.custom-title-space {
	padding-left: 20px; /* 20px의 왼쪽 여백을 설정 */
}

</style>
</head>
<body>
	<script>
	$(function(){
	    $("button[name='cancel']").on("click", function(){
	        $("form")[0].reset();
	    });

	    $("input[name='submit']").on("click", function(){
	        alert("등록하시겠습니까?");
	        // 폼 제출을 수행합니다.
	    });
	});
	</script>
	
	<jsp:include page="/plant/plantSide.jsp" />
	<div class="main-panel">
		<div class="content-wrapper">
			<form name="addQuest" method="post" action="/plant/addQuest">
				<div class="row mt-5">
					<div class="col-lg-6 grid-margin stretch-card mx-auto">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">퀘스트 등록</h4>
								<p class="card-description">Basic form elements</p>
								<div class="form-group">
									<label for="questContents">Quest Contents ( 퀘스트 내용)</label>
										<input type="text" class="form-control" name="questContents" id="questContents" placeholder="questContents">
								</div>
								<div class="form-group">
									<label for="questTarget">Quest Target ( 퀘스트 목표 )</label>
										<input type="text" class="form-control" name="questTarget" id="questTarget" placeholder="questTarget">
								</div>
								<div class="form-group">
									<label for="questReward">Quest Reward ( 퀘스트 보상 )</label>
										<input type="number" class="form-control" name="questReward" id="questReward" placeholder="questReward">
								</div>
								<div class="form-group">
									<label for="questState">Quest Count ( 퀘스트 목표치)</label>
										<input type="text" class="form-control" name="questState" id="questState" placeholder="questState">
								</div>
									<input type="submit" class="btn btn-primary mr-2" name="submit" value="등록">
           							 <button type = "button" class="btn btn-white" name="cancel">취소</button>
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