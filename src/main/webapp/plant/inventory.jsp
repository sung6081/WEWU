<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <!-- HEADER -->
  <jsp:include page="/header.jsp" />
  <!-- HEADER -->
  <style>
    .input-small {
      width: 40px;
    }
    .card {
      width: 150px; /* 카드의 너비 조정 */
      margin: 10px; /* 카드 간격 조정 */
    }
    .card-img-top {
      height: 130px; /* 이미지 높이 조정 */
    }
    .card-body {
      padding: 10px; /* 카드 내부 여백 조정 */
    }
    .pagination-container {
      margin-top: 20px; /* 페이지 네비게이션 상단 여백 */
      text-align: center; /* 중앙 정렬 */
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    function fncGetList(page) {
      var form = $('form#listSearchForm');
      form.find('.currentPage').val(page);
      form.attr("method", "GET").attr("action", "/plant/inventory").submit();      

      // 검색 후 텍스트 입력창 비우기
      form.find('input[name="searchKeyword"]').val('');
    }

    $(document).ready(function () {
      $(".use-item-btn").click(function () {
        var itemPurNo = $(this).data("itempurno");
        var nickname = $("input[name='nickname']").val();
        var myPlantNo = $("input[name='myPlantNo']").val();
        var itemExp = $(this).closest(".card-body").find(".itemExp").val();
        var itemNum = $(this).closest(".card-body").find(".itemNum").val();
        var itemType = $(this).closest(".card-body").find(".itemType").val();
        var itemName = $(this).closest(".card-body").find(".itemName").val();

        // 기본적으로 1개의 아이템을 사용하도록 설정합니다.
        var useItemNum = 1;

        $.ajax({
          type: "POST",
          url: "/app/plant/useItem",
          contentType: "application/json",
          data: JSON.stringify({
            itemPurNo: itemPurNo,
            pageSize: useItemNum,
            nickname: nickname,
            myPlantNo: parseInt(myPlantNo),
            itemExp: itemExp,
            itemNum: itemNum,
            itemType: itemType,
            itemName: itemName
          }),
          success: function (response) {
            alert("아이템을 성공적으로 사용했습니다.");
            location.reload();
          },
          error: function (error) {
            alert("아이템 사용에 실패했습니다.");
          }
        });
      });
    });
  </script>
</head>

<body>
  <form id="listSearchForm">
    <input type="hidden" name="nickname" value="${user.nickname}" />
    <input type="hidden" name="myPlantNo" value="${myPlant.myPlantNo}" />
    <input type="hidden" class="currentPage" name="currentPage" value="${resultPage.currentPage}" />
    <div class="main-panel">
      <div class="content-wrapper">
        <jsp:include page="/plant/plantNavi.jsp" />
        <br><br><br>
        <div class="container text-center">
          <div class="row justify-content-center">
            <div class="col-lg-6 grid-margin stretch-card">
              <div class="card mx-auto">
                <div class="card-body">
                  <div id="levlImgContainer">
                    <img src="${plantLevl.levlImg}" width="200">
                  </div>
                  <div>
                    현재경험치 : ${myPlant.myPlantExp}
                  </div>
                  <div id="myPlantExp"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="row justify-content-center">
            <c:forEach var="inventory" items="${list}" varStatus="status">
              <c:if test="${inventory.itemType eq 'Y'}">
                <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                  <div class="card">
                    <img class="card-img-top" src="${inventory.itemImg}" alt="Card image cap">
                    <div class="card-body">
                      <h5 class="card-title">${inventory.itemName}</h5>
                      <p class="card-itemExp">사용 시 경험치가 +${inventory.itemExp}이 된다!</p>
                      <input type="hidden" name="itemExp" class="itemExp" value="${inventory.itemExp}">
                      <input type="hidden" name="itemNum" class="itemNum" value="${inventory.itemNum}">
                      <input type="hidden" name="itemType" class="itemType" value="${inventory.itemType}">
                      <input type="hidden" name="itemName" class="itemName" value="${inventory.itemName}">
                      <div class="input-group">
                        <button type="button" class="btn btn-outline-warning btn-fw use-item-btn btn-sm" data-itempurno="${inventory.itemPurNo}">사용</button>
                      </div>
                    </div>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>
        </div>
        <div class="pagination-container">
          <div class="btn-group" role="group" aria-label="Basic example">
            <c:if test="${resultPage.currentPage > 1}">
              <button type="button" class="btn btn-outline-secondary" onclick="fncGetList(${resultPage.currentPage - 1})">&lt;</button>
            </c:if>
            <c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}">
              <c:choose>
                <c:when test="${i == resultPage.currentPage}">
                  <button type="button" class="btn btn-primary">${i}</button>
                </c:when>
                <c:otherwise>
                  <button type="button" class="btn btn-outline-secondary" onclick="fncGetList(${i})">${i}</button>
                </c:otherwise>
              </c:choose>
            </c:forEach>
            <c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
              <button type="button" class="btn btn-outline-secondary" onclick="fncGetList(${resultPage.currentPage + 1})">&gt;</button>
            </c:if>
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