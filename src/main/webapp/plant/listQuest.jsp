<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>
	
      <h2>Quest List</h2>
      
          <form action="getQuestList" method="get">
        <label for="searchKeyword">Search Keyword:</label>
        <input type="text" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword}"/>
        <label for="searchCondition">Search Condition:</label>
        <input type="text" id="searchCondition" name="searchCondition" value="${search.searchCondition}"/>
        <input type="submit" value="Search"/>
    </form>
    <table border="1" class="table table-hover table-striped">
        <thead>
            <tr>
                <th>Quest No</th>
                <th>Quest Contents</th>
                <th>Quest State</th>
                <th>Quest Reg Date</th>
                <th>Quest Target</th>
                <th>Quest Target Count</th>
                <th>Quest Reward</th>
                <th>Reg Date</th>
                <th>Nickname</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="quest" items="${map.list}">
                <tr>
                    <td>${quest.questNo}</td>
                    <td>${quest.questContents}</td>
                    <td>${quest.questState}</td>
                    <td>${quest.questRegDate}</td>
                    <td>${quest.questTarget}</td>
                    <td>${quest.questTargetCnt}</td>
                    <td>${quest.questReward}</td>
                    <td>${quest.regDate}</td>
                    <td>${quest.nickName}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
   
</body>
</html>