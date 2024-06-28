<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<style>
        .container-flex {
            display: flex; /* Flexbox를 활용 */
            justify-content: center; /* 가로 방향으로 중앙 정렬 */
            align-items: center; /* 세로 방향으로 중앙 정렬 */
        }
        .image-container {
            margin-right: 100px; /* 이미지와 표 사이에 여백 추가 */
            
        }
        
        
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script>
$(document).ready(function() {
    $("#edit").on("click", function() {
        var currentPlantName = $("#myPlantName").text();
        var inputField = '<input type="text" class="form-control form-control-sm w-50" id="plantNameInput" value="' + currentPlantName + '" />';
        $("#myPlantName").html(inputField);
        $("#edit").hide();
        $("#save").show();
    });

    $("#save").on("click", function() {
        var updatedPlantName = $("#plantNameInput").val();
        var plantLevlNo = $("#plantLevlNo").val();
        $.ajax({
            url: "/plant/updatePlant",
            type: "GET",
            data: { plantName: updatedPlantName ,plantLevlNo:plantLevlNo },
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
    
    $("#delete").on("click", function() {
        var plantNo = $("#plantNo").val();
        $.ajax({
            url: "/app/plant/deleteMyPlant",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ plantNo: plantNo }),
            success: function(response) {
            	alert("식물 삭제 성공.")
            },
            error: function() {
                alert("식물 삭제 실패.");
            }
        });
    });
});
</script>
<body>

	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->
	<form name = "getMyPlant" action = "/plant/getMyPlant">
	<input type="hidden" name="plantLevlNo" id="plantLevlNo" value="${myPlant.plantLevl.plantLevlNo}"/>
		<!-- GetMyPlant -->
		<div class="main-panel">
			<div class="content-wrapper">
				<!-- NAVI -->
				<jsp:include page="/plant/plantNavi.jsp" />
				<br> <br> <br>
				<!-- 식물 없을때 랜덤 뽑기로 이동 -->
				<div class="container">
					<div class="row">
						<div class="col-lg-10 grid-margin stretch-card mx-auto">
							<div class="card">
								<div class="card-body container-flex">
									<div class="image-container">
										<img src="${myPlant.plantLevl.levlImg}" width="200">
									</div>
									<div class="table-container">
											<table class="table table-hover">
												<thead>
													<tr>
														<td>나의 식물 이름</td>
														<td id="myPlantName">${myPlant.myPlantName}</td>
														<td>
															<div class="editable" id="editable-text">
																<button type="button" id="edit" class="btn btn-outline-success btn-sm">수정</button>
																<button type="button" id="save" class="btn btn-outline-success btn-sm" style="display:none;">저장</button>
															</div>
														</td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>현재단계</td>
														<td>${myPlant.plantLevl.plantLevl}</td>
														<td colspan="2"></td>
													</tr>
													<tr>
														<td>변화형태</td>
														<td><img src="${myPlant.plantLevl.levlImg}" ></td>
														<td colspan="2"></td>
													</tr>
													<tr>
														<td>현재경험치</td>
														<td>${myPlant.myPlantExp}</td>
														<td colspan="2"></td>
														
													</tr>
													<tr>
														<td colspan="2"></td>
														<td class="text-right"><button type="button" id="delete" class="btn btn-success btn-sm">삭제</button></td>
														<c:if test="${my_plant_exp} >= 100">
														<td class="text-right"><button type="button" id="delete" class="btn btn-success btn-sm">식물저장(기부)</button></td>
														</c:if>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 식물 없을때 랜덤 뽑기로 이동 -->
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