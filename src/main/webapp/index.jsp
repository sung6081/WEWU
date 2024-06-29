<%@ page contentType="text/html; charset=UTF-8" %>
  <%@ page pageEncoding="UTF-8" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
          <jsp:include page="/header.jsp" flush="true" />
          <!-- Swiper 4.5.1 CSS 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <!-- Font Awesome CDN 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
          <script>
          
          </script>
          <style>
          .card-body{
          	backgrount-color:#FBFBFB;
          }
          </style>
        </head>

        <body>
          <!-- partial -->
          <div class="main-panel">
            <div class="content-wrapper">
              <div class="row">
                <div class="col-md-12 grid-margin">
                  <div class="row">
                    <div class="col-12 col-xl-8 mb-4 mb-xl-0">
                      <h3 class="font-weight-bold">Welcome Aamir</h3>
                      <h6 class="font-weight-normal mb-0">
                        All systems are running smoothly! You have <span class="text-primary">3 unread
                          alerts!</span>
                      </h6>
                    </div>
                    <div class="col-md-4">
                      <div class="justify-content-end d-flex">
                        <div class="swiper-container ranking">
                          <div class="swiper-wrapper groupRanking">

                          </div>
                        </div>
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
                  <div class="card tale-bg">
                    <div class="card-people mt-auto">
                      <img src="images/dashboard/people.svg" alt="people">
                      <div class="weather-info">
                        <div class="d-flex">
                          <div>
                            <h2 class="mb-0 font-weight-normal">
                              <i class="icon-sun mr-2"></i>31<sup>C</sup>
                            </h2>
                          </div>
                          <div class="ml-2">
                            <h4 class="location font-weight-normal">Bangalore</h4>
                            <h6 class="font-weight-normal">India</h6>
                          </div>
                        </div>
                      </div>
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
                              <img class="bd-placeholder-img card-img-top"  src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
                              <img class="bd-placeholder-img card-img-top"  src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
                              <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
                              <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
                                <img class="bd-placeholder-img card-img-top"src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
                                <img class="bd-placeholder-img card-img-top" src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
                                <img class="bd-placeholder-img card-img-top"src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
                                <img class="bd-placeholder-img card-img-top"  src="https://via.placeholder.com/500x300" alt="Placeholder: Thumbnail" />
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
            <!-- footer.jsp -->
            <jsp:include page="footer.jsp" />
            <!-- footer.jsp -->
        </body>

        </html>