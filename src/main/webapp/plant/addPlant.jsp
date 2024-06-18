<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>

	<jsp:include page="/header.jsp" flush="true" />
	<form action="/plant/addPlant" method="POST">
		<div class="main-panel">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-lg-6 grid-margin stretch-card mx-auto">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">식물 등록</h4>
								<div class="table-responsive">
									<table class="table">
										<tbody>
											<tr>
												<td>식물이름</td>
												<td>
												<input type="text" class="form-control form-control-lg" placeholder="Username" aria-label="Username">
												</td>
											</tr>
											<tr>
												<td>식물최소경험치</td>
												<td>53275532</td>
											</tr>
											<tr>
												<td>식물최대경험치</td>
												<td>53275533</td>	
											</tr>
											<tr>
												<td>식물최종단계</td>	
											</tr>
											<tr>
												<td>식물단계별이미지</td>
												<td>1단계</td>
												<td>
													<input type="text" class="form-control file-upload-info" disabled="" placeholder="Upload Image">
												</td>
											<tr>
												<td></td>
												<td>2단계</td>
												<td>
													<input type="text" class="form-control file-upload-info" disabled="" placeholder="Upload Image">
												</td>
											</tr>
											<tr>
												<td></td>
												<td>3단계</td>
												<td>
													<input type="text" class="form-control file-upload-info" disabled="" placeholder="Upload Image">
												</td>
											</tr>
											<tr>
												<td></td>
												<td>4단계</td>
												<td>
													<input type="text" class="form-control file-upload-info" disabled="" placeholder="Upload Image">
												</td>
											</tr>
											<tr>
												<td></td>
												<td>5단계</td>
												<td>
													<input type="text" class="form-control file-upload-info" disabled="" placeholder="Upload Image">
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>