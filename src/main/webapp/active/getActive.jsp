<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>활동 상세 조회</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>

<h3>activeNo</h3><span>${active.activeNo}</span><br/>
<h3>groupNo</h3><span>${active.groupNo}</span><br/>
<h3>activeName</h3><span>${active.activeName}</span><br/>
<h3>activeStratDate</h3><span>${active.activeStartDate}</span><br/>
<h3>activeEndDate</h3><span>${active.activeEndDate}</span><br/>
<h3>activeX</h3><span>${active.activeX}</span><br/>
<h3>activeY</h3><span>${active.activeY}</span><br/>
<h3>activeStartTime</h3><span>${active.activeStartTime}</span><br/>
<h3>activeEndTime</h3><span>${active.activeEndTime}</span><br/>
<h3>activeInfo</h3><span>${active.activeInfo}</span><br/>
<h3>activeLocal</h3><span>${active.activeLocal}</span><br/>
<h3>activeRegDate</h3><span>${active.activeRegDate}</span><br/>
<h3>stateFlag</h3><span>${active.stateFlag}</span><br/>
<h3>activeUrl</h3><span>${active.activeUrl}</span><br/>
<h3>activeShortUrl</h3><span>${active.activeShortUrl}</span><br/>
<h3>leaderNick</h3><span>${active.leaderNick}</span><br/>
<c:forEach var="hash" items="${active.hashList}">
	<h3>hash</h3><span>${hash.hashName}</span><br/>
</c:forEach>

</body>
</html>