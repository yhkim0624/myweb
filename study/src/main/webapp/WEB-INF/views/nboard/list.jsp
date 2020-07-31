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
		td {
		border: 1px solid;
		}
		</style>
	</head>
	
	<body>
	
		<div id="pageContainer">
		
			<jsp:include page="/WEB-INF/views/sidebar.jsp" />
			
			<div style="padding-top:25px;text-align:center">
				<h2>게시판 1</h2>
				<br />
				
				<div style="padding-left:900px;">
					<div class="dataTables_length" id="dataTable_length" style="margin-bottom:15px">
						<form action="list" method="get">
							<select name="searchType">
								<option value="T" ${ param.searchType == 'T' ? 'selected' : '' }>제목</option>
								<option value="C" ${ param.searchType == 'C' ? 'selected' : '' }>내용</option>
								<option value="TC" ${ param.searchType == 'TC' ? 'selected' : '' }>제목+내용</option>
								<option value="W" ${ param.searchType == 'W' ? 'selected' : '' }>작성자</option>
							</select>
							<input type="search" name="searchKey" placeholder="" value="${ param.searchKey }" />
							<input type="submit" value="검색" />
			            </form>
					</div>
				</div>
				
				<table style="width:1200px;margin:0 auto;">
					
					<thead>
						<tr style="background-color:black;color:white;height:30px">
							<th style="width:100px">번호</th>
							<th style="width:700px">제목</th>
							<th style="width:100px">작성자</th>
							<th style="width:100px">조회수</th>
							<th style="width:200px;text-align:center">작성일</th>
						</tr>
					</thead>
					
					<tbody style="border:1px solid">
						<c:forEach var="nBoard" items="${ nBoards }">
						<tr style="height:30px">
							<td>${ nBoard.boardNo }</td>
							<td>
							<c:choose>
							<c:when test="${ not nBoard.deleted }">
							<a href="detail?nboardno=${ nBoard.boardNo }&pageNo=${ pager.pageNo }&searchType=${ empty param.searchType ? '' : param.searchType }&searchKey=${ empty param.searchKey ? '' : param.searchKey }">
								${ nBoard.title }
							</a>
							</c:when>
							<c:otherwise>
							<span style="color:lightgray">${ nBoard.title } (삭제된 글)</span>
							</c:otherwise>
							</c:choose>
							</td>
							<td>${ nBoard.writer }</td>
							<td>${ nBoard.readCount }</td>
							<td>${ nBoard.regDate }</td>
						</tr>
						</c:forEach>
					</tbody>
					
					<tfoot>
						<tr style="height:30px;">
							<td colspan="4" style="text-align:center;border:none;">${ pager }</td>
							<td style="text-align:right;border:none;">
								<c:choose>
								<c:when test="${ empty loginuser }">
								<div>
									<a href="/myweb/login">[ 글쓰기 ]</a>
								</div>
								</c:when>
								<c:otherwise>
								<div>
									<a href="write">[ 글쓰기 ]</a>
								</div>
								</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tfoot>
					
				</table>
				<br />
				<br /><br /><br /><br />
			
			</div>
			
		</div>		
	
	</body>
	
</html>
