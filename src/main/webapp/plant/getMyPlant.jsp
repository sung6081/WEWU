<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddPlant</title>
</head>
<body>
	<form action="/plant/getMyPlant" method="POST">
	
	<h2>My Plant Details</h2>
    <table border="1" class="table table-hover table-striped">
        <tr>
            <th>MyPlant No</th>
            <td>${myPlant.myPlantNo}</td>
        </tr>
        <tr>
            <th>MyPlant State</th>
            <td>${myPlant.myPlantState}</td>
        </tr>
        <tr>
            <th>MyPlant Name</th>
            <td>${myPlant.myPlantName}</td>
        </tr>
        <tr>
            <th>MyPlant Exp</th>
            <td>${myPlant.myPlantExp}</td>
        </tr>
        <tr>
            <th>Plant Start Date</th>
            <td>${myPlant.plantStartDate}</td>
        </tr>
        <tr>
            <th>Plant End Date</th>
            <td>${myPlant.plantEndDate}</td>
        </tr>
        <tr>
            <th>MyPlant Level</th>
            <td>${myPlant.myPlantLevl}</td>
        </tr>
        <tr>
            <th>Weather No</th>
            <td>${myPlant.weatherNo}</td>
        </tr>
        <tr>
            <th>Weather Image</th>
            <td>${myPlant.weatherImg}</td>
        </tr>
        <tr>
            <th>Plant Level</th>
            <td>${myPlant.plantLevl}</td>
        </tr>
        <tr>
            <th>Plant</th>
            <td>${myPlant.plant}</td>
        </tr>
        <tr>
            <th>Nickname</th>
            <td>${myPlant.nickname}</td>
        </tr>
    </table>
</body>
</html>
	</form>
</body>
</html>