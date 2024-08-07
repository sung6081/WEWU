<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
   <link rel="stylesheet" href="/js/select.dataTables.min.css">
   <!-- End plugin css for this page -->
   <!-- inject:css -->
   <link rel="stylesheet" href="/css/vertical-layout-light/style.css">
   <link rel="stylesheet" href="/css/index.css">
   <link rel="stylesheet" href="/css/swiper.css">
   <!-- endinject -->
   <link rel="shortcut icon" href="/images/favicon.ico" />
   <link rel="stylesheet" href="/vendors/mdi/css/materialdesignicons.min.css">
   <!-- swiper -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

   <!-- Font Awesome CDN 추가 -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
   <script src="/js/swiper.js"></script>
   <!-- footer 고정제거 -->
   <script type="text/javascript">
   </script>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <title>WEWU</title>
   <style>
     .navbar-header img {
       width: auto;
       display: flex;
       justify-content: center;
       align-items: center;
       height: 80px;
       /* Adjust this value to the desired height */
       max-width: 100%;
     }

     .navbar-header {
       width: 100%;
       display: flex;
       justify-content: center;
       align-items: center;
       background-color: transparent;
     }

     .navbar {
       border-bottom: none;
     }

     .navbar-nav .nav-item .nav-link:hover {
       color: #00A06C;
       /* Change this to the desired text color on hover */
     }

     .navbar-nav .nav-item .nav-link {
       color: #000000;
       /* Change this to the desired text color on hover */
     }

     .navbar.navbar-white {
       background-color: #000000;
       background-color: rgba(255, 255, 255, 0.8);
       /* Change this to the desired background color */
     }

     .navbar-toggler-icon {
       background-color: #000000;
       /* 여기에 원하는 색상 코드를 넣으세요 */
     }

     .navbar-collapse.collapse.show {
       background-color: #fff;
       display: block;
       /* 배경색을 원하는 색상으로 설정하세요 */
     }
     a{
     font-size : 15px;
     
     }
   </style>
 </head>

 <body>
   <div class="fixed-top">
     <header class="navbar navbar-expand-lg navbar-light" style="height: 100px;">
       <div class="container-fluid" style="display: flex; justify-content: center;">
         <a class="navbar-header" href="/index.jsp">
           <img src="/images/wewu.png" alt="WEWU Title">
         </a>
       </div>
     </header>
     <!-- Navbar -->
     <nav class="navbar navbar-expand-lg navbar-white navbar-custom-height">
       <div class="container-fluid">
         <a class="navbar-brand" href="/index.jsp"> <img src="/images/wewuhome.png" alt="Skydash"
             style="height: 40px;">
         </a>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown"
           aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
           <span class="mdi mdi-chevron-double-down"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarNavDropdown">
           <ul class="navbar-nav wewu">
             <li class="nav-item"><a class="nav-link" href="/board/listBoard?boardType=1">게시판</a></li>
             <li class="nav-item"><a class="nav-link" href="/group/mainGroup.jsp">모임</a></li>
             <li class="nav-item"><a class="nav-link" href="/active/activeMap">모임활동지도</a></li>
             <li class="nav-item">
               <c:if test="${ empty user }">
                 <a class="nav-link" href="/plant/emptyUser.jsp">식물키우기</a>
               </c:if>
               <c:if test="${ ! empty user}">
                 <a class="nav-link" href="/plant/getMyPlant">식물키우기</a>
               </c:if>
             </li>
             <li class="nav-item"><a class="nav-link" href="/item/getItemList">아이템상점</a></li>
             <!-- 관리자모드 -->
             <c:if test="${sessionScope.isAdmin}">
               <li class="nav-item dropdown">
                 <a class="nav-link" href="#" id="adminDropdown" role="button" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                   관리자 모드
                 </a>
                 <div class="dropdown-menu" aria-labelledby="adminDropdown">
                   <!-- Menu 1 with nested dropdown -->
                   <div class="dropdown">
                     <a class="dropdown-item" href="/user/listUser">회원관리</a>
                   </div>
                   <!-- Menu 2 with nested dropdown -->
                   <div class="dropdown">
                     <a class="dropdown-item" href="/board/listDonation?payType=B">후원관리</a>
                   </div>
                   <!-- Menu 3 with nested dropdown -->
                   <div class="dropdown">
                     <a class="dropdown-item" href="/item/getItemList" aria-haspopup="true"
                       aria-expanded="false">아이템판매관리</a>
                   </div>
                   <!-- Menu 4 with nested dropdown -->
                   <div class="dropdown">
                     <a class="dropdown-item" href="/plant/addPlant">식물관리</a>
                   </div>
                 </div>
               </li>
             </c:if>
             <!-- 관리자모드 -->
           </ul>
           <ul class="navbar-nav ml-auto">
             <c:if test="${ empty user }">
               <li class="nav-item">
                 <a class="nav-link" href="/user/addUserView.jsp">회원가입</a>
               </li>
               <li class="nav-item">
                 <a class="nav-link " href="/user/login">Login</a>
               </li>
             </c:if>
             <c:if test="${ ! empty user }">
               <ul class="navbar-nav ml-auto">
                 <c:if test="${ empty user }">
                   <li class="nav-item">
                     <a class="nav-link" href="/user/addUserView.jsp">회원가입</a>
                   </li>
                   <li class="nav-item">
                     <a class="nav-link" href="/user/login">Login</a>
                   </li>
                 </c:if>
               </ul>
               <c:if test="${ ! empty user }">
                 <c:choose>
                   <c:when test="${user.role == '1'}">
                     <li class="nav-item">
                       <a class="nav-link">
                         ${user.nickname} 관리자
                       </a>
                     </li>
                     <li>
                     <a class="nav-link" href="/user/logout">LogOut</a>
                     </li>
                   </c:when>
                   <c:otherwise>
                     <li class=" nav-item dropdown">
                       <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                         "${user.nickname}"님 환영합니다 ! &nbsp;&nbsp; Point : ${user.currentPoint} p
                       </a>
                       <div class="dropdown-menu" aria-labelledby="userDropdown">
                         <a class="dropdown-item" href="/user/myInfo">마이페이지</a>
                         <a class="dropdown-item" href="/group/mainGroup.jsp">내모임</a>
                         <a class="dropdown-item" href="/pay/getPointChargeList">결제관리</a>
                         <a class="dropdown-item" href="/user/logout">LogOut</a>
                       </div>
                     <li class="nav-settings">
                       <div class="d-flex justify-content-center align-items-center w-100"
                         style="height: 100%;">
                         <button type="button" class="btn btn-outline-success btn-fw btn-sm"
                           data-toggle="tooltip" data-placement="top" title="새로운 퀘스트를 확인해 보세요!">
                           Quest
                         </button>
                       </div>
                     </li>
           </ul>
           
           </li>
           </c:otherwise>
           </c:choose>
           </c:if>

           </c:if>
         </div>
       </div>
     </nav>
   </div>
   <jsp:include page="/plant/getQuestList.jsp" />
 </body>

 </html>