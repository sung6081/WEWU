<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script>
$(document).ready(function() {
    $("#edit").on("click", function() {
        var currentPlantName = $("#myPlantName").text();
        var inputField = '<input type="text" id="plantNameInput" value="' + currentPlantName + '" />';
        $("#myPlantName").html(inputField);
        $("#edit").hide();
        $("#save").show();
    });

    $("#save").on("click", function() {
        var updatedPlantName = $("#plantNameInput").val();
        $.ajax({
            url: "/plant/updatePlant",
            type: "GET",
            data: { plantName: updatedPlantName },
            success: function(response) {
                $("#myPlantName").text(updatedPlantName);
                $("#save").hide();
                $("#edit").show();
            },
            error: function() {
                alert("식물 이름을 업데이트하는 중 오류가 발생했습니다.");
            }
        });
    });
});
</script>
<body>

	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->
	<form action="/plant/getMyPlant" method="POST">
		<!-- GetMyPlant -->
		<div class="main-panel">
			<div class="content-wrapper">
				<!-- NAVI -->
				<jsp:include page="/plant/plantNavi.jsp" />
				<br> <br> <br>
				<!-- 식물 없을때 랜덤 뽑기로 이동 -->
				<div class="container">
					<div class="row mt-5">
						<div class="col-lg-5 grid-margin stretch-card ">
							<div class="card mr-4">
								<div class="card-body">
									<img src="">
								</div>
							</div>
						</div>
					</div>
					<!-- 식물 없을때 랜덤 뽑기로 이동 -->
					<!-- 식물 존재하면 뜨는 화면 -->
					<div class="container">
						<div class="row mt-5">
							<div class="col-lg-5 grid-margin stretch-card">
								<div class="card mr-4">
									<div class="card-body"></div>
								</div>
							</div>
							<div class="col-lg-7 grid-margin stretch-card">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">"${user.nickname}"님의 식물
											"${myPlant.myPlantName}"</h4>
										<p class="card-description"></p>
										<div class="table-container">
											<table class="table table-hover">
												<thead>
													<tr>
														<td>나의 식물 이름</td>
														<td id="myPlantName">${myPlant.myPlantName}</td>
														<td>
														<div class="editable" id="editable-text">
															    <div class="editable" id="editable-text">
															        <button type="button" id="edit" class="btn btn-outline-success btn-sm">수정</button>
															        <button type="button" id="save" class="btn btn-outline-success btn-sm" style="display:none;">저장</button>
															    </div>
															</div>
														</td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>현재단계</td>
														<td>${myPlant.myPlantLevl}</td>
													</tr>
													<tr>
														<td>변화형태</td>
													</tr>

													<tr>
														<td>이미지</td>
														<td></td>
													</tr>
													<tr>
														<td>현재까지모은경험치</td>
														<td>${myPlant.myPlantExp}</td>
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
			</div>
	</form>
	<!-- 식물 존재하면 뜨는 화면 -->
	<!-- FOOTER -->
	<jsp:include page="/footer.jsp" />
	<!-- FOOTER -->
</body>

</html>