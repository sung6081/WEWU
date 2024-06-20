<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quest</title>
</head>
<body>
      <div id="right-sidebar" class="settings-panel">
        <i class="settings-close ti-close"></i>
        <ul class="nav nav-tabs border-top" id="setting-panel" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" id="todo-tab" data-toggle="tab" href="#todo-section" role="tab" aria-controls="todo-section" aria-expanded="true">Quest</a>
          </li>
        </ul>
        <div class="tab-content" id="setting-content">
          <div class="tab-pane fade show active scroll-wrapper" id="todo-section" role="tabpanel" aria-labelledby="todo-section">
            <h4 class="px-5 text-muted mt-5 font-weight-light mb-0">Quest</h4>
            <c:forEach var="quest" items="${map.list}">
            <div class="events pt-4 px-3">
              <div class="wrapper d-flex mb-2">
              
                <i class="ti-control-record text-primary mr-2"></i>
                <span>${quest.regDate}</span>
              </div>
              <p class="mb-0 font-weight-thin text-gray">${quest.questContents}</p>
              <p class="text-gray mb-0">${quest.questState}</p>
            </div>
            </c:forEach>
          </div>
          <!-- To do section tab ends -->
        </div>
      </div>
</body>
</html>