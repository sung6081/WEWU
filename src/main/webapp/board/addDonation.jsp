<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <!-- HEADER -->
    <jsp:include page="/header.jsp" />
    <!-- HEADER -->
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <link rel="stylesheet" href="/css/datepicker.css">

    <!-- jQuery와 jQuery UI 포함 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- Custom CSS for datepicker -->
    <style>
        .ui-datepicker {
            background: #fffbe7; /* 노란색 배경 */
            border: 1px solid #aaddaa; /* 초록색 테두리 */
            color: #333;
        }
        .ui-datepicker-header {
            background: #aaddaa; /* 초록색 배경 */
            border-bottom: 1px solid #98d698;
            color: #fff;
        }
        .ui-datepicker-title {
            color: #333;
        }
        .ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next {
            background: #98d698; /* 연한 초록색 배경 */
            color: #fff;
        }
        .ui-datepicker .ui-datepicker-prev:hover, .ui-datepicker .ui-datepicker-next:hover {
            background: #aaddaa; /* 진한 초록색 배경 */
            color: #fff;
        }
        .ui-datepicker-calendar th {
            background: #98d698; /* 연한 초록색 배경 */
            color: #fff;
        }
        .ui-datepicker-calendar td {
            background: #fffbe7; /* 노란색 배경 */
        }
        .ui-datepicker-calendar td a {
            color: #333;
        }
        .ui-datepicker-calendar td:hover a {
            background: #fffdcc; /* 연한 노란색 배경 */
        }
        .ui-datepicker-calendar .ui-datepicker-today a {
            background: #aaddaa; /* 초록색 배경 */
            color: #fff;
        }
        .ui-datepicker-calendar .ui-datepicker-today a:hover {
            background: #98d698; /* 연한 초록색 배경 */
            color: #fff;
        }
    </style>

    <!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

    <script>
        $(document).ready(function(){
            // Initialize datepicker
            $("#userBirth").datepicker({
            	 dateFormat: "yy-mm-dd",
                 changeMonth: true, // 월별 선택 기능 활성화
                 changeYear: true,
                 yearRange: "1920:2030",// 연도별 선택 기능 활성화
                 showButtonPanel: true // 오늘과 완료 버튼 표시
            });

            $("button.btn:contains('취소')").on("click", function() {
                self.location="/board/listBoard?boardType=4"
            });
        });

        function handleSelectChange(selectElement) {
            var inputBox = document.getElementById("customInputBox");
            if (selectElement.value === "직접입력") {
                inputBox.style.display = "block";
            } else {
                inputBox.style.display = "none";
            }
        }

        function pay() {
            var payAmount = $("#payAmount").val();

            if(payAmount == "" || payAmount == 0 || payAmount == null) {
                alert("충전할 액수를 입력하세요");
                return;
            }

            if (confirm("후원 하시겠습니까?")) {
                var userName = $("#userName").val();
                var IMP = window.IMP;
                let uuid = self.crypto.randomUUID();
                IMP.init("imp04155511"); // 가맹점 식별코드
                IMP.request_pay({
                    pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택
                    pay_method: 'card', // 결제 방식
                    merchant_uid: uuid, // 결제 고유 번호
                    name: '후원', // 제품명
                    amount: payAmount, // 가격
                    //구매자 정보 ↓
                    buyer_name: userName,

                }, async function (rsp) { // callback
                    console.log(rsp);
                    if(rsp.success == true) {
                        console.log(rsp);
                        //성공
                        $("#userName").val(rsp.buyer_name);
                        if(rsp.pg_provider == "kakaopay") {
                            $("#payOption").val("P");
                        } else {
                            $("#payOption").val("Q");
                        }

                        if(rsp.name == "포인트") {
                            $("#payType").val("A");
                        } else {
                            $("#payType").val("B");
                        }

                        $("#payFlag").val("T");
                        alert('후원 완료 되었습니다.');
                        $(".paySuccess").attr("method","POST").attr("action","/pay/kakaoPay/success").submit();
                    } else {
                        location.href="/pay/kakaoPay/fail";
                        //실패
                    }
                });
            } else { // 구매 확인 알림창 취소 클릭시 돌아가기
                return false;
            }
        }
    </script>
</head>
<body>
    <div class="container-fluid page-body-wrapper">
        <jsp:include page="boardSideBar.jsp"/>

        <div class="main-panel">
            <div class="col-md-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h1 class="card-title">
                            후원 하기
                        </h1>

                        <form class="paySuccess">
                            <input type="hidden" name="payType" value="B" >
                            <input type="hidden" name="payOption" id="payOption"> 
                            <input type="hidden" name="payFlag" id="payFlag"> 

                            <div class="form-group row">
                                <label for="title" class="col-sm-3 col-form-label">이름</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="userName" id="userName" >
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label">이메일</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="email" >
                                </div>
                            </div>									

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label">전화번호</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="phoneNum" >
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label">생년월일</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="userBirth" id="userBirth">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label">결제 금액</label>
                                <div class="col-sm-4">
                                    <select id="payAmount" name="payAmount" class="form-control">
                                        <option value="10000" selected>10000</option>
                                        <option value="20000">20000</option>
                                        <option value="30000">30000</option>
                                        <option value="50000">50000</option>
                                        <option value="100000">100000</option>
                                        <!-- <option value="직접입력">직접 입력</option> -->
                                    </select>
                                </div>
                            </div>

                            <div id="customInputBox" style="display:none;">
                                <label for="customInput">Enter your custom value:</label>
                                <input type="text" id="customInput" name="customInput"/>
                            </div>

                            <div class="text-right mt-4">
                                <button type="button" class="btn btn-success" style="float: right; margin-left: 10px;" onclick="javascript:pay();">후원하기</button>
                            </div> 		
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
</body>
</html>
