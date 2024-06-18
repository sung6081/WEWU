<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verification</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>사용자 정보 입력 및 인증번호 전송</h1>
    <form id="userInfoForm">
        <label for="userName">사용자 이름:</label>
        <input type="text" id="userName" name="userName" required />
        <br/>
        <label for="phoneNum">전화번호:</label>
        <input type="text" id="phoneNum" name="phoneNum" required />
        <br/>
        <button type="button" id="sendVerificationCode">인증번호 전송</button>
    </form>

    <h1>인증번호 입력</h1>
    <form id="verificationForm" action="/user/verify-code-userId" method="post">
        <input type="hidden" id="verificationPhoneNum" name="phoneNum" value="${user.phoneNum}" />
        <input type="hidden" id="verificationUserName" name="userName" value="${user.userName}" />
        <label for="code">인증번호:</label>
        <input type="text" id="code" name="code" required />
        <button type="submit">확인</button>
    </form>
    
    <form id="resendForm" action="/user/send-verification-code" method="post">
        <input type="hidden" id="resendPhoneNum" name="phoneNum" value="${phoneNum}" />
        <input type="hidden" id="resendUserName" name="userName" value="${userName}" />
        <button type="submit">인증번호 재발송</button>
    </form>
    
    <div id="errorMessage" style="color: red;">
        <c:if test="${not empty error}">
            ${error}
        </c:if>
    </div>

    <script>
        $(document).ready(function() {
            $("#sendVerificationCode").click(function() {
                var userName = $("#userName").val();
                var phoneNum = $("#phoneNum").val();
                
                $.ajax({
                    url: "/user/send-verification-code",
                    type: "POST",
                    data: { userName: userName, phoneNum: phoneNum },
                    success: function(response) {
                        $("#errorMessage").text("인증번호가 전송되었습니다.");
                        $("#verificationPhoneNum").val(phoneNum);
                        $("#verificationUserName").val(userName);
                        $("#resendPhoneNum").val(phoneNum);
                        $("#resendUserName").val(userName);
                    },
                    error: function(xhr, status, error) {
                        $("#errorMessage").text("인증번호 전송에 실패했습니다.");
                    }
                });
            });
        });
    </script>
</body>
</html>
