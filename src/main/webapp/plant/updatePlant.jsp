<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->
  <style>
    /* h1 요소에 앞 여백 추가 */
    .custom-title-space {
      padding-left: 20px;
      /* 20px의 왼쪽 여백을 설정 */
    }
    .flex-container {
      display: flex;
      gap: 20px;
      /* 요소 사이의 간격을 설정 */
      justify-content: center;
      /* 수평 가운데 정렬 */
      align-items: center;
      /* 수직 가운데 정렬 */
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
  
  function fncUpdatePlant() {
	    var form = document.getElementById('updatePlant');
	    var formData = new FormData(form);

	 // JSON 데이터 생성
	    var jsonData = {
	      plantLevlNo: formData.get("plantLevlNo"),
	      plant: {
	        plantNo: formData.get("plantNo"),
	        plantName: formData.get("plantName"),
	      },
	      plantLevl: {
	    	plantLevlNo: formData.get("plantLevlNo"),
	    	plantNo: formData.get("plantNo"),
	        plantLevl: formData.get("plantLevl"),
	        plantFinalLevl: formData.get("plantFinalLevl"),
	        plantMinExp: formData.get("plantMinExp"),
	        plantMaxExp: formData.get("plantMaxExp")
	        
	        
	      }
	    };

	 	// JSON 데이터를 FormData에 추가
	    formData.append("plantRequest", new Blob([JSON.stringify(jsonData)], {
	      type: "application/json"
	    }));

	    
	   // 이미지를 FormData에 추가
		  var levlImgFile = document.getElementById('levlImg').files[0];
		  if (levlImgFile) {
		    formData.append("levlImg", levlImgFile);
		    alert("levlImg 추가됨: " + levlImgFile.name);
		  } else {
		    alert("levlImg 파일이 선택되지 않았습니다.");
		  }
		  
		  
	    $.ajax({
	      url: "/app/plant/updatePlant",
	      type: "POST",
	      processData: false,
	      contentType: false, // multipart/form-data를 설정
	      data: formData,
	      success: function (data, status, xhr) {
	        alert("식물 업데이트가 완료 되었습니다!");
	        window.location.href ="/plant/listPlant";
	      },
	      error: function (xhr, status, error) {
	        console.error("Error: ", error); // 에러 로그
	      },
	      complete: function (xhr, status) {
	        console.log("Request completed for form"); // 완료 로그
	      }
	    });
	  }
  
	  $(document).ready(function () {
	    $('.file-upload-browse').on('click', function () {
	      var file = $(this).closest('.input-group').prev('.file-upload-default');
	      file.trigger('click');
	    });

	    $('.file-upload-default').on('change', function () {
	      var fileName = $(this).val().replace(/C:\\fakepath\\/i, '');
	      $(this).next('.input-group').find('.file-upload-info').val(fileName);
	    });

	    $("button[name='cancel']").on("click", function () {
	      $("form")[0].reset();
	    });

	    $("form#updatePlant").on("submit", function (event) {
	      event.preventDefault(); // 폼의 기본 제출 동작을 막음
	      fncUpdatePlant(); // AJAX 요청을 실행
	    });
	  });
  </script>
</head>

<body>
  <jsp:include page="/plant/plantSide.jsp" />

  <div class="main-panel">
    <div class="content-wrapper title-card">
      <form name="updatePlant" id="updatePlant" enctype="multipart/form-data">
        <div class="flex-container">
          <div class="col-lg-5 grid-margin stretch-card">
            <div class="card">
              <div class="card-body">
              	<h5>식물 수정</h5>
                <h4 class="card-title"></h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                <input type="hidden" name="plantNo" id="plantNo" value="${plant.plantNo}">
                <input type="hidden" name="plantLevlNo" id="plantLevlNo" value="${plantLevl.plantLevlNo}">
                  <label for="plantName">식물이름</label> <input type="text" class="form-control" name="plantName"
                    id="plantName" value="${plant.plantName}">
                </div>
                <div class="form-group">
                  <label for="plantMinExp">최소경험치</label> <input type="number" class="form-control" name="plantMinExp"
                    id="plantMinExp" value="${plantLevl.plantMinExp}">
                </div>
                <div class="form-group">
                  <label for="plantMaxExp">최대경험치</label> <input type="number" class="form-control" name="plantMaxExp"
                    id="plantMaxExp" value="${plantLevl.plantMaxExp}">
                </div>
                <div class="form-group">
                  <label for="plantLevl">식물단계</label> <input type="text" class="form-control" name="plantLevl"
                    id="plantLevl" value="${plantLevl.plantLevl}">
                </div>
                <div class="form-group">
                  <label for="plantFinalLevl">식물최종단계</label> <input type="text" class="form-control"
                    name="plantFinalLevl" id="plantFinalLevl" value="${plantLevl.plantFinalLevl}">
                </div>
                <div class="form-group">
                  <label>식물단계이미지</label> 
                  <input type="file" name="file" class="file-upload-default" id="levlImg" >
                  <div class="input-group col-xs-12">
                    <input type="text" class="form-control file-upload-info"  disabled value="${plantLevl.levlImg}">
                    <span class="input-group-append">
                      <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="d-flex justify-content-center mb-5">
            <input type="submit" class="btn btn-primary mr-2" value="수정">
            <button type = "button" class="btn btn-white" name="cancel">취소</button>
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