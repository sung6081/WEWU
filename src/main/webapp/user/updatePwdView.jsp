<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<script>
		function check()
		{
			var d = document.getElementById("newPassword").value;
			var c = document.getElementById("confirmPassword").value;
			if(d != c)
			{
				alert("비밀번호 확인하세요");
			}else
			{
				var form = document.getElementById("myForm");
				form.submit();
			}
		}
	</script>
    <title>비밀번호 변경</title>
</head>
<body>
    <h1>비밀번호 변경</h1>
    <form id="myForm" action="/user/updatePwd" method="post">
        <input type="hidden" name="userId" value="${userId}" />
        <label for="newPassword">새 비밀번호:</label>
        <input type="password" id="newPassword" name="newPassword" required />
        <br/>
        <label for="confirmPassword">새 비밀번호 확인:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required />
        <br/>
        <a href="javascript:check();">비밀번호 변경</a>
    </form>
    
    <div id="errorMessage" style="color: red;">
        <c:if test="${not empty error}">
            ${error}
        </c:if>
    </div>
</body>
</html>
