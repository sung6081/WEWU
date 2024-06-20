<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Quest</title>
</head>
<body>
	<jsp:include page="/header.jsp" flush="true" />
	<jsp:include page="/plantSide.jsp" />
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row mt-5">
            <div class="col-lg-12 grid-margin stretch-card mx-auto">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">List Quest</h4>
                        <p class="card-description">
                            Add class <code>.table-striped</code>
                        </p>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Quest No</th>
                                    <th>Reg Date</th>
                                    <th>Quest Contents</th>
                                    <th>Quest State</th>
                                    <th>Quest Reg Date</th>
                                    <th>Quest Target</th>
                                    <th>Quest Target Count</th>
                                    <th>Quest Reward</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="quest" items="${map.list}">
                                    <tr>
                                        <td class="questNo">${quest.questNo}</td>
                                        <td>${quest.regDate}</td>
                                        <td>${quest.questContents}</td>
                                        <td>${quest.questState}</td>
                                        <td>${quest.questRegDate}</td>
                                        <td>${quest.questTarget}</td>
                                        <td>${quest.questTargetCnt}</td>
                                        <td>${quest.questReward}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    	<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	<!-- FOOTER -->
</div>
</body>
</html>
