<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>
<form method="post" action="/quest/updateQuest" >

	<input type="hidden" name="questNo" value="${questNo}" >

	<h2>퀘스트내용</h2>
	<input type="text" name="questContents" value="${quest.questContents}" >
	<br/>	

	<h2>퀘스트보상</h2>
	<input type="text" name="questReward" value="${quest.questReward}" >
	<br/>
	
	<h2>퀘스트목표</h2>
	<input type="text" name="questTarget" value="${quest.questTarget}" >
	<br/>
	
	<h2>퀘스트목표치</h2>
	<input type="text" name="questTargetCnt" value="${quest.questTargetCnt}" >
	<br/>
	
	<input type="submit" value="등록하기">
	</form>
</body>
</html>