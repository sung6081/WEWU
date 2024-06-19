<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
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
			<form action="/plant/addPlant" method="POST">
				<div class="row mt-5">
					<div class="col-lg-6 grid-margin stretch-card mx-auto">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">식물 등록</h4>
								<p class="card-description">Basic form elements</p>
								<div class="form-group">
									<label for="questContents">식물이름</label>
										<input type="text" class="form-control" name="plantName" id="plantName" placeholder=plantName>
								</div>
								<div class="form-group">
									<label for="questTarget">최소경험치</label>
										<input type="text" class="form-control" name="plantMinExp" id="plantMinExp" placeholder="plantMinExp">
								</div>
								<div class="form-group">
									<label for="questReward">최대경험치</label>
										<input type="text" class="form-control" name="plantMaxExp" id="plantMaxExp" placeholder="plantMaxExp">
								</div>
								<div class="form-group">
									<label for="questState">식물단계</label>
										<input type="text" class="form-control" name="plantLevl" id="plantLevl" placeholder="plantLevl">
								</div>
								<div class="form-group">
									<label for="questState">식물최종단계</label>
										<input type="text" class="form-control" name="plantFinalLevl" id="plantFinalLevl" placeholder="plantFinalLevl">
								</div>
								<div class="form-group">
									<label>식물단계이미지</label> 
										<input type="file" name="levlImg" class="file-upload-default">
											<div class="input-group col-xs-12">
												<input type="text" class="form-control file-upload-info" disabled="" placeholder="levlImg"> 
													<span class="input-group-append">
														<button class="file-upload-browse btn btn-primary" type="button">Upload</button>
													</span>
											</div>
								</div>
									<button type="submit" class="btn btn-primary mr-2">Submit</button>
									<button class="btn btn-light">Cancel</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
			<!-- side.jsp -->
		</div>
		</div>
		<!-- side.jsp -->
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	<!-- FOOTER -->
</body>
</html>