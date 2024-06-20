<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- 필요한 메타 데이터 및 CSS/JS 링크 포함 -->
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <!-- plugins:js -->
 <script src="/vendors/js/vendor.bundle.base.js"></script>
 <!-- endinject -->
 <!-- Plugin js for this page -->
 <script src="/vendors/chart.js/Chart.min.js"></script>
 <script src="/vendors/datatables.net/jquery.dataTables.js"></script>
 <script src="/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
 <script src="/js/dataTables.select.min.js"></script>
 <!-- End plugin js for this page -->
 <!-- inject:js -->
 <script src="/js/off-canvas.js"></script>
 <script src="/js/hoverable-collapse.js"></script>
 <script src="/js/template.js"></script>
 <script src="/js/settings.js"></script>
 <script src="/js/todolist.js"></script>
 <!-- endinject -->
 <!-- Custom js for this page-->
 <script src="/js/dashboard.js"></script>
 <script src="/js/Chart.roundedBarCharts.js"></script>
 <!-- dropdown -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <!-- plugins:css -->
 <link rel="stylesheet" href="/vendors/feather/feather.css">
 <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
 <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
 <!-- endinject -->
 <!-- Plugin css for this page -->
 <link rel="stylesheet" href="/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
 <link rel="stylesheet" type="/text/css" href="/js/select.dataTables.min.css">
 <!-- End plugin css for this page -->
 <!-- inject:css -->
 <link rel="stylesheet" href="/css/vertical-layout-light/style.css">
 <link rel="stylesheet" href="/css/index.css">
 <link rel="stylesheet" href="/css/swiper.css">
 <!-- endinject -->
 <link rel="shortcut icon" href="/images/favicon.ico" />
 <!-- swiper -->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
 <script src="/js/swiper.js"></script>
 <!-- footer 고정제거 -->
 <script type="text/javascript">
   $('footer').removeClass('fixed-bottom');
 </script>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>WEWU</title>
</head>
<body>

  <div class="fixed-top">
    <header class="navbar navbar-expand-lg navbar-light bg-light" style="height: 100px;">
     <div class="container d-flex justify-content-center">
       <span class="navbar-brand mb-0 h1">WEWU</span>
     </div>
   </header>
   <!-- Navbar -->
   <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-custom-height">
     <div class="container-fluid">
       <a class="navbar-brand" href="/index.jsp"> <img src="/images/logo.svg" alt="Skydash"
           style="height: 40px;">
       </a>
       <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown"
         aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
       </button>
       <div class="collapse navbar-collapse bg-light" id="navbarNavDropdown">
         <ul class="navbar-nav mr-auto">
           <li class="nav-item"><a class="nav-link" href="/board/listBoard?boardType=1">게시판</a></li>
           <li class="nav-item"><a class="nav-link" href="/group/mainGroup.jsp">모임</a></li>
           <li class="nav-item"><a class="nav-link" href="/active/activeMap">모임활동지도</a></li>
           <li class="nav-item">
             <c:if test="${ empty user }">
               <a class="nav-link" href="/plant/emptyUser.jsp">식물키우기</a>
             </c:if>
             <c:if test="${ ! empty user }">
               <a class="nav-link" href="/plant/getMyPlant">식물키우기</a>
             </c:if>
           </li>
           <li class="nav-item"><a class="nav-link" href="/item/getItemList">아이템상점</a></li>
           <!-- 관리자모드 -->
           <li class="nav-item dropdown">
             <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
               관리자 모드
             </a>
             <div class="dropdown-menu" aria-labelledby="adminDropdown">
               <!-- Menu 1 with nested dropdown -->
               <div class="dropdown-submenu">
                 <a class="dropdown-item dropdown-toggle" href="#">회원관리</a>
                 <ul class="dropdown-menu">
                   <li><a class="dropdown-item" href="#">회원목록</a></li>
                 </ul>
               </div>
               <!-- Menu 2 with nested dropdown -->
               <div class="dropdown-submenu">
                 <a class="dropdown-item dropdown-toggle" href="#">아이템판매관리</a>
                 <ul class="dropdown-menu">
                   <li><a class="dropdown-item" href="/item/addItem">아이템 판매 등록</a></li>
                   <li><a class="dropdown-item" href="/item/updateItem?itemNo=1">아이템 판매 수정</a></li>
                   <li><a class="dropdown-item" href="/item/getItemSalesHistoryList">아이템 판매 내역</a></li>
                 </ul>
               </div>
               <!-- Menu 3 with nested dropdown -->
               <div class="dropdown-submenu">
                 <a class="dropdown-item dropdown-toggle" href="#">후원관리</a>
                 <ul class="dropdown-menu">
                   <li><a class="dropdown-item" href="#">후원목록</a></li>
                 </ul>
               </div>
               <!-- Menu 4 with nested dropdown -->
               <div class="dropdown-submenu">
                 <a class="dropdown-item dropdown-toggle" href="#">식물관리</a>
                 <ul class="dropdown-menu">
                   <li><a class="dropdown-item" href="/plant/addPlant.jsp">식물등록</a></li>
                   <li><a class="dropdown-item" href="/plant/listPlant.jsp">식물관리</a></li>
                   <li><a class="dropdown-item" href="/plant/addQuest.jsp">퀘스트등록</a></li>
                   <li><a class="dropdown-item" href="/plant/listQuest.jsp">퀘스트관리</a></li>
                 </ul>
               </div>
             </div>
           </li>
           <!-- 관리자모드 -->
          </ul>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link btn btn-primary text-white " href="/login">Login</a>
            </li>
            <li class="nav-item nav-settings">
              <a class="nav-link" href="#">
                <i class="icon-ellipsis"></i>
              </a>
            </li>
          </ul>
          <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
            data-toggle="offcanvas">
            <span class="icon-menu"></span>
          </button>
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
        </div>
      </div>
    </nav>
  </div>
</body>


</html>