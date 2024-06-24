<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
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
$(document).ready(function () {
    'use strict';
    
    $(function () {
        $("button[name='cancel']").on("click", function () {
            $('form').each(function () {
                this.reset();
            });
        });
    });


    
    $("input[name='submit']").on("click", function(){
        if (confirm("등록하시겠습니까?")) {
            addPlant();
        }
    });

    function addPlant() {
        for (let i = 1; i <= 5; i++) {
            var form = document.getElementById('addPlant_' + i);
            var formData = new FormData(form);
            
            // PlantRequest 객체 생성
            var plantRequest = {
                plant: {
                    plantName: formData.get('plant.plantName'),
                    plantNo: formData.get('plant.plantNo')
                },
                plantLevl: {
                    plantMinExp: formData.get('plantLevl.plantMinExp'),
                    plantMaxExp: formData.get('plantLevl.plantMaxExp'),
                    plantLevl: formData.get('plantLevl.plantLevl'),
                    plantFinalLevl: formData.get('plantLevl.plantFinalLevl')
                }
            };
            
            formData.append('plantRequest', new Blob([JSON.stringify(plantRequest)], { type: 'application/json' }));

            $.ajax({
            	url: "/app/plant/addPlant",
                type: "POST",
                data: formData,
                processData: false,  // jQuery가 데이터를 자동으로 변환하지 않도록 설정
                contentType: false,  // jQuery가 content type을 설정하지 않도록 설정
                success: function (data, status, xhr) {
                    alert(" 식물 등록이 완료 되었습니다 ! " + i + "단계");
                },
                error: function (xhr, status, error) {
                    console.error("Error: ", error); // 에러 로그
                },
                complete: function (xhr, status) {
                    console.log("Request completed for form " + i); // 완료 로그
                }
            });
        }
    }

    $('.file-upload-browse').on('click', function () {
        var file = $(this).closest('.input-group').prev('.file-upload-default');
        file.trigger('click');
    });

    $('.file-upload-default').on('change', function () {
        var fileName = $(this).val().replace(/C:\\fakepath\\/i, '');
        $(this).next('.input-group').find('.file-upload-info').val(fileName);
    });


   
});

  $('footer').removeClass('fixed-bottom');
</script>
</head>

<body>
  <jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/plant/plantSide.jsp" />
