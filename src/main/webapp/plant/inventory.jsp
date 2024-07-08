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
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function () {
      $(".use-item-btn").click(function () {
        var itemPurNo = $(this).data("itempurno");
        var nickname = $("input[name='nickname']").val();
        var myPlantNo = $("input[name='myPlantNo']").val();
        var itemExp = $(this).closest(".card-body").find(".itemExp").val();
        var itemNum = $(this).closest(".card-body").find(".itemNum").val();
        var itemType = $(this).closest(".card-body").find(".itemType").val(); // 아이템 타입 추가
        var itemName = $(this).closest(".card-body").find(".itemName").val(); // 아이템 이름 추가

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
  <form>
    <input type="hidden" name="nickname" value="${user.nickname}" />
    <input type="hidden" name="myPlantNo" value="${myPlant.myPlantNo}" />
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
        
          <c:forEach var="inventory" items="${list}" varStatus="status">
          <c:if test = "${inventory.itemType.toUpperCase() eq 'Y'}">
            <c:if test="${status.index % 5 == 0}">
              <div class="row justify-content-center">
            </c:if>
            
            <div class="col-lg-2 grid-margin">
              <div class="card">
                <img class="card-img-top" src="${inventory.itemImg}" alt="Card image cap">
                <div class="card-body">
                  <h5 class="card-title">${inventory.itemName}</h5>
                  <p class="card-itemExp">사용 시 경험치가 +${inventory.itemExp}이 된다!</p>
                  <input type="hidden" name="itemExp" class="itemExp" value="${inventory.itemExp}">
                  <p class="card-itemNum">남은 수량 : ${inventory.itemNum}</p>
                  <input type="hidden" name="itemNum" class="itemNum" value="${inventory.itemNum}">
                  <input type="hidden" name="itemType" class="itemType" value="${inventory.itemType}"> <!-- 아이템 타입 필드 추가 -->
                  <input type="hidden" name="itemName" class="itemName" value="${inventory.itemName}"> <!-- 아이템 이름 필드 추가 -->
                  <div class="input-group">
                    <button type="button" class="btn btn-outline-warning btn-fw use-item-btn btn-sm" data-itempurno="${inventory.itemPurNo}">사용</button>
                  </div>
                </div>
              </div>
            </div>
            
            <c:if test="${status.index % 5 == 4 || status.last}">
              </div>
            </c:if>
            </c:if>
          </c:forEach>
          
        </div>
      </div>
    </div>
  </form>
  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->
</body>

</html>