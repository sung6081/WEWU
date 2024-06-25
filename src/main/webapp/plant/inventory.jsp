<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <!DOCTYPE html>
 <html>

 <head>
   <meta charset="UTF-8">
   <style>
     .input-small {
       width: 40px;
     }
   </style>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script>
     $(document).ready(function () {
       $(".use-item-btn").click(function () {
         var itemPurNo = $(this).data("itempurno");
         var useItemNum = $("#useItemNum_" + itemPurNo).val();
         var nickname = $("input[name='nickname']").val();
         var myPlantNo = $("input[name='myPlantNo']").val();

         if (!useItemNum || useItemNum <= 0) {
           alert("사용할 수량을 입력하세요.");
           return;
         }

         $.ajax({
           type: "POST",
           url: "/app/plant/useItem",
           contentType: "application/json",
           data: JSON.stringify({
        	   searchCondition: "itemPurNo",
               searchKeyword: itemPurNo.toString(),
               pageSize: parseInt(useItemNum),
               nickname: nickname,
               myPlantNo: parseInt(myPlantNo)
           }),
           success: function (response) {
             alert("아이템을 성공적으로 사용했습니다.");
             location.reload();
           },
           error: function (error) {
             alert("아이템 사용에 실패했습니다.");
           }
         });
       });
     });
   </script>
 </head>

 <body>
   <!-- HEADER -->
   <jsp:include page="/header.jsp" />
   <!-- HEADER -->
   <form>
     <c:forEach var="inventory" items="${list}">
       <div class="main-panel">
         <div class="content-wrapper">
           <jsp:include page="/plant/plantNavi.jsp" />
           <br><br><br>
           <div class="container text-center">
             <div class="row justify-content-center mt-5">
               <div class="col-lg-10 grid-margin stretch-card">
                 <div class="card mx-auto">
                   <div class="card-body">
                     <div id="levlImgContainer">
                       <img src="https://via.placeholder.com/200x200">
                     </div>

                     <input type="hidden" name="nickname" value="" />
                     <input type="hidden" name="myPlantNo" value="" />

                     <div id="myPlantExp"></div>

                   </div>
                 </div>
               </div>
             </div>
           </div>

           <div class="container text-center">
             <div class="row justify-content-center mt-5">
               <div class="col-lg-10 grid-margin stretch-card">
                 <div class="card mx-auto">
                   <div class="card-body">
                     <h4 class="card-title">Hoverable Table</h4>
                     <p class="card-description">
                       Add class <code>.table-hover</code>
                     </p>
                     <div class="table-responsive">
                       <table class="table table-hover">
                         <thead>
                           <tr>
                             <th>종류</th>
                             <th>효과</th>
                             <th>수량</th>
                             <th>사용하기</th>
                           </tr>
                         </thead>
                         <tbody>

                           <tr>
                             <td>${inventory.itemImg}</td>
                             <td>${inventory.itemExp}</td>
                             <td>${inventory.itemNum}</td>
                             <td>
                               <input type="number" class="form-control" id="useItemNum_${inventory.itemPurNo}"
                                 name="useItemNum">
                             </td>
                             <td>
                               <button type="button" class="btn btn-outline-warning btn-fw use-item-btn"
                                 data-itempurno="${inventory.itemPurNo}">사용</button>
                             </td>
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
     </c:forEach>
   </form>

   <!-- FOOTER -->
   <jsp:include page="/footer.jsp" />
   <!-- FOOTER -->
 </body>

 </html>