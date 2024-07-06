<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8">
      <!-- HEADER -->
      <jsp:include page="/header.jsp" />
      <!-- HEADER -->
      <style>
        .container-flex {
          display: flex;
          /* Flexbox를 활용 */
          justify-content: center;
          /* 가로 방향으로 중앙 정렬 */
          align-items: center;
          /* 세로 방향으로 중앙 정렬 */
        }

        .image-container {
          margin-right: 100px;
          /* 이미지와 표 사이에 여백 추가 */
        }

      </style>
      <script>
      $(document).ready(function() {
          $(".edit").on("click", function() {
            var currentPlantName = $("#myPlantName").text();
            var inputField = '<input type="text" class="form-control form-control-sm w-60 plantNameInput" value="' + currentPlantName + '" />';
            $("#myPlantName").html(inputField);
            $(".edit").hide();
            $(".save").show();
          });

          $(".save").on("click", function() {
            var updatedPlantName = $(".plantNameInput").val();
            var plantLevlNo = $(".plantLevlNo").val();
            $.ajax({
              url: "/plant/updatePlant",
              type: "GET",
              data: { plantName: updatedPlantName, plantLevlNo: plantLevlNo },
              success: function(response) {
                $("#myPlantName").text(updatedPlantName);
                $(".save").hide();
                $(".edit").show();
              },
              error: function() {
                alert("식물 이름을 업데이트하는 중 오류가 발생했습니다.");
              }
            });
          });

          $(".delete").on("click", function() {
            var plantNo = $(".plantNo").val();
            var myPlantNo = $(".myPlantNo").val();
            $.ajax({
              url: "/app/plant/deleteMyPlant",
              type: "POST",
              contentType: "application/json",
              data: JSON.stringify({ 
            	  
            	  plantNo: plantNo,
            	  myPlantNo : myPlantNo
            	  }),
              success: function(response) {
                alert("식물 삭제 성공.");
                location.reload(); // 페이지를 새로고침하여 삭제된 식물 정보를 반영합니다.
              },
              error: function() {
                alert("식물 삭제 실패.");
              }
            });
          });
          $(".goToPlantSelect").on("click", function () {
              window.location.href = "/plant/randomPlantModal.jsp"; // 이동할 페이지의 경로를 설정
            });
        });
      </script>
    </head>

    <body> 

      <div class="main-panel">
        <div class="content-wrapper">
          <!-- NAVI -->
          <form name="getMyPlant" action="/plant/getMyPlant">
            <jsp:include page="/plant/plantNavi.jsp" />
            <input type="hidden" class="plantLevlNo" id="plantLevlNo" name="plantLevlNo" value="${myPlant.plantLevl.plantLevlNo}">
            <input type="hidden" class="plantNo" name="plantNo" value="${myPlant.plant.plantNo}">
            <input type="hidden" class="myPlantNo" name="myPlantNo" value="${myPlant.myPlantNo}">
              <div class="container mt-4">
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
                                <td class="myPlantName" id="myPlantName">${myPlant.myPlantName}</td>
                                <td>
                                  <div class="editable" id="editable-text">
                                    <button type="button" class="btn btn-outline-success btn-sm edit">수정</button>
                                    <button type="button" class="btn btn-outline-success btn-sm save" style="display:none;">저장</button>
                                  </div>
                                </td>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td>현재단계</td>
                                <td>${myPlant.plantLevl.plantLevl}&nbsp;(최종단계:${myPlant.plantLevl.plantFinalLevl})</td>
                                <td colspan="2"></td>
                              </tr>
                              <tr>
                                <td>변화형태</td>
                                <td><img src="${myPlant.plantLevl.levlImg}"></td>
                                <td colspan="2"></td>
                              </tr>
                              <tr>
                                <td>현재경험치</td>
                                <td>${myPlant.myPlantExp}</td>
                                <td colspan="2"></td>
                              </tr>
                              <tr>
                                <td colspan="2"></td>
                                <td class="text-right">
                                  <button type="button" class="btn btn-success btn-sm delete">삭제</button>
                                </td>
                                <!--<c:if test="${myPlant.myPlantExp >= 100}">
                                  <td class="text-right">
                                     <button type="button" class="btn btn-success btn-sm donate">식물저장(기부)</button> 
                                  </td>
                                </c:if>-->
                              </tr>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

          </form>
          <!-- 식물 없을때 랜덤 뽑기로 이동 -->
        </div>
      </div>
      <!-- FOOTER -->
      <jsp:include page="/footer.jsp" />
      <!-- FOOTER -->

    </body>

    </html>