<div class="main-panel" >
  <div class="content-wrapper ">
    <div class="flex-container d-flex flex-nowrap">
      <div class="col-lg-2 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">1단계</h4>
            <p class="card-description">Basic form elements</p>
            <form id="addPlant_1" enctype="multipart/form-data">
              <div class="form-group">
                <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
                <input type="hidden" name="plantLevl.plantLevlNo" value="${plantLevl.plantLevlNo}" />
                <label for="plantName">식물이름</label>
                <input type="text" class="form-control" name="plant.plantName"  placeholder="plantName">
              </div>
              <div class="form-group">
                <label for="plantMinExp">최소경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMinExp" placeholder="plantMinExp">
              </div>
              <div class="form-group">
                <label for="plantMinExp">최대경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMaxExp"  placeholder="plantMaxExp">
              </div>
              <div class="form-group">
                <label for="plantLevl">식물단계</label>
                <input type="text" class="form-control" name="plantLevl.plantLevl"  placeholder="plantLevl">
              </div>
              <div class="form-group">
                <label for="plantFinalLevl">식물최종단계</label>
                <input type="text" class="form-control" name="plantLevl.plantFinalLevl" placeholder="plantFinalLevl">
              </div>
              <div class="form-group">
                <label>식물단계이미지</label>
                <input type="file" name="file" class="file-upload-default">
                <div class="input-group col-xs-12">
                  <input type="text" class="form-control file-upload-info" disabled placeholder="Upload Image">
                  <span class="input-group-append">
                    <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                  </span>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-lg-2 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">2단계</h4>
            <p class="card-description">Basic form elements</p>
            <form id="addPlant_2" enctype="multipart/form-data">
              <div class="form-group">
              <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
                <label for="questContents">식물이름</label>
                <input type="text" class="form-control" name="plant.plantName"  placeholder=plantName>
              </div>
              <div class="form-group">
                <label for="questTarget">최소경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMinExp"  placeholder="plantMinExp">
              </div>
              <div class="form-group">
                <label for="questReward">최대경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMaxExp"  placeholder="plantMaxExp">
              </div>
              <div class="form-group">
                <label for="questState">식물단계</label>
                <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
              </div>
              <div class="form-group">
                <label for="questState">식물최종단계</label>
                <input type="text" class="form-control" name="plantLevl.plantFinalLevl"  placeholder="plantFinalLevl">
              </div>
              <div class="form-group">
                <label>식물단계이미지</label>
                <input type="file" name="file" class="file-upload-default">
                <div class="input-group col-xs-12">
                  <input type="text" class="form-control file-upload-info" disabled placeholder="levlImg">
                  <span class="input-group-append">
                    <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                  </span>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-lg-2 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">3단계</h4>
            <p class="card-description">Basic form elements</p>
            <form id="addPlant_3" enctype="multipart/form-data">
              <div class="form-group">
              <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
                <label for="questContents">식물이름</label>
                <input type="text" class="form-control" name="plant.plantName" placeholder=plantName>
              </div>
              <div class="form-group">
                <label for="questTarget">최소경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMinExp" 
                  placeholder="plantMinExp">
              </div>
              <div class="form-group">
                <label for="questReward">최대경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMaxExp" 
                  placeholder="plantMaxExp">
              </div>
              <div class="form-group">
                <label for="questState">식물단계</label>
                <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
              </div>
              <div class="form-group">
                <label for="questState">식물최종단계</label>
                <input type="text" class="form-control" name="plantLevl.plantFinalLevl" 
                  placeholder="plantFinalLevl">
              </div>
              <div class="form-group">
                <label>식물단계이미지</label>
                <input type="file" name="file" class="file-upload-default">
                <div class="input-group col-xs-12">
                  <input type="text" class="form-control file-upload-info" disabled="" placeholder="levlImg">
                  <span class="input-group-append">
                    <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                  </span>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-lg-2 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">4단계</h4>
            <p class="card-description">Basic form elements</p>
            <form id="addPlant_4" enctype="multipart/form-data">
              <div class="form-group">
              <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
                <label for="questContents">식물이름</label>
                <input type="text" class="form-control" name="plant.plantName"  placeholder=plantName>
              </div>
              <div class="form-group">
                <label for="questTarget">최소경험치</label>
                <input type="number" class="form-control" name="plantMinExp" 
                  placeholder="plantMinExp">
              </div>
              <div class="form-group">
                <label for="questReward">최대경험치</label>
                <input type="number" class="form-control" name="plantMaxExp" 
                  placeholder="plantMaxExp">
              </div>
              <div class="form-group">
                <label for="questState">식물단계</label>
                <input type="text" class="form-control" name="plantLevl"  placeholder="plantLevl">
              </div>
              <div class="form-group">
                <label for="questState">식물최종단계</label>
                <input type="text" class="form-control" name="plantFinalLevl" 
                  placeholder="plantFinalLevl">
              </div>
              <div class="form-group">
                <label>식물단계이미지</label>
                <input type="file" name="file" class="file-upload-default">
                <div class="input-group col-xs-12">
                  <input type="text" class="form-control file-upload-info" disabled="" placeholder="levlImg">
                  <span class="input-group-append">
                    <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                  </span>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-lg-2 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">5단계</h4>
            <p class="card-description">Basic form elements</p>
            <form id="addPlant_5" enctype="multipart/form-data">
              <div class="form-group">
              <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
                <label for="questContents">식물이름</label>
                <input type="text" class="form-control" name="plant.plantName"  placeholder=plantName>
              </div>
              <div class="form-group">
                <label for="questTarget">최소경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMinExp" 
                  placeholder="plantMinExp">
              </div>
              <div class="form-group">
                <label for="questReward">최대경험치</label>
                <input type="number" class="form-control" name="plantLevl.plantMaxExp" 
                  placeholder="plantMaxExp">
              </div>
              <div class="form-group">
                <label for="questState">식물단계</label>
                <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
              </div>
              <div class="form-group">
                <label for="questState">식물최종단계</label>
                <input type="text" class="form-control" name="plantLevl.plantFinalLevl"
                  placeholder="plantFinalLevl">
              </div>
              <div class="form-group">
                <label>식물단계이미지</label>
                <input type="file" name="file" class="file-upload-default">
                <div class="input-group col-xs-12">
                  <input type="text" class="form-control file-upload-info" disabled="" placeholder="levlImg">
                  <span class="input-group-append">
                    <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                  </span>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="container">
      <div class="d-flex justify-content-center mb-5">
        <input type="submit" class="btn btn-primary" name ="submit" value="등록">
        <button type="button" class="btn btn-white" name="cancel">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- FOOTER -->
<jsp:include page="/footer.jsp" />
<!-- FOOTER -->
</body>

</html>