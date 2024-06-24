<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8">
     <style>
    /* input 필드의 너비를 조정 */
    .input-small {
      width: 40px;
    }
  </style>
  </head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $(".use-item-btn").click(function() {
        var itemPurNo = $(this).data("itempurno");
        var useItemNum = $("#useItemNum_" + itemPurNo).val();
        var nickname = $("input[name='nickname']").val();
        var myPlantNo = $("input[name='myPlantNo']").val();

        $.ajax({
            type: "POST",
            url: "/plant/getUseItem",
            contentType: "application/json",
            data: JSON.stringify({
                itemPurNo: itemPurNo,
                useItemNum: useItemNum,
                nickname: nickname,
                myPlantNo: myPlantNo
            }),
            success: function(response) {
                // 서버로부터 응답이 성공적으로 왔을 때 처리
                alert("아이템을 성공적으로 사용했습니다.");
                // 페이지를 새로고침하거나 필요한 업데이트를 수행
                location.reload();
            },
            error: function(error) {
                // 서버로부터 응답이 실패했을 때 처리
                alert("아이템 사용에 실패했습니다.");
            }
        });
    });
});
</script>
  <body>
    <!-- HEADER -->
    <jsp:include page="/header.jsp" />
    <!-- HEADER -->
    <form action="/plant/inventory" method="GET">
        <!-- GetMyPlant -->
        <div class="main-panel">
            <div class="content-wrapper">
                <!-- NAVI -->
                <jsp:include page="/plant/plantNavi.jsp" />
                <br><br><br>
                <div class="container text-center">
                    <div class="row justify-content-center mt-5">
                        <div class="col-lg-10 grid-margin stretch-card">
                            <div class="card mx-auto">
                                <div class="card-body">
                                    <div id="levlImgContainer">
                                        <img src="https://via.placeholder.com/200x200">
                                    </div>
                                    <input type="hidden" name="nickname" value="${user.nickname}" />
                                    <input type="hidden" name="myPlantNo" value="${myPlant.myPlantNo}" />
                                    <input type="hidden" name="itemPurNo" value="${inventory.itemPurNo}" />
                                    <div id="myPlantExp">${myPlant.myPlantExp} / ${inventory.itemNum}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container text-center">
                    <div class="row justify-content-center mt-5">
                        <div class="col-lg-10 grid-margin stretch-card">
                            <div class="card mx-auto">
                                <div class="card-body">
                                    <h4 class="card-title">Hoverable Table</h4>
                                    <p class="card-description">
                                        Add class <code>.table-hover</code>
                                    </p>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>종류</th>
                                                    <th>효과</th>
                                                    <th>수량</th>
                                                    <th>사용하기</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="inventory" items="${list}">
                                                    <tr>
                                                        <td>${inventory.itemType}</td>
                                                        <td>${inventory.itemExp}</td>
                                                        <td>${inventory.itemNum}</td>
                                                        <td>
                                                            <input type="number" class="form-control" name="useItemNum">
                                                        </td>
                                                        <td>
                                                            <button type="button" class="btn btn-outline-warning btn-fw" id="useItem">사용</button>
                                                        </td>
                                                    </tr>
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
        </div>
    </form>
    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
  </body>

  </html>