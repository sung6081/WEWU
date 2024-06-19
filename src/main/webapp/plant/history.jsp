<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>List Plant</title>
  
  <style>
    .table-container {
      max-height: 600px; /* 원하는 높이 설정 */
      overflow-y: auto;
    }
    
    .table-container::-webkit-scrollbar {
      width: 12px;  /* 스크롤바의 너비 */
    }
    .table-container::-webkit-scrollbar-thumb {
      height: 30%; /* 스크롤바의 길이 */
      background: #4B49AC; /* 스크롤바의 색상 */
      border-radius: 10px;
    }
    .table-container::-webkit-scrollbar-track {
      background: rgba(33, 122, 244, .1);  /*스크롤바 뒷 배경 색상*/
    }
  </style>
</head>
<body>
  <jsp:include page="/header.jsp" flush="true" />
  <jsp:include page="/side.jsp" />
  <div class="main-panel">
    <div class="content-wrapper">
      <div class="row mt-5">
        <div class="col-lg-10 grid-margin stretch-card mx-auto">
          <div class="card">
            <div class="card-body">
              <h4 class="card-title">HISTORY</h4>
              <p class="card-description">
                History <code> 과거에 키웠던 식물 목록</code>
              </p>
              <div class="table-container">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th>과거 나의 식물들</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="myPlant" items="${map.list}" varStatus="status">
                      <tr>
                        <td class="plantNo">최신순 과거순 경험치 높은 순 경험치 낮은 순</td>
                        <tr class="plantName">
                        	<c:if test="${myPlant.myPlantState eq 'N' }">
                        		<td>${myPlant.levlImg }</td>
                        		<td>${myPlant.levlImg }</td>
                        		<td>${myPlant.levlImg }</td>
                        		<td>${myPlant.levlImg }</td>
                        		<td>${myPlant.levlImg }</td>
                        	</c:if>
                        </tr>
                        <td><label class="badge badge-success">수정</label></td>
                    </c:forEach>                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- 헤더 부분 추가 -->
  <header id="wewu">
    <span>WEWU</span>
  </header>

  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->
</body>
</html>
