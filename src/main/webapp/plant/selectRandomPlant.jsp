<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Image Popup</title>
  <script>
  $(document).ready(function() {
      $('#selectRandomPlantButton').on('click', function(event) {
          event.preventDefault(); // 기본 폼 제출 동작 방지

          // 랜덤 이미지 요청
          $.ajax({
              url: "/app/group/selectRandomPlant",
              type: "POST",
              processData: false,
              contentType: "application/json",
              dataType: "json",
              success: function(data) {
                  // 이미지 출력
                  $('#randomImage').attr('src', data.imageUrl);
                  $('#randomImageContainer').show();
              },
              error: function(xhr, status, error) {
                  console.error("Error: ", error);
              },
              complete: function(xhr, status) {
                  console.log("Request completed");
              }
          });
      });
  });
</script>
</head>
<body>
<div class="popup-content">
  <form id="selectRandomPlant">
      <button id="selectRandomPlantButton">랜덤 식물 선택</button>
  
  <div id="randomImageContainer" style="display: none;">
      <img id="randomImage" src="${plant.plantLevl.levlImg}" class="rounded mx-auto d-block" alt="Random Plant Image">
  </div>
  </form>
</div>
</body>
</html>