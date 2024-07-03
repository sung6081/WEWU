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

<script>
$(document).ready(function() {
    function updatePlantList(sortType, plantLevlNo) {
        var searchCondition = $(".searchCondition").val();
        $.ajax({
            url: "/app/plant/history",
            type: "GET",
            data: { 
                searchCondition: searchCondition,
                searchKeyword: sortType,
                plantLevlNo: plantLevlNo // plantLevlNo 추가
            },
            dataType: "json",
            success: function(response) {
                console.log("Response received:", response);
                var plantList = $(".plantList");
                plantList.empty(); 
                
                $.each(response, function(index, myPlant) {
                    console.log("Processing plant:", myPlant);
                    if (myPlant.myPlantState === 'N') {
                        var plantLevlNo = myPlant.plantLevl ? myPlant.plantLevl.plantLevlNo : ''; // Null 체크 추가
                        var row = "<tr class='myPlantlist'>" +
                            "<td>" + myPlant.myPlantName + "</td>" +
                            "<td>" + myPlant.plantStartDate + " ~ " + myPlant.plantEndDate + "</td>" +
                            "<td>" + myPlant.myPlantExp + "</td>" +
                            "<td class='levlImg' data-plant-levl-no='" + plantLevlNo + "'>단계별 이미지</td>" +
                            "</tr>";
                        console.log("Appending row:", row);
                        plantList.append(row);
                    }
                });
                LevlImgClickEvent();
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
                alert("식물 데이터를 가져오는 중 오류가 발생했습니다.");
            }
        });
    }

    $(".latest").on("click", function() {
        var plantLevlNo = getPlantLevlNo(); // plantLevlNo 값 가져오기
        updatePlantList("latest", plantLevlNo);
    });
    
    $(".oldest").on("click", function() {
        var plantLevlNo = getPlantLevlNo(); // plantLevlNo 값 가져오기
        updatePlantList("oldest", plantLevlNo);
    });
    
    $(".highestExp").on("click", function() {
        var plantLevlNo = getPlantLevlNo(); // plantLevlNo 값 가져오기
        updatePlantList("highest", plantLevlNo);
    });
    
    $(".lowestExp").on("click", function() {
        var plantLevlNo = getPlantLevlNo(); // plantLevlNo 값 가져오기
        updatePlantList("lowest", plantLevlNo);
    });
    
    function LevlImgClickEvent() {
        $(".levlImg").on("click", function() {
            var $this = $(this);
            var plantLevlNo = $this.data("plant-levl-no");
            var $parentRow = $this.closest("tr");
            var $nextRow = $parentRow.next(".levlImgRow");
            var searchCondition = $(".searchCondition").val();
            
            alert('${myPlant.plantLevl.plantLevlNo}');

            if ($nextRow.length > 0) {
                $nextRow.remove();
                return;
            }

            if (!plantLevlNo) { // plantLevlNo가 없으면 요청하지 않음
                console.error("plantLevlNo is missing");
                return;
            }
            
            console.log("Sending AJAX request with plantLevlNo:", plantLevlNo, "and searchCondition:", searchCondition);

            $.ajax({
                url: "/app/plant/myPlantListbyLevlNo",
                method: "GET",
                data: { 
                    plantLevlNo: plantLevlNo,
                    searchCondition: searchCondition 
                },
                dataType: "json",
                success: function(response) {
                    console.log(response); 
                    var displayValue = "<tr class='levlImgRow'><td colspan='4' class='image-container'>";
                    $.each(response, function(index, plantLevl) {
                        if (index > 0) {
                            displayValue += "<span class='arrow'>&gt;</span>";
                        }
                        displayValue += "<img src='" + plantLevl.levlImg + "' alt='Plant Level Image' class='level-image' />";
                    });
                    displayValue += "</td></tr>";

                    $parentRow.after(displayValue);
                },
                error: function(xhr, status, error) {
                    console.error("Error: " + error);
                    alert("이미지 데이터를 가져오는 중 오류가 발생했습니다.");
                }
            });
        });
    }
 

    function getPlantLevlNo() {
        // plantLevlNo를 가져오는 로직을 여기에 구현합니다.
        // 예를 들어, 특정 선택자에서 값을 가져온다면:
        return $(".someSelector").data("plant-levl-no") || null;
    }

    LevlImgClickEvent();
});
</script>
</head>
<body>
    <form name="history">
        <input type="hidden" class="searchCondition" value="past" />
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
                                    <button type="button" class="btn btn-primary btn-sm latest" name="latest">최신순</button>                           
                                    <button type="button" class="btn btn-primary btn-sm oldest" name="oldest">과거순</button>                                    
                                    <button type="button" class="btn btn-primary btn-sm highestExp" name="highestExp">경험치높은순</button>                                   
                                    <button type="button" class="btn btn-primary btn-sm lowestExp" name="lowestExp">경험치낮은순</button>
                                </p>
                                <div class="table-container">
                                    <table class="table table-striped">
                                        <tbody class="plantList">
                                            <c:forEach var="myPlant" items="${list}" varStatus="status">
                                                <c:if test="${myPlant.myPlantState eq 'N'}">
                                                <tr class="myPlantlist">
                                                    <td>${myPlant.myPlantName}</td>
                                                    <td>${myPlant.plantStartDate} ~ ${myPlant.plantEndDate}</td>
                                                    <td>${myPlant.myPlantExp}</td>
                                                    <td class="levlImg" data-plant-levl-no="${myPlant.plantLevl.plantLevlNo}">단계별 이미지</td>
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