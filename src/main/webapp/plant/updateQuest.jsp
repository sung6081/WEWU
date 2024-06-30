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
  </style>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
  
  function fncUpdateQuest(){
      var form = document.getElementById('updateQuest');
      var formData = new FormData(form);
      
	  // JSON으로 변환
	  var jsonData = Object.fromEntries(formData);
      
      $.ajax({
          url:"/app/plant/updateQuest",
          type: "POST",
          contentType: "application/json",
          data : JSON.stringify(
		 			jsonData
		 		), // 요청 시 전달할 데이터
          dataType: "json",
          success: function (data, status, xhr) {
              alert(" 퀘스트 업데이트가 완료 되었습니다 ! ");
              window.location.href ="/plant/listQuest"
          },
          error: function (xhr, status, error) {
              console.error("Error: ", error); // 에러 로그
          },
          complete: function (xhr, status) {
              console.log("Request completed for form "); // 완료 로그
          }
      });
  }
  
  
      $(function () {
	      $("button[name='cancel']").on("click", function () {
	        $("form")[0].reset();
	      });
      });
      
      $(function(){
    	  $("input[name='edit']").on("click",function(){
    		  event.preventDefault();
    		  fncUpdateQuest();
    	  });
      });
  </script>
    <style>
.jumbotron{
margin: 0 !important; /* 기본 마진 제거 */
background-color: #00A06C;
}
</style>

<body>
  <jsp:include page="/plant/plantSide.jsp" />
  <div class="main-panel">
   <div class="jumbotron">
  <div class="container">
    <p class="display-4"><b>Plant Manage</b></p>
  </div>
  </div>
    <div class="content-wrapper">
      <form name = "updateQuest" id="updateQuest">
        <div class="row mt-5">
          <div class="col-lg-6 grid-margin stretch-card mx-auto">
            <div class="card">
              <div class="card-body">
                <h4 class="card-title">퀘스트 수정</h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                <input type="hidden" name="questNo" value="${quest.questNo}">
                  <label for="questContents">Quest Contents ( 퀘스트 내용)</label>
                  <input type="text" class="form-control" name="questContents" id="questContents" value = "${quest.questContents}" >
                </div>
                <div class="form-group">
                  <label for="questTarget">Quest Target ( 퀘스트 목표 )</label>
                  <input type="text" class="form-control" name="questTarget" id="questTarget" value = "${quest.questTarget}">
                </div>
                <div class="form-group">
                  <label for="questReward">Quest Reward ( 퀘스트 보상 )</label>
                  <input type="text" class="form-control" name="questReward" id="questReward" value = "${quest.questReward}" >
                </div>
                <div class="form-group">
                  <label for="questTargetCnt">Quest Count ( 퀘스트 목표치)</label>
                  <input type="text" class="form-control" name="questTargetCnt" id="questTargetCnt"value = "${quest.questTargetCnt}" >
                </div>
                <input type="submit" class="btn btn-primary mr-2" name="edit" value="수정">
                <button type="button" class="btn btn-light" name="cancel">취소</button>
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