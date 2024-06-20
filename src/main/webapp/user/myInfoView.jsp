<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update User Info</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css">
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->
    
    <div class="container-scroller">
        <div class="container-fluid page-body-wrapper full-page-wrapper">
            <div class="content-wrapper d-flex align-items-center auth px-0">
                <div class="row w-100 mx-0">
                    <div class="col-lg-8 mx-auto">
                        <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                            <h4>회원 정보 수정</h4>
                            <form class="pt-3 form-horizontal">
                                <input type="hidden" name="userId" value="${user.userId}">
                                <div class="form-group">
                                    <label for="userName" class="col-sm-3 control-label">이름</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control form-control-lg" id="userName" name="userName" value="${user.userName}" required 
                                               <c:if test="${user.role == 2}">disabled</c:if>>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="nickname" class="col-sm-3 control-label">닉네임</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control form-control-lg" id="nickname" name="nickname" value="${user.nickname}" required 
                                               <c:if test="${user.role == 2}">disabled</c:if>>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="col-sm-3 control-label">이메일</label>
                                    <div class="col-sm-9">
                                        <input type="email" class="form-control form-control-lg" id="email" name="email" value="${user.email}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="phoneNum" class="col-sm-3 control-label">휴대전화번호</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="text" class="form-control form-control-lg" id="phoneNum" name="phoneNum" value="${user.phoneNum}" required readonly>
                                            <div class="input-group-append">
                                                <button type="button" class="btn btn-primary" onclick="openPhoneNumberModal()">핸드폰 번호 변경</button>
                                            </div>
                                        </div>
                                        <span id="verificationCodeMsg" class="help-block"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="col-sm-3 control-label">비밀번호</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="text" class="form-control form-control-lg" id="password" name="password" value="비밀번호를 변경하시려면 비밀번호 변경버튼을 누르세요." readonly>
                                            <div class="input-group-append">
                                                <button type="button" class="btn btn-warning" onclick="openPasswordModal()">비밀번호 변경</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="addr" class="col-sm-3 control-label">주소</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control form-control-lg" id="addr" name="addr" value="${user.addr}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="getAddr" class="col-sm-3 control-label">상세주소</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control form-control-lg" id="getAddr" name="getAddr" value="${user.getAddr}" required>
                                    </div>
                                </div>
                                <div class="form-group text-center mt-4">
                                    <button type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">정보 수정</button>
                                    <a class="btn btn-block btn-secondary btn-lg font-weight-medium auth-form-btn" href="#" role="button">취소</a>
                                </div>
                                <div class="form-group text-center mt-4">
                                    <button type="button" class="btn btn-block btn-danger btn-lg font-weight-medium auth-form-btn" onclick="openDeleteModal()">회원 탈퇴</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- page-body-wrapper ends -->
    </div>

    <!-- 핸드폰 번호 변경 모달 창 -->
    <div id="phoneNumberModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="phoneNumberModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="phoneNumberModalLabel">핸드폰 번호 변경</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="newPhoneNumber">새 핸드폰 번호</label>
                        <input type="text" id="newPhoneNumber" class="form-control" placeholder="새 핸드폰 번호 입력">
                        <button type="button" class="btn btn-primary" onclick="sendVerificationCode()">인증번호 전송</button>
                    </div>
                    <div class="form-group">
                        <label for="verificationCode">인증번호</label>
                        <input type="text" id="verificationCode" class="form-control" placeholder="인증번호 입력">
                        <button type="button" class="btn btn-primary" onclick="verifyCode()">인증번호 확인</button>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 비밀번호 변경 모달 창 -->
    <div id="passwordModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="passwordModalLabel">비밀번호 변경</h4>
                </div>
                <div class="modal-body">
                    <form id="passwordForm">
                        <input type="hidden" name="userId" value="${user.userId}" />
                        <div class="form-group">
                            <label for="newPasswordModal">새 비밀번호</label>
                            <input type="password" id="newPasswordModal" name="newPassword" class="form-control" required />
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">새 비밀번호 확인</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required />
                        </div>
                        <div id="errorMessage" style="color: red;">
                            <c:if test="${not empty error}">
                                ${error}
                            </c:if>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="checkPassword()">비밀번호 변경</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 회원 탈퇴 모달 창 -->
    <div id="deleteModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="deleteModalLabel">회원 탈퇴</h4>
                </div>
                <div class="modal-body">
                    <p>정말로 탈퇴하시겠습니까?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger" onclick="deleteUser()">탈퇴</button>
                </div>
            </div>
        </div>
    </div>

    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="../../vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <!-- End plugin js for this page -->

    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->

    <script type="text/javascript">
        function openPhoneNumberModal() {
            $('#phoneNumberModal').modal('show');
        }

        function sendVerificationCode() {
            var phoneNum = document.getElementById("newPhoneNumber").value;
            // 서버로 인증번호 전송 요청
            $.ajax({
                url: "/user/send-verification-code",
                type: "POST",
                data: { phoneNum: phoneNum },
                success: function(response) {
                    alert("인증번호가 전송되었습니다.");
                },
                error: function() {
                    alert("인증번호 전송에 실패했습니다.");
                }
            });
        }

        function verifyCode() {
            var phoneNum = document.getElementById("newPhoneNumber").value;
            var code = document.getElementById("verificationCode").value;
            // 서버로 인증번호 확인 요청
            $.ajax({
                url: "/user/verify-code-user",
                type: "POST",
                data: { phoneNum: phoneNum, code: code },
                success: function(response) {
                    if (response.valid) {
                        alert("인증 성공");
                        $('#phoneNumberModal').modal('hide');
                        // 새로운 핸드폰 번호를 폼에 반영
                        document.getElementById("phoneNum").value = phoneNum;
                    } else {
                        alert("인증 실패");
                    }
                },
                error: function() {
                    alert("인증 과정에서 오류가 발생했습니다.");
                }
            });
        }

        function openPasswordModal() {
            $('#passwordModal').modal('show');
        }

        function checkPassword() {
            var newPassword = document.getElementById("newPasswordModal").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (newPassword !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다. 다시 확인하세요.");
                return;
            }

            var userId = document.querySelector("input[name='userId']").value;

            $.ajax({
                url: "/user/updateAdmin",
                type: "POST",
                data: { userId: userId, newPassword: newPassword, confirmPassword: confirmPassword },
                success: function(response) {
                    alert("비밀번호가 성공적으로 변경되었습니다.");
                    $('#passwordModal').modal('hide');
                },
                error: function() {
                    alert("비밀번호 변경에 실패했습니다.");
                }
            });
        }

        function openDeleteModal() {
            $('#deleteModal').modal('show');
        }

        function deleteUser() {
            var userId = document.querySelector("input[name='userId']").value;
            
            $.ajax({
                url: "/user/userQuit",
                type: "POST",
                data: { userId: userId },
                success: function(response) {
                    alert("회원 탈퇴가 성공적으로 처리되었습니다.");
                    if (response.redirect) {
                        window.location.href = response.redirect;
                    }
                },
                error: function() {
                    alert("회원 탈퇴 처리에 실패했습니다.");
                }
            });
        }

    </script>
</body>
</html>
