<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

	function addBookmark(boardNo){
		
		var formData = {
				boardNo: boardNo,
				nickName: "nick1"
		};
		
		$.ajax ({
			url	: "/app/board/addBookmark", // (Required) 요청이 전송될 URL 주소
			type	: "POST", // (default: ‘GET’) http 요청 방식
			async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
			cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
			timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
			data  : JSON.stringify(formData), // 요청 시 전달할 데이터
			processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
			contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
			dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
			beforeSend  : function () {
			  // XHR Header 포함, HTTP Request 하기전에 호출
			  
			},
			success : function(data, status, xhr) {
			
				if(data.flag == "Y"){
					alert("북마크 완료.");
					location.reload();
				}else{
					alert("북마크 실패");
				}
			},
			error	: function(xhr, status, error) {
			  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
			},
			complete : function(xhr, status) {
			  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
			}
		});
    }
	
	function deleteBookmark(boardNo) {
		var formData = {
			boardNo: boardNo
		};

		$.ajax({
			url: "/app/board/deleteBookmark",
			type: "POST",
			async: true,
			cache: true,
			timeout: 3000,
			data: JSON.stringify(formData),
			processData: true,
			contentType: "application/json",
			dataType: "json",
			success: function(data, status, xhr) {
				if(data.flag == "Y"){
					alert("삭제 완료.");
					location.reload();
				}else{
					alert("삭제 실패");
				}
			},
			error: function(xhr, status, error) {
				alert("삭제 실패.");
			}
		});
    }
</script>

</head>
<body>
<input type="hidden" name="boardType" value="${param.boardType}" >
	
	<table>
	<thead>
		<tr>게시글 종류</tr>
		<tr>No</tr>
		<tr>제목</tr>
		<tr>닉네임</tr>
		<tr>등록일</tr>
		<tr>썸네일 이미지 번호</tr>
		<tr>즐겨찾기 수</tr>
		<tr>조회수</tr>
		<tr>댓글 수</tr>
		<tr>북마크 플래그</tr>
	</thead>
	<tbody>
		<c:forEach var="board" items="${list}">
		<tr>
			<td>${board.boardType}</td>
			<td>${board.boardNo}</td>
			<td>${board.title}</td>
			<td>${board.nickName}</td>
			<td>${board.regDate}</td>
			<td>${board.thumnail}</td>
			<td>${board.bookmarkCnt}</td>
			<td>${board.views}</td>
			<td>${board.commentCnt}</td>
			<td>${board.bookmarkFlag}
				<form id="bookmarkForm">
				<input type="hidden" name="nickName" id="nickName" value="nick1">
				<input type="hidden" name="boardNo" id="boardNo" value="${board.boardNo}">
				</form>
				
				<a href="javascript:addBookmark(${board.boardNo});">즐겨찾기 추가</a>
				<a href="javascript:deleteBookmark(${board.boardNo});">즐겨찾기 삭제</a>
			</td>

		</tr>
		</c:forEach>
	</tbody>
</table>
	
	<br/>

</body>
</html>