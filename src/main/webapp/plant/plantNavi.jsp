<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
  <div class="container mt-5">
    <div class="text-center">
      <div class="btn-group d-inline-block" role="group" aria-label="Basic example">
      <c:if test="${ empty user }">
        <a href="/plant/getMyPlant.jsp" class="btn btn-success">My Plant</a>
      </c:if>
      <c:if test="${ ! empty user }">
        <a href="/plant/getMyPlant" class="btn btn-success">My Plant</a>
      </c:if>     
      <c:if test="${ empty user }">
        <a href="/plant/getMyPlant.jsp" class="btn btn-info">Inventory</a>
      </c:if>
      <c:if test="${ ! empty user }">
        <a href="/plant/inventory" class="btn btn-info">Inventory</a>
      </c:if>  
      <c:if test="${ empty user }">
        <a href="/plant/getMyPlant.jsp" class="btn btn-primary">History</a>
      </c:if>
      <c:if test="${ ! empty user }">
        <a href="/plant/history" class="btn btn-primary">History</a>
      </c:if>   
      </div>
    </div>
  </div>
</body>
</html>