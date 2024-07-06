<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
         <li class="nav-item">
            <a class="nav-link collapsed" data-toggle="collapse" href="#charts" aria-expanded="false" aria-controls="charts">
              <i class="icon-bar-graph menu-icon"></i>
              <span class="menu-title">공지사항</span>
             
            </a>
            <div class="collapse" id="charts" style="">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link notice">공지사항</a></li>
              </ul>
            </div>
          </li>

        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <i class="icon-layout menu-icon"></i>
              <span class="menu-title">문의</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> 
                    <a class="nav-link" href="/board/listQuestion?questionType=자주">FAQ</a>
                </li>
                <li class="nav-item"> 
                    <a class="nav-link" href="/board/listQuestion?questionType=문의">1:1문의</a>
                </li>
              </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#meetings" aria-expanded="false" aria-controls="meetings">
              <i class="icon-head menu-icon"></i>
              <span class="menu-title">모임</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="meetings">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> 
                    <a class="nav-link" href="/board/listBoard?boardType=2"> 모임 홍보 </a>
                </li>
                <li class="nav-item"> 
                    <a class="nav-link" href="/board/listBoard?boardType=3"> 모임 후기 </a>
                </li>
              </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#sponsorship" aria-expanded="false" aria-controls="sponsorship">
              <i class="icon-ban menu-icon"></i>
              <span class="menu-title">후원</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="sponsorship">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> 
                    <a class="nav-link" href="/board/listBoard?boardType=4"> 후원 하기 </a>
                </li>
                <c:if test="${isAdmin}">
	                <li class="nav-item"> 
	                    <a class="nav-link" href="/board/listDonation?payType=B"> 후원 내역 보기 </a>
	                </li>
	             </c:if>
              </ul>
            </div>
        </li>
    </ul>
</nav>

<script>
$(document).ready(function() {
    // Set the active class on the sidebar based on the current URL
    var currentUrl = window.location.href;
    $('#sidebar .nav-item a').each(function() {
        if (this.href === currentUrl) {
            $(this).parent().addClass('active');
            $(this).closest('.collapse').addClass('show');
        }
    });
});
$(function(){
	$(".notice").on("click", function() {
        self.location = "/board/listBoard?boardType=1";
    });
})
</script>

</body>
</html>
