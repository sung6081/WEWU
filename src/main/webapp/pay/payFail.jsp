<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script>
	if("${flag}" == "a")
	{
		alert("결제 실패하였습니다. \n상점 홈으로 이동합니다.");
		location.href="/item/getItemList";	
	}else
	{
		alert("후원을 실패하였습니다. \n후원 게시판으로 이동합니다.");
		location.href="/board/listBoard?boardType=4";
	}
	
</script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>