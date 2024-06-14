<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Inventory Details</title>
</head>
<body>
    <h2>Inventory Details</h2>
    <table border="1">
        <tr>
            <th>Item No</th>
            <th>Item Purchase No</th>
            <th>Item Experience</th>
            <th>Item Type</th>
            <th>Item Count</th>
        </tr>
        <tr>
            <td>${inventory.itemNo}</td>
            <td>${inventory.itemPurNo}</td>
            <td>${inventory.itemExp}</td>
            <td>${inventory.itemType}</td>
            <td>${inventory.itemNum}</td>
        </tr>
    </table>
</body>
</html>