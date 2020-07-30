<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

	<head>
		<meta charset="utf-8" />
		<title>자료 목록</title>
		<link rel="Stylesheet" href="/myweb/resources/css/default.css" />
		<style>
		a {
		text-decoration: none;
		}
		</style>
	</head>
	
	<body>
	
		<div id="pageContainer">
		
			<jsp:include page="/WEB-INF/views/sidebar.jsp" />
			
			<div style="padding-top:25px;text-align:center">
				[ <a href="write">자료 등록</a> ]				
				<br /><br />
				
				<table border="1" style="width:1200px;margin:0 auto">
				
					<tr style="background-color:black;color:white;height:30px">
						<th style="width:100px">번호</th>
						<th style="width:700px">제목</th>
						<th style="width:200px">작성자</th>
						<th style="width:200px;text-align:center">작성일</th>
					</tr>
					
					<c:forEach var="nBoard" items="${ requestScope.nBoards }">
					<tr style="height:30px">
						<td>${ nBoard.boardNo }</td>
						<td>
						<c:choose>
						<c:when test="${ not nBoard.deleted }">
						<a href="detail?nboardno=${ nBoard.boardNo }">${ nBoard.title }</a>
						</c:when>
						<c:otherwise>
						<span style="color:lightgray">${ nBoard.title } (삭제된 글)</span>
						</c:otherwise>
						</c:choose>
						</td>
						<td>${ nBoard.writer }</td>
						<td>${ nBoard.regDate }</td>
					</tr>
					</c:forEach>
					
				</table>
				
				<br /><br /><br /><br />
			
			</div>
			
		</div>		
	
	</body>
	
</html>
