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
        var useItemNum = $("#userItemNum").val();
        var nickname = $("input[name='nickname']").val();
        var myPlantNo = $("input[name='myPlantNo']").val();
        var itemExp = $(".itemExp").val();
        var itemNum = $(".itemNum").val();
        var userItemNum = $("#userItemNum").val();
        
        //alert(userItemNum);
        

        if (!useItemNum || useItemNum <= 0) {
          alert("1개 이상 사용가능합니다.");
          return;
        }
        $.ajax({
          type: "POST",
          url: "/app/plant/useItem",
          contentType: "application/json",
          data: JSON.stringify({
        	  itemPurNo: itemPurNo,
        	  pageSize: parseInt(useItemNum),
        	  nickname: nickname,
        	  myPlantNo: parseInt(myPlantNo),
        	  itemExp: itemExp,
        	  itemNum: itemNum,
        	  useItemNum: useItemNum
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
    <c:if test="${status.index % 3 == 0}">
      <div class="row justify-content-center">
    </c:if>
    
    <div class="col-lg-4 grid-margin">
      <div class="card">
        <img class="card-img-top" src="${inventory.itemImg}" alt="Card image cap">
        <div class="card-body">
          <h5 class="card-title">Card title</h5>
          <p class="card-itemExp">사용 시 경험치가 +${inventory.itemExp}이 된다!</p>
          <input type="hidden" name="itemExp" class="itemExp" value="${inventory.itemExp}">
          <p class="card-itemNum">남은 수량 : ${inventory.itemNum}</p>
          <input type="hidden" name="itemNum" class="itemNum" value="${inventory.itemNum}">
          <div class="input-group">
            <input type="number" id="userItemNum" class="form-control" min="1">
            <div class="input-group-append">
              <button type="button" class="btn btn-outline-warning btn-fw use-item-btn btn-sm" data-itempurno="${inventory.itemPurNo}">사용</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <c:if test="${status.index % 3 == 2 || status.last}">
      </div>
    </c:if>
  </c:forEach>
</div>
  </form>
  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->
</body>

</html>