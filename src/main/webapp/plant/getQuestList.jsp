<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <!DOCTYPE html>
 <html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
    $(document).ready(function () {
      $(".btn-complete").on("click", function () {
        var questNo = $(this).closest(".events").find("#questNo").val();
        var $currentButton = $(this);
        var questContents = $(this).closest(".events").find("#questContents").text();

        $.ajax({
          url: "/app/plant/completeQuest",
          type: "POST",
          data: JSON.stringify({
            questNo: questNo,
            questContents : questContents
          }),
          contentType: "application/json",
          dataType: "json",
          success: function (response) {
        	  console.log("Quest completed successfully", response);
              if (response.questState === 'N') {
                  var $questItem = $currentButton.closest(".events");
                  $questItem.find("#questContents").wrap("<del></del>").append(" 퀘스트완료");
                  $currentButton.remove(); // 완료 버튼 제거
                  $questItem.find(".wrapper span").wrap("<del></del>");
              } else {
                  $currentButton.prop("disabled", true);
              }
              updateQuestList();
          },
          error: function (xhr, status, error) {
            console.error("Error occurred while completing quest: ", error);
          }
        });
      });
    });

    function updateQuestList() {
      var form = document.getElementById('getQuestList');

      if (form) {
        var formData = new FormData(form);
        var jsonData = Object.fromEntries(formData.entries());

        $.ajax({
          url: "/app/plant/getQuestList",
          type: "POST",
          data: JSON.stringify(jsonData),
          contentType: "application/json",
          dataType: "json",
          success: function (data, status, xhr) {
        	  var str = "";
              for (var i = 0; i < data.length; i++) {
                  if (data[i].questState === 'N') {
                      str += "<div class='events pt-4 px-3'>";
                      str += "  <div class='wrapper d-flex mb-2'>";
                      str += "    <i class='ti-control-record text-primary mr-2'></i>";
                      str += "    <del> 완료 </del>";
                      str += "  </div>";
                      str += "  <del><p class='mb-0 font-weight-thin text-gray'>" + data[i].questContents + "</p></del>";
                      str += "</div>";
                  } else {
                      str += "<div class='events pt-4 px-3'>";
                      str += "  <div class='wrapper d-flex mb-2'>";
                      str += "    <i class='ti-control-record text-primary mr-2'></i>";
                      str += "    <span> 완료 </span>";
                      str += "  </div>";
                      str += "  <p class='mb-0 font-weight-thin text-gray' id='questContents'>" + data[i].questContents + "</p>";
                      str += "  <div class='quest-item'>";
                      str += "    <button type='button' class='btn-complete btn-primary btn-sm'> 완료 </button>";
                      str += "  </div>";
                      str += "</div>";
                  }
              }
            $("#questResult").html(str); // 데이터를 화면에 즉시 반영
          },
          error: function (xhr, status, error) {
            console.error("Error occurred while fetching quest list: ", error);
          },
          complete: function (xhr, status) {
            console.log("Quest list update completed.");
          }
        });
      } else {
        console.error('Form with id "getQuestList" not found.');
      }
    }

    window.onload = function () {
      updateQuestList();
    };
  </script>
  <style>
    #right-sidebar {
      max-height: 90vh;
      overflow-y: auto;
    }

    .quest-container {
      width: 100%;
    }

    .quest-item {
      display: flex;
      align-items: center;
    }

    .btn-complete {
      background-color: #00A06C;
      color: white;
      border: none;
      padding: 5px 10px;
      cursor: pointer;
      margin-left: 10px;
    }

    .btn-complete:hover {
      background-color: #0056b3;
    }
  </style>
</head>

<body>
  <div id="right-sidebar" class="settings-panel">
    <i class="settings-close ti-close"></i>
    <ul class="nav nav-tabs border-top" id="setting-panel" role="tablist">
      <li class="nav-item">
        <a class="nav-link active" id="todo-tab" data-toggle="tab" href="#todo-section" role="tab" aria-controls="todo-section" aria-expanded="true">퀘스트</a>
      </li>
    </ul>
    <div class="tab-content" id="setting-content">
      <div class="tab-pane fade show active scroll-wrapper" id="todo-section" role="tabpanel" aria-labelledby="todo-section">
        <c:forEach var="quest" items="${sessionScope.questList}">
          <div class="events pt-4 px-3">
            <div class="wrapper d-flex mb-2">
              
              <input type="hidden" id="questNo" name="questNo" value="${quest.questNo}">
              <c:if test="${quest.questState eq 'N'}">
                <div class="events pt-4 px-3">
             <div class="wrapper d-flex mb-2">
               <i class="ti-control-record text-primary mr-2"></i>
               <del>식물 경험치 +${quest.questReward}</del>
             </div>
             <del><p class="mb-0 font-weight-thin text-gray">${quest.questContents}</p></del>
           	</div>

              </c:if>
              
              <c:if test="${quest.questState eq 'Y'}">  
              <div class="events pt-4 px-3">
             <div class="wrapper d-flex mb-2">
               <i class="ti-control-record text-primary mr-2"></i>
               <span>식물 경험치 +${quest.questReward}</span>
             </div>
             <p class="mb-0 font-weight-thin text-gray">${quest.questContents}</p>
           	</div>
           	
           	<div class="quest-item">
             <button type="button" class="btn-complete btn-primary btn-sm"> 완료 </button>
           	</div>
              </c:if>
            </div>
            <p class="text-gray mb-0" id="questResult"></p>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>

  <form id="getQuestList" method="post">
    <input type="hidden" name="questNo" value="${quest.questNo}">
  </form>
</body>

</html>