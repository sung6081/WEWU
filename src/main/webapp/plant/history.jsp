<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/* input 필드의 너비를 조정 */
.input-small {
	width: 40px;
}

.sort-links {
    text-align: right;
    margin-bottom: 10px;
}

.card {
    margin-top: 20px;
}

.card-title {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
}

.card-description {
    font-size: 16px;
    margin-bottom: 10px;
    text-align: center;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    function updatePlantList(sortType) {
        var searchCondition = $("#searchCondition").val();
        $.ajax({
            url: "/app/plant/history",
            type: "GET",
            data: { 
                searchCondition: searchCondition,
                searchKeyword: sortType 
            },
            dataType: "json", // 응답이 JSON 형식임을 명시
            success: function(response) {
                console.log(response); // 응답 확인을 위한 로그
                var plantList = $("#plantList");
                plantList.empty(); // 기존 내용을 비웁니다.

                // 서버에서 받은 데이터를 사용하여 동적으로 HTML을 생성합니다.
                $.each(response, function(index, myPlant) {
                    if (myPlant.myPlantState === 'N') {
                        var row = "<tr class='myPlantlist'>" +
                            "<td>" + myPlant.myPlantName + "</td>" +
                            "<td>" + myPlant.plantStartDate + " ~ " + myPlant.plantEndDate + "</td>" +
                            "<td>" + myPlant.myPlantExp + "</td>" +
                            "<td>" + myPlant.plantLevlNoList + "</td>" +
                            "</tr>";
                        plantList.append(row);
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error); // 오류 로그
                alert("식물 데이터를 가져오는 중 오류가 발생했습니다.");
            }
        });
    }
    $("#latest").on("click", function() {
        updatePlantList("latest");
    });
    
    $("#oldest").on("click", function() {
        updatePlantList("oldest");
    });
    
    $("#highestExp").on("click", function() {
        updatePlantList("highest");
    });
    
    $("#lowestExp").on("click", function() {
        updatePlantList("lowest");
    });
});
</script>
</head>
<body>
    <!-- HEADER -->
    <jsp:include page="/header.jsp" />
    <!-- HEADER -->
    <input type="hidden" id="searchCondition" value="past" />
    <form name = "history">
        <!-- GetMyPlant -->
        <div class="main-panel">
            <div class="content-wrapper">
                <jsp:include page="/plant/plantNavi.jsp" />
                <br><br><br>
                <div class="row mt-1">
                    <div class="col-lg-10 grid-margin stretch-card mx-auto">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">HISTORY</h4>
                                <p class="card-description">과거의 나의 식물들</p>   
                                <p class="sort-links">                                
                                    <button type="button" class="btn btn-primary btn-sm" id="latest">최신순</button>                           
                                    <button type="button" class="btn btn-primary btn-sm" id="oldest">과거순</button>                                    
                                    <button type="button" class="btn btn-primary btn-sm" id="highestExp">경험치높은순</button>                                   
                                    <button type="button" class="btn btn-primary btn-sm" id="lowestExp">경험치낮은순</button>
                                </p>
                                <div class="table-container">
                                    <table class="table table-striped">
                                        <tbody id="plantList">
                                            <c:forEach var="myPlant" items="${list}" varStatus="status">
                                                <c:if test="${myPlant.myPlantState eq 'N'}">
                                                <tr class="myPlantlist">
                                                    <td>${myPlant.myPlantName}</td>
                                                    <td>${myPlant.plantStartDate} ~ ${myPlant.plantEndDate}</td>
                                                    <td>${myPlant.myPlantExp}</td>
                                                    <td>단계이미지</td>
                                                </tr>
                                                </c:if>
                                            </c:forEach>
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
    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
</body>
</html>