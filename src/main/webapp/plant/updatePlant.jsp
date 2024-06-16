<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>
	<form method="post" action="/plant/updatePlant"  >

		<input type="hidden" name="plantNo" value="${plant.plantNo}" >
	
		<h2>식물이름</h2>
		<input type="text" name="plantName" value="${plant.plantName}" >
		<br/>	
		
		<input type="submit" value="등록하기">
	</form>
</body>
</html>