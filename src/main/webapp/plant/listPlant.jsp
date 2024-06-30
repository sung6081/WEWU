<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->
  
  <style>
    .table-container {
    display: block;
      max-height: 600px; /* 원하는 높이 설정 */
      overflow-y: auto;
    }
    
    .table-container::-webkit-scrollbar {
      width: 12px;  /* 스크롤바의 너비 */
    }
    .table-container::-webkit-scrollbar-thumb {
      height: 30%; /* 스크롤바의 길이 */
      background: #4B49AC; /* 스크롤바의 색상 */
      border-radius: 10px;
    }
    .table-container::-webkit-scrollbar-track {
      background: rgba(33, 122, 244, .1);  /*스크롤바 뒷 배경 색상*/
    }

  </style>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
  $(document).ready(function() {
      // 수정 버튼 클릭 시
      $(".badge-success").on("click", function() {
        var plantLevlNo = $(this).data("plantlevlno");
        var plantNo = $(this).data("plantno");
        window.location.href = "/plant/updatePlant?plantLevlNo=" + plantLevlNo;
      });

      // 삭제 버튼 클릭 시
      $(".badge-warning").on("click", function() {
        if (confirm("정말로 삭제하시겠습니까?")) {
          var plantNo = $(this).data("plantno");
          $.ajax({
            url: "/app/plant/deletePlant",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ plantNo: plantNo }),
            success: function(response) {
              alert("삭제가 완료되었습니다.");
              location.reload(); // 페이지를 새로고침하여 변경 사항을 반영합니다.
            },
            error: function(xhr, status, error) {
              alert("삭제 중 오류가 발생했습니다.");
            }
          });
        }
      });
    });
  </script>
  <style>
.jumbotron{
margin: 0 !important; /* 기본 마진 제거 */
background-color: #00A06C;
}
.display-4 {
  color: #fff; /* 원하는 색상으로 변경 */
}
</style>
</head>
<body>
  <jsp:include page="/plant/plantSide.jsp" />
  <div class="main-panel">
  <div class="jumbotron">
  <div class="container">
    <p class="display-4"><b>LIST PLANT</b></p>
  </div>
</div>
    <div class="content-wrapper">
      <div class="row">
        <div class="col-lg-11 grid-margin stretch-card mx-auto">
          <div class="card">
            <div class="card-body">
              
              <div class="table-container">
                <table class="table table-striped">
                  <thead>
                    <tr>
                    <th>PlantLevlNo</th>
                      <th>Plant Name</th>
                      <th>Plant Level</th>
                      <th>Plant Max Exp</th>
                      <th>Plant Min Exp</th>
                      <th>Plant Final Level</th>
                      <th>Plant Image</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="plant" items="${list}" varStatus="status">
                      <tr>
                      <td>${plant.plantLevl.plantLevlNo}</td>
                        <td>${plant.plantName}</td>
                        <td>${plant.plantLevl.plantLevl}</td>
                        <td>${plant.plantLevl.plantMaxExp}</td>
                        <td>${plant.plantLevl.plantMinExp}</td>
                        <td>${plant.plantLevl.plantFinalLevl}</td>
                        <td>${plant.plantLevl.levlImg}</td>
                        <td>
                          <div style="display: flex; flex-direction: column;">
						    <a type="button" class="badge badge-success" data-plantlevlno="${plant.plantLevl.plantLevlNo}" data-plantno="${plant.plantNo}">수정</a>
						  </div>
						  <div style="display: flex; flex-direction: column;">
						    <a type="button" class="badge badge-warning" data-plantlevlno="${plant.plantLevl.plantLevlNo}" data-plantno="${plant.plantNo}">삭제</a>
						  </div>
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
 
  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->
</body>
</html>
