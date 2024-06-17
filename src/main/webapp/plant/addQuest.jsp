<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>
	<form action="/plant/addQuest" method="POST">
	
		<h2>닉네임</h2>
		<input type="text" name="nickName" >
		<br/>
		
		<h2>퀘스트내용</h2>
		<input type="text" name="questContents">
		<br/>
		
		<h2>퀘스트목표</h2>
		<input type="text" name="questTarget">
		<br/>
		
		<h2>퀘스트보상</h2>
		<input type="text" name="questReward">
		<br/>
		
		<h2>퀘스트목표치</h2>
		<input type="text" name="questTargetCnt">
		<br/>
		
		<h2>퀘스트상태</h2>
		<input type="text" name="questState">
		<br/>
		
		<input type="submit" value="등록하기">
	</form>
</body>
</html>