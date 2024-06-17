<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>
	<form action="/plant/addPlant" method="POST">
	
		<h2>식물이름</h2>
		<input type="text" name="plantName">
		<br/>
		
		<h2>최소경험치</h2>
		<input type="text" name="plantMinExp">
		<br/>
		
		<h2>최대경험치</h2>
		<input type="text" name="plantMaxExp">
		<br/>
		<!-- 
		<h2>식물단계</h2>
		<input type="text" name="plantLevl">
		<br/>
		 -->
		<h2>식물최종단계</h2>
		<input type="text" name="plantFinalLevl">
		<br/>
		
		<h2>식물단계별이미지</h2>
		<input type="text" name="levlImg">
		<br/>
		
		<input type="submit" value="등록하기">
		
	</form>
</body>
</html>