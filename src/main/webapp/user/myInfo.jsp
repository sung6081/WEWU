<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>My Info</title>
</head>
<body>
    <h1>My Info</h1>
    <table border="1">
        <tr>
            <th>User ID</th>
            <td>${user.userId}</td>
        </tr>
        <tr>
            <th>Name</th>
            <td>${user.userName}</td>
        </tr>
        <tr>
            <th>Email</th>
            <td>${user.email}</td>
        </tr>
        <tr>
            <th>Phone</th>
            <td>${user.phoneNum}</td>
        </tr>
        <tr>
            <th>Nickname</th>
            <td>${user.nickname}</td>
        </tr>
        <tr>
            <th>Address</th>
            <td>${user.addr}</td>
        </tr>
        <!-- 필요한 다른 필드들 -->
    </table>

	<form action="/user/checkPassword" method="post">
        <input type="hidden" name="userId" value="${user.userId}">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <input type="submit" value="수정 페이지로 이동">
    </form>
    
</body>
</html>
