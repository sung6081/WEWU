<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
  </head>
  <body>
    <!-- HEADER -->
    <jsp:include page="/header.jsp" />
    <!-- HEADER -->
    <form action="/plant/getMyPlant" method="POST">
      <!-- GetMyPlant -->
      <div class="main-panel">
        <div class="content-wrapper">
          <!-- NAVI -->
          <div class="navibotton text-center">
            <button type="button" class="btn btn-warning btn-rounded btn-fw">나의식물</button>
            <button type="button" class="btn btn-danger btn-rounded btn-fw">인벤토리</button>
            <button type="button" class="btn btn-success btn-rounded btn-fw">HISTORY</button>
          </div>
          <br>
          <br>
          <br>
          <div class="container">
            <div class="row mt-5">
              <div class="col-lg-5 grid-margin stretch-card">
              
                <div class="card mr-4">
                  <div class="card-body"></div>
                </div>
              </div>
              <div class="col-lg-7 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">"${myPlant.nickname}"님의 식물 "${myPlant.myPlantName}"</h4>
                    <p class="card-description">
                    </p>
                    <div class="table-container">
                      <table class="table table-hover">
                        <thead>
                          <tr>
                            <td>나의 식물 이름</td>
                            <td>${myPlant.myPlantName}</td>
                            <td>
                              <button type="button" class="btn btn-outline-success btn-sm">수정</button>
                            </td>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>현재단계 </td>
                            <td>${myPlant.myPlantLevl}</td>
                          </tr>
                          <tr>
                            <td>변화형태</td>
                          </tr>

                          <tr>
                            <td>이미지</td>
                            <td>이미지</td>
                          </tr>
                          <tr>
                            <td>현재까지모은경험치</td>
                            <td>${myPlant.myPlantExp}</td>
                          </tr>
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
    		<!-- side.jsp -->
		</div>
		</div>
		<!-- side.jsp -->
    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
  </body>

  </html>