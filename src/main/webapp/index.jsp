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
      
      $(document).ready(function() {
          fncMainBoardList();
        });

      function fncMainBoardList() {
          $.ajax({
            url: "/app/board/listBoardMain",
            type: "POST",
            data: JSON.stringify({ boardType: 1 }),
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
              var str = "";
              for (var i = 0; i < data.length; i++) {
                var file = data[i].fileName ? data[i].fileName : "/images/back.png";
                str += "<div class='swiper-slide'>"
                  + "<a href='/board/getBoard?boardType="+data[i].boardType+"&boardNo=" + data[i].boardNo + "' class='card-link'>"
                  + "<div class='card mb-4 shadow-sm'>"
                  + "<img class='bd-placeholder-img card-img-top' src='" + file + "' alt='Placeholder: Thumbnail'>"
                  + "<div class='card-body'>"
                  + "<h5 class='card-title'>" + data[i].title + "</h5>"
                  + "<p class='card-text'>"
                  + "<strong>" + data[i].nickName + "</strong><br>"
                  + data[i].regDate + "<br>"
                  + "<i class='mdi mdi-star'></i> " + data[i].bookmarkCnt
                  + " <i class='mdi mdi-eye'></i> " + data[i].views
                  + " <i class='mdi mdi-comment'></i> " + data[i].commentCnt
                  + "</p>"
                  + "</div></div></a></div>";
              }
              $('.swiper-wrapper').html(str);
              var swiper = new Swiper('.swiper-container', {
                slidesPerView: 4, // 한 줄에 4개씩 보여줍니다.
                spaceBetween: 24, // 슬라이드 사이의 간격을 설정합니다.
                loop: true, // 마지막 슬라이드에서 첫 슬라이드로 순환합니다.
                navigation: {
                  nextEl: '.custom-swiper-button-next',
                  prevEl: '.custom-swiper-button-prev',
                },
              });
            },
            error: function (xhr, status, error) {
              alert('리스트 없음');
            }
          });
        }

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
            <h4 class="boardList"> 공지사항 </h4>
              <div class="swiper-container">
                <div class="swiper-wrapper">
                  <!-- Slides will be injected here by JavaScript -->
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
