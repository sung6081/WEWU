<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<!-- HEADER -->
<jsp:include page="/header.jsp" />
<!-- HEADER -->
    
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
    $(function () {
    $(".badge").on("click", function () {
      var questNo = $(this).data("questno");
      self.location = "/plant/updateQuest?questNo="+questNo;
    });
  });
</script>
<style>
.jumbotron {

        background-color: #00A06C;
        margin-top: 160px;
        margin-bottom: 0;
        background-size: contain;
        /* 이미지가 컨테이너 안에 맞도록 */
        background-image: url('/images/jumbo2.jpg');
        /* 배경 이미지 경로 */
        background-size: cover;
        /* 이미지가 컨테이너를 덮도록 */
        background-position: center;
        /* 이미지가 중앙에 위치하도록 */

      }
      

      .display-4 {
        color: #fff;
        /* 원하는 색상으로 변경 */
      }

      .main-panel {
        margin: 0;
      }
</style>
</head>
<body>
	
<div class="jumbotron">
  <div class="container">
    <p class="display-4"><b>LIST QUEST</b></p>
  </div>
</div>
<jsp:include page="/plant/plantSide.jsp" />
<div class="main-panel">
  
    <div class="content-wrapper">
        <div class="row mt-5">
            <div class="col-lg-12 grid-margin stretch-card mx-auto">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">List Quest</h4>
                        <p class="card-description">
                            Manage Quest <code>.퀘스트 수정 & 관리</code>
                        </p>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Quest No</th>
                                    <th>Reg Date</th>
                                    <th>Quest Contents</th>
                                  
                                    <th>Quest Target</th>
                                    <th>Quest Target Count</th>
                                    <th>Quest Reward</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="quest" items="${list}">
                                    <tr>
                                        <td>${quest.questNo}</td>
                                        <td>${quest.regDate}</td>
                                        <td>${quest.questContents}</td>
                             
                                        <td>${quest.questTarget}</td>
                                        <td>${quest.questTargetCnt}</td>
                                        <td>${quest.questReward}</td>
                                        <td>
                        					<a type = "button" class="badge badge-warning" data-questno="${quest.questNo}">수정</a>
                       					</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    	<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	<!-- FOOTER -->
</div>
</body>
</html>
