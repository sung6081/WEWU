<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
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
        var useItemNum = $("#useItemNum_" + itemPurNo).val();
        var nickname = $("input[name='nickname']").val();
        var myPlantNo = $("input[name='myPlantNo']").val();

        if (!useItemNum || useItemNum <= 0) {
          alert("1개 이상 사용가능합니다.");
          return;
        }
        $.ajax({
          type: "POST",
          url: "/app/plant/useItem",
          contentType: "application/json",
          data: JSON.stringify({
            searchCondition: "itemPurNo",
            searchKeyword: itemPurNo.toString(),
            pageSize: parseInt(useItemNum),
            nickname: nickname,
            myPlantNo: parseInt(myPlantNo)
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
  <!-- HEADER -->
  <jsp:include page="/header.jsp" />
  <!-- HEADER -->
  <form>
    <c:forEach var="inventory" items="${list}">
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
                    <input type="hidden" name="nickname" value="" />
                    <input type="hidden" name="myPlantNo" value="" />
                    <div id="myPlantExp"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-3 grid-margin">
      <div class="card">
        <img class="card-img-top" src="http://via.placeholder.com/200x200" alt="Card image cap">
        <div class="card-body">
          <h5 class="card-title">Card title${inventory.itemImg}</h5>
          <p class="card-itemExp">사용 시 경험치가 +${inventory.itemExp}이 된다!</p>
          <p class="card-itemNum">남은 수량 : ${inventory.itemNum}</p>
       	    <div class="input-group">
             <input type="number" class="form-control"  min="1">
             	<div class="input-group-append">
               <button type="button" class="btn btn-outline-warning btn-fw use-item-btn btn-sm" data-itempurno="${inventory.itemPurNo}">사용</button>
             	</div>
            </div>
        </div>
      </div>
    </div>
    <div class="col-lg-3 grid-margin stretch-card">
      <div class="card">
        <img class="card-img-top" src="http://via.placeholder.com/200x200" alt="Card image cap">
        <div class="card-body">
          <h5 class="card-title">Card title${inventory.itemImg}</h5>
          <p class="card-itemExp">사용 시 경험치가 +${inventory.itemExp}이 된다!</p>
          <p class="card-itemNum">남은 수량 : ${inventory.itemNum}</p>
       	    <div class="input-group">
             <input type="number" class="form-control"  min="1">
             	<div class="input-group-append">
               <button type="button" class="btn btn-outline-warning btn-fw use-item-btn btn-sm" data-itempurno="${inventory.itemPurNo}">사용</button>
             	</div>
            </div>
        </div>
      </div>
    </div>
    <div class="col-lg-3 grid-margin stretch-card">
      <div class="card">
        <img class="card-img-top" src="http://via.placeholder.com/200x200" alt="Card image cap">
        <div class="card-body">
          <h5 class="card-title">Card title${inventory.itemImg}</h5>
          <p class="card-itemExp">사용 시 경험치가 +${inventory.itemExp}이 된다!</p>
          <p class="card-itemNum">남은 수량 : ${inventory.itemNum}</p>
       	    <div class="input-group">
             <input type="number" class="form-control"  min="1">
             	<div class="input-group-append">
               <button type="button" class="btn btn-outline-warning btn-fw use-item-btn btn-sm" 
               data-itempurno="${inventory.itemPurNo}">사용</button>
             	</div>
            </div>
            
        </div>
      </div>
    </div>
  </div>
</div>
        </div>
      </div>
    </c:forEach>
  </form>
  


  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->
</body>

</html>