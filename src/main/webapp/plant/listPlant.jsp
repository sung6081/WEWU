<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Plant</title>
</head>
<body>
    <h2>List Plant</h2>
    
   <table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">PlantNo</th>
					<th align="left">식물 종류 이름</th>
				</tr>
			</thead>
			
			<tbody>
			<c:set var="i" value="0"/>
				<c:forEach var="plant" items="${map.list}">
					<tr class="ct_list_pop">
						<td align="center">${ i }</td>
						<td align="left">${plant.plantName}</td>
				
					</tr>
				</c:forEach>