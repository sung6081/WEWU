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
      justify-content: center;
      align-items: center;
    }

    .image-container {
      margin-right: 100px;
    }

    .modal {
      display: none;
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.4);
    }

    .modal-content {
      background-color: #fff;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
      max-width: 600px;
    }

    .modal-close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .modal-close:hover,
    .modal-close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }

    .randomButton {
      display: flex;
      margin-top: 10px;
      flex-direction: column;
      align-items: center;
    }

    img.randomImage {
      max-width: 200px;
      height: auto;
    }

    .hidden {
      display: none;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function () {
      // 모달창 열기
      $(".btn-open-modal").on("click", function () {
        console.log("모달 열기 버튼 클릭됨");
        $(".modal").show();
      });

      // 모달창 닫기
      $(".modal-close").on("click", function () {
        console.log("모달 닫기 버튼 클릭됨");
        $(".modal").hide();
      });

      // 모달창 외부 클릭 시 닫기
      $(window).on("click", function (event) {
        if ($(event.target).is(".modal")) {
          console.log("모달 외부 클릭됨");
          $(".modal").hide();
        }
      });

      var clickCount = 0;
      var maxClicks = 3;

      // 랜덤 식물 선택
      $('.selectRandomPlantButton').on('click', function (event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        clickCount++;
        if (clickCount > maxClicks) {
          alert("더 이상 선택할 수 없습니다.");
          $(this).prop('disabled', true);
          return;
        }

        // 랜덤 이미지 요청
        $.ajax({
          url: "/app/plant/selectRandomPlant",
          type: "POST",
          processData: false,
          contentType: "application/json",
          dataType: "json",
          success: function (data) {
            console.log("Image URL: ", data.plantLevl.levlImg);
            console.log("Selected Plant No: " + data.plantNo); // 디버깅 메시지 추가
            console.log("Selected Plant Levl No: " + data.plantLevl.plantLevlNo); // 디버깅 메시지 추가
            // 이미지 출력
            $('.randomImage').attr('src', data.plantLevl.levlImg);
            $('.plantNo').val(data.plantNo);
            $('.plantLevlNo').val(data.plantLevl.plantLevlNo);
            $('.randomImageContainer').show();
          },
          error: function (xhr, status, error) {
            alert("랜덤뽑기에 실패했습니다!");
            console.error("Error: ", error);
          },
          complete: function (xhr, status) {
            console.log("Request completed");
          }
        });
      });

      // 선택 버튼 클릭 시 이름 입력 필드 표시
      $('.choosePlant').on('click', function () {
        $('.plantNameContainer').removeClass('hidden');
      });

      // 저장 버튼 클릭 시 폼 제출
      $('.savePlant').on('click', function (event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        // 폼 데이터 수집
        var plantNo = $('.plantNo').val();
        var plantLevlNo = $('.plantLevlNo').val();
        var myPlantName = $('.myPlantName').val();
        
        console.log("Plant No before saving: " + plantNo); // 디버깅 메시지 추가
        console.log("Plant Levl No before saving: " + plantLevlNo); // 디버깅 메시지 추가
        console.log("My Plant Name: " + myPlantName); // 디버깅 메시지 추가

        // AJAX 요청으로 데이터 전송
        $.ajax({
          url: "/app/plant/saveMyPlant",
          type: "POST",
          contentType: "application/json",
          data: JSON.stringify({
            plantNo: plantNo,
            plantLevlNo: plantLevlNo,
            myPlantName: myPlantName
          }),
          success: function (response) {
            alert("식물이 성공적으로 저장되었습니다!");
            $('.modal').hide(); // 모달창 닫기
            window.location.href = "/plant/getMyPlant";
          },
          error: function (xhr, status, error) {
            alert("식물 저장에 실패했습니다.");
            console.error("Error: ", error);
          }
        });
      });
    });
  </script>
</head>

<body>
  <!-- 모달 창 HTML 구조 -->
  <div class="modal">
    <div class="modal-content">
      <span class="modal-close">&times;</span>
      <div class="modal-body">
        <div class="container-fluid random">
          <form class="selectRandomPlant" method="POST">
            <div class="row randomButton">
              <div class="row random">
                <input type="hidden" class="plantNo" name="plantNo" value="">
                <input type="hidden" class="plantLevlNo" name="plantLevlNo" value="">
                <input type="hidden" class="plantExp" name="plantExp" value="">
                <input type="hidden" class="plantLevl" name="plantLevl" value="">
                <div class="randomImageContainer">
                  <img class="randomImage" src="">
                </div>
              </div>
              <div>
                <p>총 세번의 기회만 존재! </p>
              </div>
              <div>
                <button type="button" class="btn btn-primary selectRandomPlantButton">두근두근 랜덤뽑기!</button>
              </div>
              <div>
                <button type="button" class="btn btn-warning mt-2 choosePlant">선택</button>
              </div>
              <div class="form-group hidden mt-3 plantNameContainer">
                <label for="myPlantName">나의 식물 이름 :</label>
                <input type="text" class="form-control myPlantName" name="myPlantName" value="">
                <button type="submit" class="btn btn-success btn-sm mt-2 mx-auto savePlant">저장</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="main-panel">
    <div class="content-wrapper">
      <!-- NAVI -->
      <form name="getMyPlant" action="/plant/getMyPlant">
        <div class="container mt-4">
          <div class="row">
            <div class="col-lg-10 grid-margin stretch-card mx-auto">
              <div class="card">
                <button type="button" class="btn btn-primary btn-open-modal">식물 뽑으러 가기!</button>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->

</body>

</html>