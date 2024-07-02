<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style>
    .sidebar {
        background-color: #ffffff; /* 원하는 배경색으로 변경 */
    }
      .sidebar-offcanvas {

    margin:0;
  
  }
</style>
</head>
<body>
	<!-- partial:partials/_sidebar.html -->
    <div class="container-fluid">
    	<div class="row">
		    <nav class="sidebar sidebar-offcanvas" id="sidebar">
		      <ul class="nav">
		        <li class="nav-item">
		          <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
		            <i class="icon-layout menu-icon"></i>
		            <span class="menu-title">Plant Management</span>
		            <i class="menu-arrow"></i>
		          </a>
		          <div class="collapse" id="ui-basic">
		            <ul class="nav flex-column sub-menu">
		              <li class="nav-item"> <a class="nav-link" href="/plant/addPlant.jsp">식물 등록</a></li>
		              <li class="nav-item"> <a class="nav-link" href="/plant/listPlant">식물 관리</a></li>
		            </ul>
		          </div>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" data-toggle="collapse" href="#form-elements" aria-expanded="false" aria-controls="form-elements">
		            <i class="icon-columns menu-icon"></i>
		            <span class="menu-title">Quest Management</span>
		            <i class="menu-arrow"></i>
		          </a>
		          <div class="collapse" id="form-elements">
		            <ul class="nav flex-column sub-menu">
		              <li class="nav-item"><a class="nav-link" href="/plant/addQuest.jsp">퀘스트 등록</a></li>
		              <li class="nav-item"><a class="nav-link" href="/plant/listQuest">퀘스트 관리</a></li>
		            </ul>
		          </div>
		        </li>
		      </ul>
		    </nav>
</body>
</html>