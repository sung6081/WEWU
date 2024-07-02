<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.jumbotron
{
    padding: 6rem 2rem;
	background-color: #00A06C;
	margin-top:160px;
	margin-bottom:0;
	background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
	background-image: url(); /* 배경 이미지 경로 */
	background-size: cover; /* 이미지가 컨테이너를 덮도록 */
	background-position: center; /* 이미지가 중앙에 위치하도록 */
}
.main-panel
{
	margin:0;
}
</style>
<c:if test="${group.groupImg != null }">
<div class="jumbotron" style="background-image:url(/group/upload/${group.groupImg});">
</c:if>
<c:if test="${group.groupImg == null }">
<div class="jumbotron" style="background-image:url(/group/img/illustration.jpg);">
</c:if>
  <div class="container">
    <p class="display-4"></p>
  </div>
</div>