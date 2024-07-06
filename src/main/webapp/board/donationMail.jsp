<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->

<style>
.jumbotron {
	background-color: #00A06C;
	margin-top: 160px;
	margin-bottom: 0;
	background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
	background-image: url('/images/beach.jpg'); /* 배경 이미지 경로 */
	background-size: cover; /* 이미지가 컨테이너를 덮도록 */
	background-position: center; /* 이미지가 중앙에 위치하도록 */
}

.sidebar-offcanvas {
	margin-top: 0px;
}

.main-panel {
	margin-top: 0px;
}

.container-fluid.page-body-wrapper {
	margin-top: 0px;
}

b {
	color: white;
}

.card-body{
	margin-top: 200px;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".btn-success")
				.on("click",function() {
							self.location = "/board/listBoard?boardType=4";
						});
	});
</script>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<p class="display-4">
				
			</p>
		</div>
	</div>
	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />

		<div class="main-panel">

			<div class="row">
				<div class="col-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body" align="center">
						
						<h2>${donation.userName }님 후원완료 되었습니다.</h2>
						<br>
						<p> 후원 내역은 메일로 발송되었습니다.</p>
						<br>
						<br>
						<button class="btn btn-success" type="button">확인</button>
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>