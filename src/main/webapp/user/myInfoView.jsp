<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Update User Info</title>
</head>
<body>
    <h1>Update User Info</h1>
    <form action="/user/updateAdmin" method="post">
        <input type="hidden" name="userId" value="${user.userId}">
        <label for="userName">Name:</label>
        <input type="text" id="userName" name="userName" value="${user.userName}" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${user.email}" required><br>
        <label for="phoneNum">Phone:</label>
        <input type="text" id="phoneNum" name="phoneNum" value="${user.phoneNum}" required><br>
        <label for="nickname">Nickname:</label>
        <input type="text" id="nickname" name="nickname" value="${user.nickname}" required><br>
        <label for="addr">Address:</label>
        <input type="text" id="addr" name="addr" value="${user.addr}" required><br>
        <label for="getAddr">Get Address:</label>
        <input type="text" id="getAddr" name="getAddr" value="${user.getAddr}" required><br>
        <label for="userPwd">Password:</label>
        <input type="password" id="userPwd" name="userPwd" required><br>
        <input type="submit" value="Update">
    </form>
</body>
</html>
