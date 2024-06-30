<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <jsp:include page="/header.jsp" flush="true" />
  <script>
    $(document).ready(function () {

      sendAjaxRequest("/app/group/getGroupRankingList", "Ranking", "", "groupRanking");
    });


    function sendAjaxRequest(url, searchCondition, searchKeyword, targetElementId) {
      $.ajax({
        url: url,
        type: "POST",
        async: true,
        cache: true,
        timeout: 3000,
        data: JSON.stringify({
          searchCondition: searchCondition,
          searchKeyword: searchKeyword,
          pageSize: 0
        }),
        processData: true,
        contentType: "application/json",
        dataType: "json",
        beforeSend: function () {
          // AJAX 요청 전에 실행되는 함수
        },
        success: function (data, status, xhr) {
          // AJAX 요청 성공 시 실행되는 함수
          var str = "";

          for (var i = 0; i < data.length; i++) {
            str += "<div class='swiper-slide ranking'>" + data[i].groupName + "</div>";
          }

          $('.' + targetElementId).html(str);
        },
        error: function (xhr, status, error) {
          // AJAX 요청 실패 시 실행되는 함수
        },
        complete: function (xhr, status) {
          // AJAX 요청 완료 후 실행되는 함수
        }
      });
    }
  </script>
  <style>
    .card-body {
      backgrount-color: #FBFBFB;
    }

    .card-myPlant {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100%;
      text-align: center;
    }

    .jumbotron {
      position: relative;
      background: none;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-botton: 0;
      
    }

    .jumbotron img {
      width: 100%;
      height: auto;
    }

    .jumbotron-container {
      background-color: #FBFBFB;
      /* Change this to your desired background color */
      padding: 0;
      margin: 0;
      width: 100%;
    }

    .content-wrapper {
      background: #fff;
		padding:0;
    }
    
    
    
    
  </style>
</head>

<body>
  <!-- 퀘스트사이드바 -->

  <!-- 퀘스트사이드바 -->
  <!-- partial -->
  
  <div class="main-panel">
    <div class="jumbotron">
      <div class="container">
        <img src="/images/wewujumbo.jpg" alt="Background Image">
      </div>
    </div>
    <div class="content-wrapper">
          <div class="row">
            <div class="col-md-4">
              <div class="justify-content-end d-flex">
                <div class="swiper-container ranking">
                  <div class="swiper-wrapper groupRanking">
                  </div>
                </div>
              </div>
            </div>
          </div>
        
     
      <div class="container">
        <div class="row mx-auto">
          <div class="col-md-8 grid-margin stretch-card">
            <div class="container" style=" height: auto;">
              <div id="naverMap">
                <c:import url="/active/map"></c:import>
              </div>
            </div>
          </div>
          <div class="col-md-4 grid-margin stretch-card">
            <div class="container">
              <div class="card-myPlant">
               ${myPlant.myPlantExp}
                 ${myPlant.plantLevl.levlImg}
                 ${myPlant.plantLevl.plantLevl}
              </div>
            </div>
          </div>
        </div>
        <!-- swiper -->
        <div class="container">
          <div class="row mx-auto">
            <div class="col-lg-12 slide">
              <div class="swiper-container">
                <div class="swiper-wrapper">
                  <div class="swiper-slide">
                    <div class="card mb-4 shadow-sm">
                      <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                        alt="Placeholder: Thumbnail" />
                      <div class="card-body">
                        <p class="card-text">This is a wider card with supporting text below as a natural
                          lead-in to additional content. This content is a little bit longer.</p>
                        <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                          </div>
                          <small class="text-muted">9 mins</small>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="swiper-slide">
                    <div class="card mb-4 shadow-sm">
                      <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                        alt="Placeholder: Thumbnail" />
                      <div class="card-body">
                        <p class="card-text">This is a wider card with supporting text below as a natural
                          lead-in to additional content. This content is a little bit longer.</p>
                        <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                          </div>
                          <small class="text-muted">9 mins</small>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="swiper-slide">
                    <div class="card mb-4 shadow-sm">
                      <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                        alt="Placeholder: Thumbnail" />
                      <div class="card-body">
                        <p class="card-text">This is a wider card with supporting text below as a natural
                          lead-in to additional content. This content is a little bit longer.</p>
                        <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                          </div>
                          <small class="text-muted">9 mins</small>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="swiper-slide">
                    <div class="card mb-4 shadow-sm">
                      <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                        alt="Placeholder: Thumbnail" />
                      <div class="card-body">
                        <p class="card-text">This is a wider card with supporting text below as a natural
                          lead-in to additional content. This content is a little bit longer.</p>
                        <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                          </div>
                          <small class="text-muted">9 mins</small>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="custom-swiper-button-next">
                  <i class="fas fa-chevron-right custom-icon"></i>
                </div>
                <div class="custom-swiper-button-prev">
                  <i class="fas fa-chevron-left custom-icon"></i>
                </div>
              </div>
            </div>
            <br>
            <!-- 추가 슬라이드 -->
            <div class="container ">
              <div class="row ">
                <div class="col-lg-12 slide mb-5">
                  <div class="swiper-container ">
                    <div class="swiper-wrapper">
                      <div class="swiper-slide">
                        <div class="card mb-4 shadow-sm">
                          <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                            alt="Placeholder: Thumbnail" />
                          <div class="card-body">
                            <p class="card-text">This is a wider card with supporting text below as a natural
                              lead-in to additional content. This content is a little bit longer.</p>
                            <div class="d-flex justify-content-between align-items-center">
                              <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                              </div>
                              <small class="text-muted">9 mins</small>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="swiper-slide">
                        <div class="card mb-4 shadow-sm">
                          <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                            alt="Placeholder: Thumbnail" />
                          <div class="card-body">
                            <p class="card-text">This is a wider card with supporting text below as a natural
                              lead-in to additional content. This content is a little bit longer.</p>
                            <div class="d-flex justify-content-between align-items-center">
                              <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                              </div>
                              <small class="text-muted">9 mins</small>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="swiper-slide">
                        <div class="card mb-4 shadow-sm">
                          <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                            alt="Placeholder: Thumbnail" />
                          <div class="card-body">
                            <p class="card-text">This is a wider card with supporting text below as a natural
                              lead-in to additional content. This content is a little bit longer.</p>
                            <div class="d-flex justify-content-between align-items-center">
                              <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                              </div>
                              <small class="text-muted">9 mins</small>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="swiper-slide">
                        <div class="card mb-4 shadow-sm">
                          <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300"
                            alt="Placeholder: Thumbnail" />
                          <div class="card-body">
                            <p class="card-text">This is a wider card with supporting text below as a natural
                              lead-in to additional content. This content is a little bit longer.</p>
                            <div class="d-flex justify-content-between align-items-center">
                              <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                              </div>
                              <small class="text-muted">9 mins</small>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="custom-swiper-button-next">
                      <i class="fas fa-chevron-right custom-icon"></i>
                    </div>
                    <div class="custom-swiper-button-prev">
                      <i class="fas fa-chevron-left custom-icon"></i>
                    </div>
                  </div>
                </div>
              </div>
              <br>
              <!-- content-wrapper ends -->
              <!-- main-panel ends -->
            </div>
          </div>
        </div>
      </div>
      </div>
      <!-- footer.jsp -->
      <jsp:include page="footer.jsp" />
      <!-- footer.jsp -->
</body>

</html>