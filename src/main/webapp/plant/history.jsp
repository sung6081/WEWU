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

.arrow {
    margin: 0 10px;  // 화살표 양쪽에 마진 추가
    color: #333;  // 화살표 색상 설정
    font-size: 24px;  // 화살표 크기 설정
}
.table td img {
    width: 100px;  /* 이미지의 너비를 150픽셀로 설정 */
    height: auto;  /* 높이는 자동으로 설정하여 비율 유지 */
}
</style>

<script>
$(document).ready(function() {

    
    function updatePlantList(sortType) {
        var searchCondition = $(".searchCondition").val();
        $.ajax({
            url: "/app/plant/history",
            type: "GET",
            data: { 
                searchCondition: searchCondition,
                searchKeyword: sortType
            },
            dataType: "json",
            success: function(response) {
                var plantList = $(".plantList");
                plantList.empty(); 
                $.each(response, function(index, myPlant) {
                    if (myPlant.myPlantState === 'N') {
                        var row = "<tr class='myPlantlist'>" +
                            "<td>" + myPlant.myPlantName + "</td>" +
                            "<td>" + myPlant.plantStartDate + "</td>" +
                            "<td>" + myPlant.plantEndDate + "</td>" +
                            "<td>" + myPlant.myPlantExp + "</td>" +
                            "<td class='levlImg'>"+
                            "<input type='hidden' class='myPlantNo' value='" + myPlant.myPlantNo + "' />단계별 이미지</td>" +
                            "</tr>";
                        plantList.append(row);
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
                alert("식물 데이터를 가져오는 중 오류가 발생했습니다.");
            }
        });
    }

    // 기타 정렬 버튼 이벤트 핸들러
    $(".latest, .oldest, .highest, .lowest").on("click", function() {
        var sortType = $(this).attr("name");
        updatePlantList(sortType);
    });
    
	$(".table-container").on("click", ".levlImg", function() {
        // 히든 필드에서 plantNo 값을 읽음
        var myPlantNo = $(this).find(".myPlantNo").val();
        var currentRow = $(this).closest("tr");
        var imageRow = currentRow.next(".imageRow"); // 이미지 행을 선택

        if (imageRow.length > 0) {
            imageRow.remove();
        } else {
            // AJAX 요청으로 이미지를 가져오기
            $.ajax({
                url: "/app/plant/myPlantListbyPlantNo",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                	myPlantNo: myPlantNo 
                }),
                dataType: "json",
                success: function(response) {
                    console.log(response); // 전체 응답 로그 출력
                    var imgs = '';
                    for (var i = 0; i < response.length; i++) {
                        imgs += '<img src="' + response[i].plantLevl.levlImg + '" alt="Plant Image"/>';
                        if (i < response.length - 1) {  // 마지막 이미지가 아니라면, 화살표를 추가
                            imgs += ' <span class="arrow">></span> ';
                        }
                    }
                    var imgRow = '<tr class="imageRow"><td colspan="5">' + imgs + '</td></tr>';
                    $(imgRow).insertAfter(currentRow);
                },
                error: function(xhr, status, error) {
                    console.error("Error: " + error);
                    alert("오류가 발생했습니다.");
                }
            });
        }
    });

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
                                    <button type="button" class="btn btn-primary btn-sm highest" name="highest">경험치높은순</button>                                   
                                    <button type="button" class="btn btn-primary btn-sm lowest" name="lowest">경험치낮은순</button>
                                </p>
                                <div class="table-container">
                                    <table class="table table-striped">
                                        
                                        <thead>
                                        <tr>
                                                	<td>이름</td>
                                                	<td>시작날짜</td>
                                                	<td>종료날짜</td>
                                                	<td>경험치</td>
                                                	<td>단계별이미지</td>
                                                </tr>
                                                </thead>
                                                <tbody class="plantList">
                                            <c:forEach var="myPlant" items="${myPlantList}" varStatus="status">
                                                <c:if test="${myPlant.myPlantState eq 'N'}">
                                                <tr class="myPlantlist">
                                                    <td>${myPlant.myPlantName}</td>
                                                    <td>${myPlant.plantStartDate}</td>
                                                    <td>${myPlant.plantEndDate}</td>
                                                    <td>${myPlant.myPlantExp}</td>
                                                    <td class="levlImg">
                                                    <input type="hidden" class="myPlantNo" value="${myPlant.myPlantNo}" />
                                                    단계별 이미지
                                                    </td>
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