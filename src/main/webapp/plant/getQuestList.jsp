<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script>
$(document).ready(function () {
    function updateQuestList() {
        console.log("Sending request to update quest list...");
        $.ajax({
            url: "/app/plant/getQuestListByUser",
            type: "POST",
            contentType: "application/json",
            dataType: "json",
            success: function (data, status, xhr) {
                console.log("Request successful. Data received:", data);
                var str = "";
                for (var i = 0; i < data.length; i++) {
                    console.log("Processing quest:", data[i]);
                    if (data[i].questState === 'N') {
                        console.log("Quest state is 'N':", data[i]);
                        str += "<div class='events pt-4 px-3'>";
                        str += "  <div class='wrapper d-flex mb-2'>";
                        str += "    <input type='hidden' class='questStateNo' name='questStateNo' value='" + data[i].questStateNo + "'>";
                        str += "    <input type='hidden' class='questNo' name='questNo' value='" + data[i].quest.questNo + "'>";
                        str += "    <i class='ti-control-record text-primary mr-2'></i>";
                        str += "    식물 경험치 +" + data[i].quest.questReward;
                        str += "  </div>";
                        str += "  <p class='mb-0 font-weight-thin text-gray questContents'>" + data[i].quest.questContents + "</p>";
                        str += "  <p class='mb-0 font-weight-thin text-gray'>" + data[i].currentCnt + " / " + data[i].quest.questTargetCnt + "</p>";
                        str += "</div>";
                    } else if (data[i].questState === 'Y') {
                        console.log("Quest state is 'Y':", data[i]);
                        str += "<div class='events pt-4 px-3'>";
                        str += "  <div class='wrapper d-flex mb-2'>";
                        str += "    <input type='hidden' class='questStateNo' name='questStateNo' value='" + data[i].questStateNo + "'>";
                        str += "    <input type='hidden' class='questNo' name='questNo' value='" + data[i].quest.questNo + "'>";
                        str += "    <i class='ti-control-record text-primary mr-2'></i>";
                        str += "    <span>식물 경험치 +" + data[i].quest.questReward + "</span>";
                        str += "  </div>";
                        str += "  <p class='mb-0 font-weight-thin text-gray questContents'>" + data[i].quest.questContents + "</p>";
                        str += "  <p class='mb-0 font-weight-thin text-gray'>" + data[i].currentCnt + " / " + data[i].quest.questTargetCnt + "</p>";
                        str += "  <div class='quest-item'>";
                        str += "    <button type='button' class='btn-complete btn-primary btn-sm' onclick='completeQuest(" + data[i].questStateNo + ")'> 완료 </button>";
                        str += "  </div>";
                        str += "</div>";
                    }
                }
                $("#questResult").html(str); // 데이터를 화면에 즉시 반영
            },
            error: function (xhr, status, error) {
                console.error("Error occurred while fetching quest list: ", xhr.responseText);
            },
            complete: function (xhr, status) {
                console.log("Quest list update completed.");
            }
        });
    }

    window.completeQuest = function(questStateNo) {
        console.log("Sending request to complete quest:", questStateNo);
        $.ajax({
            url: "/app/plant/completeQuest",
            type: "POST",
            data: JSON.stringify({ questStateNo: questStateNo }),
            contentType: "application/json",
            success: function (data, status, xhr) {
                console.log("Quest completion successful.");
                updateQuestList(); // 퀘스트 상태를 다시 업데이트
            },
            error: function (xhr, status, error) {
                console.error("Error occurred while completing quest: ", xhr.responseText);
            }
        });
    }

    updateQuestList();
    setInterval(updateQuestList, 60000); // 매 1분마다 퀘스트 리스트를 업데이트
});
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
                <!---->
            </div>
        </div>
    </div>
</div>
<form id="getQuestList" method="post">
    <input type="hidden" name="questStateNo" value="${questState.questStateNo}">
    <input type="hidden" name="questNo" value="${questState.quest.questNo}">
    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
</form>
</body>
</html>