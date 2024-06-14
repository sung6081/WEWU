<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>
    <h2>history</h2>
    
   <table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">history</th>
					<th align="left">식물히스토리</th>
				</tr>
			</thead>
			
			<tbody>
			
				<c:forEach var="myPlant" items="${allList}">
					<tr class="ct_list_pop">
						<td align="left">${myPlant.plant.plantNo}</td>
						<td align="left">${myPlant.myPlantExp}</td>
						<td align="left">${myPlant.myPlantName}</td>
						<td align="left">${myPlant.planLevl.levlImg}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</body>
</html>