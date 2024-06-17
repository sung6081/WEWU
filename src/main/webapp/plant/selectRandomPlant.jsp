<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Random Plant</title>
</head>
<body>
 <form id="selectRandomPlantForm" method="post" action="/plant/selectRandomPlant">
        <input type="hidden" name="plantNo" value="1">
        <button type="submit">Select Random Plant</button>
    </form>
    <h2>Selected Random Plant</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Plant No</th>
                <th>Plant Level No</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${plant.plantNo}</td>
                <td>${plant.plantLevlNo}</td>
                <td>${plant.plantLevl.levlImg}</td>
            </tr>
        </tbody>
    </table>
    </form>
</body>
</html>