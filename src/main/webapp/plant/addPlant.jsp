<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
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
   $(document).ready(function () {
     'use strict';

     $(function () {
       $("button[name='cancel']").on("click", function () {
         $('form').each(function () {
           this.reset();
         });
       });
     });


     $("input[name='submit']").on("click", function () {
       if (confirm("등록하시겠습니까?")) {
         addPlant();
       }
     });

     async function addPlant() {
       let plantName = $("input[name='plant.plantName']").val();

       var form1 = document.getElementById('addPlantName');
       var formData1 = new FormData(form1);

       var plantRequest1 = {
         plantName: plantName
       };

       formData1.append('plant', new Blob([JSON.stringify(plantRequest1)], { type: 'application/json' }));

       try {
         var response = await $.ajax({
           url: "/app/plant/addPlantName",
           type: "POST",
           data: formData1,
           processData: false,
           contentType: false
         });

         var plantNo = response.plantNo;
         alert("식물 등록이 완료되었습니다! ");

         await addPlantStages(plantNo, plantName);
         window.location.href = "/plant/listPlant";
       } catch (error) {
         console.error("Error: ", error);
         alert("식물 등록에 실패했습니다.");
       }
     }

     async function addPlantStages(plantNo, plantName) {
       for (let i = 1; i <= 5; i++) {
         var form = document.getElementById('addPlant_' + i);
         var formData = new FormData(form);

         var plantLevlRequest = {
           plantNo: plantNo,
           plantMinExp: formData.get('plantLevl.plantMinExp'),
           plantMaxExp: formData.get('plantLevl.plantMaxExp'),
           plantLevl: formData.get('plantLevl.plantLevl'),
           plantFinalLevl: formData.get('plantLevl.plantFinalLevl')

         };

         formData.append('plantLevl', new Blob([JSON.stringify(plantLevlRequest)], { type: 'application/json' }));

         try {
           await $.ajax({
             url: "/app/plant/addPlantLevl",
             type: "POST",
             data: formData,
             processData: false,
             contentType: false
           });
           alert("식물 단계 추가 완료! " + i + "단계");
         } catch (error) {
           console.error("Error: ", error);
           alert(i + "단계 추가에 실패했습니다.");
           throw error;
         }
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
   <style>
.jumbotron{

background-color: #00A06C;
margin-top:160px;
margin-bottom:0;
background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
background-image: url('/images/plant1.jpg'); /* 배경 이미지 경로 */
background-size: cover; /* 이미지가 컨테이너를 덮도록 */
background-position: center; /* 이미지가 중앙에 위치하도록 */
}
.display-4 {
  color: #fff; /* 원하는 색상으로 변경 */
}
.main-panel{
margin:0;
}
</style>
</head>

<body>
<div class="jumbotron">
  <div class="container">
    <p class="display-4"><b>ADD PLANT</b></p>
  </div>
  </div>
  <jsp:include page="/plant/plantSide.jsp" />
 <div class="main-panel">

   <div class="content-wrapper">
   <div class="row">
     <div class="flex-container d-flex flex-nowrap">
       <!-- Separate card for plant name -->
       <div class="col-lg-12 grid-margin stretch-card">
         <div class="card">
           <div class="card-body">
             <form id="addPlantName">
               <h4 class="card-title">식물 이름 입력</h4>
               <div class="form-group">
                 <label for="plantName">식물이름</label>
                 <input type="text" class="form-control" name="plant.plantName" id="plantName"
                   placeholder="plantName">
               </div>
             </form>
           </div>
         </div>
       </div>
     </div>
     <div class="flex-container d-flex flex-nowrap">
       <!-- 1단계 폼 -->
       <div class="col-lg-2 grid-margin stretch-card">
         <div class="card">
           <div class="card-body">
             <form id="addPlant_1" enctype="multipart/form-data">
               <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
               <input type="hidden" name="plantLevl.plantLevlNo" value="${plantLevl.plantLevlNo}" />
               <input type="hidden" name="plant.plantName" value="${plant.plantName}" />
               <h4 class="card-title">1단계</h4>
               <div class="form-group">
                 <label for="plantMinExp">최소경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMinExp" placeholder="plantMinExp">
               </div>
               <div class="form-group">
                 <label for="plantMaxExp">최대경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMaxExp" placeholder="plantMaxExp">
               </div>
               <div class="form-group">
                 <label for="plantLevl">식물단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
               </div>
               <div class="form-group">
                 <label for="plantFinalLevl">식물최종단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantFinalLevl"
                   placeholder="plantFinalLevl">
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
       <!-- 2단계 폼 -->
       <div class="col-lg-2 grid-margin stretch-card">
         <div class="card">
           <div class="card-body">
             <form id="addPlant_2" enctype="multipart/form-data">
               <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
               <input type="hidden" name="plantLevl.plantLevlNo" value="${plantLevl.plantLevlNo}" />
               <input type="hidden" name="plant.plantName" value="${plant.plantName}" />
               <h4 class="card-title">2단계</h4>
               <div class="form-group">
                 <label for="plantMinExp">최소경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMinExp" placeholder="plantMinExp">
               </div>
               <div class="form-group">
                 <label for="plantMaxExp">최대경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMaxExp" placeholder="plantMaxExp">
               </div>
               <div class="form-group">
                 <label for="plantLevl">식물단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
               </div>
               <div class="form-group">
                 <label for="plantFinalLevl">식물최종단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantFinalLevl"
                   placeholder="plantFinalLevl">
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
       <!-- 3단계 폼 -->
       <div class="col-lg-2 grid-margin stretch-card">
         <div class="card">
           <div class="card-body">
             <form id="addPlant_3" enctype="multipart/form-data">
               <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
               <input type="hidden" name="plantLevl.plantLevlNo" value="${plantLevl.plantLevlNo}" />
               <input type="hidden" name="plant.plantName" value="${plant.plantName}" />
               <h4 class="card-title">3단계</h4>
               <div class="form-group">
                 <label for="plantMinExp">최소경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMinExp" placeholder="plantMinExp">
               </div>
               <div class="form-group">
                 <label for="plantMaxExp">최대경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMaxExp" placeholder="plantMaxExp">
               </div>
               <div class="form-group">
                 <label for="plantLevl">식물단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
               </div>
               <div class="form-group">
                 <label for="plantFinalLevl">식물최종단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantFinalLevl"
                   placeholder="plantFinalLevl">
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
       <!-- 4단계 폼 -->
       <div class="col-lg-2 grid-margin stretch-card">
         <div class="card">
           <div class="card-body">
             <form id="addPlant_4" enctype="multipart/form-data">
               <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
               <input type="hidden" name="plantLevl.plantLevlNo" value="${plantLevl.plantLevlNo}" />
               <input type="hidden" name="plant.plantName" value="${plant.plantName}" />
               <h4 class="card-title">4단계</h4>
               <div class="form-group">
                 <label for="plantMinExp">최소경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMinExp" placeholder="plantMinExp">
               </div>
               <div class="form-group">
                 <label for="plantMaxExp">최대경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMaxExp" placeholder="plantMaxExp">
               </div>
               <div class="form-group">
                 <label for="plantLevl">식물단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
               </div>
               <div class="form-group">
                 <label for="plantFinalLevl">식물최종단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantFinalLevl"
                   placeholder="plantFinalLevl">
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
       <!-- 5단계 폼 -->
       <div class="col-lg-2 grid-margin stretch-card">
         <div class="card">
           <div class="card-body">
             <form id="addPlant_5" enctype="multipart/form-data">
               <input type="hidden" name="plant.plantNo" value="${plant.plantNo}" />
               <input type="hidden" name="plantLevl.plantLevlNo" value="${plantLevl.plantLevlNo}" />
               <input type="hidden" name="plant.plantName" value="${plant.plantName}" />
               <h4 class="card-title">5단계</h4>
               <div class="form-group">
                 <label for="plantMinExp">최소경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMinExp" placeholder="plantMinExp">
               </div>
               <div class="form-group">
                 <label for="plantMaxExp">최대경험치</label>
                 <input type="number" class="form-control" name="plantLevl.plantMaxExp" placeholder="plantMaxExp">
               </div>
               <div class="form-group">
                 <label for="plantLevl">식물단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantLevl" placeholder="plantLevl">
               </div>
               <div class="form-group">
                 <label for="plantFinalLevl">식물최종단계</label>
                 <input type="text" class="form-control" name="plantLevl.plantFinalLevl"
                   placeholder="plantFinalLevl">
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
     </div>
     <div class="container">
       <div class="d-flex justify-content-center mb-5">
         <input type="submit" class="btn btn-primary" name="submit" value="등록">
         <button type="button" class="btn btn-white" name="cancel">취소</button>
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