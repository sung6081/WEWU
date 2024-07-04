<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script>
$(document).ready(function () {
    function updateQuestList() {
        var form = document.getElementById('getQuestList');

        if (form) {
            var formData = new FormData(form);
            var jsonData = Object.fromEntries(formData.entries());
            console.log(jsonData);
            

            $.ajax({
                url: "/app/plant/getQuestListByUser",
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
                            str += "    <input type='hidden' class='questStateNo' name='questStateNo' value='" + data[i].questStateNo + "'>";
                            str += "    <input type='hidden' class='questNo' name='questNo' value='" + data[i].quest.questNo + "'>";
                            str += "    <i class='ti-control-record text-primary mr-2'></i>";
                            str += "    <del>식물 경험치 +" + data[i].quest.questReward + "</del>";
                            str += "  </div>";
                            str += "  <del><p class='mb-0 font-weight-thin text-gray questContents'>" + data[i].quest.questContents + "</p></del>";
                            str += "</div>";
                        } else {
                            str += "<div class='events pt-4 px-3'>";
                            str += "  <div class='wrapper d-flex mb-2'>";
                            str += "    <input type='hidden' class='questStateNo' name='questStateNo' value='" + data[i].questStateNo + "'>";
                            str += "    <input type='hidden' class='questNo' name='questNo' value='" + data[i].quest.questNo + "'>";
                            str += "    <i class='ti-control-record text-primary mr-2'></i>";
                            str += "    <span>식물 경험치 +" + data[i].quest.questReward + "</span>";
                            str += "  </div>";
                            str += "  <p class='mb-0 font-weight-thin text-gray questContents'>" + data[i].quest.questContents + "</p>";
                            str += "  <p class='mb-0 font-weight-thin text-gray'>" + data[i].currentCnt + " / " + data[i].quest.questTargetCnt + "</p>";
                            if (data[i].canComplete) {  // 서버에서 전송된 완료 가능 여부 확인
                                str += "  <div class='quest-item'>";
                                str += "    <button type='button' class='btn-complete btn-primary btn-sm'> 완료 </button>";
                                str += "  </div>";
                            }
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

    updateQuestList();
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