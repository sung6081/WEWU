<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script>
$(document).ready(function () {
	  $(document).on("click", ".btn-complete", function () {
	    alert("메롱"); // 디버그용 알림
	    var questStateNo = $(this).closest(".events").find(".questStateNo").val();
	    var questNo = $(this).closest(".events").find(".questNo").val();
	    console.log("questStateNo", questStateNo); // questStateNo 값을 로그에 출력
	    console.log("questNo", questNo); // questNo 값을 로그에 출력
	    var $currentButton = $(this);
	    var questContents = $(this).closest(".events").find(".questContents").text();
	    console.log("questContents", questContents); // questContents 값을 로그에 출력

	    var requestData = {
	      questStateNo: questStateNo,
	      questNo: questNo,
	      questContents: questContents
	    };

	    console.log("Request data:", requestData); // 요청 데이터 로그

	    $.ajax({
	      url: "/app/plant/completeQuest",
	      type: "POST",
	      data: JSON.stringify(requestData),
	      contentType: "application/json",
	      dataType: "json",
	      success: function (response) {
	        console.log("Quest completed successfully", response);
	        if (response.questState === 'N') {
	          var $questItem = $currentButton.closest(".events");
	          $questItem.find(".questContents").wrap("<del></del>").append(" 퀘스트완료");
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
        url: "/app/plant/getQuestListByUser",
        type: "POST",
        data: JSON.stringify(jsonData),
        contentType: "application/json",
        dataType: "json",
        success: function (data, status, xhr) {
          console.log("Received data:", data);
          var str = "";
          for (var i = 0; i < data.length; i++) {
            if (data[i].questState === 'N') {
              str += "<div class='events pt-4 px-3'>";
              str += "  <div class='wrapper d-flex mb-2'>";
              str += "    <input type='hidden' class='questStateNo' name='questStateNo' value='" + data[i].questStateNo + "'>"; // questStateNo 숨김 필드 추가
              str += "    <input type='hidden' class='questNo' name='questNo' value='" + data[i].quest.questNo + "'>"; // questNo 숨김 필드 추가
              str += "    <i class='ti-control-record text-primary mr-2'></i>";
              str += "    <del>식물 경험치 +" + data[i].quest.questReward + "</del>";
              str += "  </div>";
              str += "  <del><p class='mb-0 font-weight-thin text-gray questContents'>" + data[i].quest.questContents + "</p></del>";
              str += "</div>";
            } else {
              str += "<div class='events pt-4 px-3'>";
              str += "  <div class='wrapper d-flex mb-2'>";
              str += "    <input type='hidden' class='questStateNo' name='questStateNo' value='" + data[i].questStateNo + "'>"; // questStateNo 숨김 필드 추가
              str += "    <input type='hidden' class='questNo' name='questNo' value='" + data[i].quest.questNo + "'>"; // questNo 숨김 필드 추가
              str += "    <i class='ti-control-record text-primary mr-2'></i>";
              str += "    <span>식물 경험치 +" + data[i].quest.questReward + "</span>";
              str += "  </div>";
              str += "  <p class='mb-0 font-weight-thin text-gray questContents'>" + data[i].quest.questContents + "</p>";
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
        <div id="questResult">
          <c:forEach var="questState" items="${list}">
            <div class="events pt-4 px-3">
              <div class="wrapper d-flex mb-2">
                <input type="hidden" class="questStateNo" name="questStateNo" value="${questState.questStateNo}"> <!-- 숨김 필드 추가 -->
                <input type="hidden" class="questNo" name="questNo" value="${questState.quest.questNo}"> <!-- 숨김 필드 추가 -->
                <i class="ti-control-record text-primary mr-2"></i>
                <c:choose>
                  <c:when test="${questState.questState == 'N'}">
                    <del>식물 경험치 +${questState.quest.questReward}</del>
                    <del><p class="mb-0 font-weight-thin text-gray questContents">${questState.quest.questContents}</p></del>
                  </c:when>
                  <c:otherwise>
                    <span>식물 경험치 +${questState.quest.questReward}</span>
                    <p class="mb-0 font-weight-thin text-gray questContents">${questState.quest.questContents}</p>
                    <div class="quest-item">
                      <button type="button" class="btn-complete btn-primary btn-sm"> 완료 </button>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
  <form id="getQuestList" method="post">
    <input type="hidden" name="questStateNo" value="${questState.questStateNo}">
    <input type="hidden" name="questNo" value="${questState.quest.questNo}">
  </form>
</body>

</html>