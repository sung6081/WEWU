<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>loginView</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(function() {
            let captchaKey = '';
            let loginAttempts = 0; // 로그인 시도 횟수

            function loadCaptcha() {
                $.get("/captcha/key", function(data) {
                    if (data.success) {
                        captchaKey = data.key.match(/"key":"(\w+)"/)[1];
                        $("#captcha-image").attr("src", "https://naveropenapi.apigw.ntruss.com/captcha-bin/v1/ncaptcha?key=" + captchaKey);
                    } else {
                        alert("캡차를 불러오는 중 오류가 발생했습니다.");
                    }
                });
            }

            function showCaptcha() {
                $("#captcha-section").show();
                loadCaptcha();
            }

            function hideCaptcha() {
                $("#captcha-section").hide();
            }

            hideCaptcha(); // 초기에는 캡차를 숨김

            $("#userId").focus();

            function login() {
                var id = $("#userId").val();
                var pw = $("#password").val();
                var captchaValue = $("#captcha").val();

                if (id == null || id.length < 1) {
                    alert('ID 를 입력하지 않으셨습니다.');
                    $("#userId").focus();
                    return;
                }

                if (pw == null || pw.length < 1) {
                    alert('패스워드를 입력하지 않으셨습니다.');
                    $("#password").focus();
                    return;
                }

                var requestData = {
                    userId: id,
                    userPwd: pw
                };

                if (loginAttempts >= 3) {
                    if (captchaValue == null || captchaValue.length < 1) {
                        alert('캡차 값을 입력하지 않으셨습니다.');
                        $("#captcha").focus();
                        return;
                    }
                    requestData.captcha = captchaValue;
                    requestData.captchaKey = captchaKey;
                }

                $.ajax({
                    url: "/user/login",
                    method: "POST",
                    data: requestData,
                    success: function(response) {
                        if (response.success) {
                            window.location.href = "/index.jsp";
                        } else {
                            loginAttempts++;
                            alert('로그인에 실패하였습니다. \n' + response.error);
                            if (response.error === "삭제처리 되었습니다." || response.error === "정지처리 되었습니다.") {
                                alert("로그인이 제한된 계정입니다");
                            }
                            if (loginAttempts >= 3) {
                                showCaptcha();
                            }
                        }
                    },
                    error: function() {
                        loginAttempts++;
                        alert('로그인 중 오류가 발생했습니다.');
                        if (loginAttempts >= 3) {
                            showCaptcha();
                        }
                    }
                });
            }

            $("a.login-btn").on("click", function(event) {
                event.preventDefault();
                login();
            });

            $("a.register-link").on("click", function(event) {
                event.preventDefault();
                self.location = "/user/addUser";
            });

            $("a.find-id").on("click", function(event) {
                event.preventDefault();
                self.location = "/user/findUserId";
            });

            $("a.find-pw").on("click", function(event) {
                event.preventDefault();
                self.location = "/user/findPwd";
            });

            $("#reload-captcha").on("click", function() {
                loadCaptcha();
            });

            // 페이지 로드 시 로그인 시도 횟수 확인
            $.get("/user/loginAttempts", function(data) {
                loginAttempts = data.loginAttempts;
                if (loginAttempts >= 3) {
                    showCaptcha();
                }
            });

            // 엔터 키 이벤트 처리
            $(document).on("keypress", function(event) {
                if (event.which === 13) {
                    login();
                }
            });
        });
    </script>
    <style>
        .welcome-message {
            width: 100%;
            text-align: center;
            margin-bottom: 20px;
            font-size: 2em;
        }

        .auth-form-light {
            padding: 60px 50px;
        }

        .form-control-lg {
            height: calc(2.875rem + 2px);
            padding: 1.5rem 1rem;
            font-size: 1.25rem;
        }

        .btn-lg {
            padding: 0.75rem 1.5rem;
            font-size: 1.25rem;
        }

        .font-weight-light {
            font-size: 1.5rem;
            text-align: center;
        }

        .text-primary {
            font-size: 1.25rem;
        }

        .link-group {
            text-align: center;
            margin-top: 15px;
        }

        .link-group a {
            margin: 0 10px;
            font-size: 1rem;
            color: black;
            text-decoration: none;
        }

        .link-group a:hover {
            text-decoration: underline;
        }

        #captcha-section {
            display: none;
        }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"/>
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="row w-100 mx-0">
                <div class="col-lg-4 mx-auto">
                    <div class="auth-form-light text-left py-5 px-5 px-sm-6">
                        <div class="brand-logo"></div>
                        <h3 class="welcome-message">WeWu에 오신걸 환영합니다.</h3>
                        <h6 class="font-weight-light">로그인을 진행해주세요.</h6>
                        <form class="pt-3">
                            <div class="form-group">
                                <input type="text" class="form-control form-control-lg" name="userId" id="userId" placeholder="아이디">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control form-control-lg" name="userPwd" id="password" placeholder="패스워드">
                            </div>
                            <div id="captcha-section" class="form-group">
                                <img id="captcha-image" src="" alt="CAPTCHA Image">
                                <button type="button" id="reload-captcha" class="btn btn-secondary">새로고침</button>
                                <input type="text" class="form-control form-control-lg" name="captcha" id="captcha" placeholder="캡차 값">
                            </div>
                            <div class="mt-3">
                                <a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn login-btn" href="#">로 그 인</a>
                            </div>
                            <div class="link-group">
                                <a href="#" class="text-primary register-link">회원가입</a>
                                <a href="#" class="auth-link find-id">아이디 찾기</a>
                                <a href="#" class="auth-link find-pw">비밀번호 찾기</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
