<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table id="tbl" style="width:90%;margin:0 auto;">
	<thead>
	    <tr style="background-color:black;color:white;height:30px">
	        <th style="width:100px">번호</th>
	        <th style="width:700px">제목</th>
	        <th style="width:100px">작성자</th>
	        <th style="width:100px">조회수</th>
	        <th style="width:200px;text-align:center">작성일</th>
	    </tr>
	</thead>

	<tbody id="aboard-list" style="border:1px solid">
	<c:forEach var="aBoard" items="${ not empty boards ?  boards : aBoards }">
	    <tr style="height:30px;">
	        <td>${ aBoard.boardNo }</td>
	        <td style="text-align:left;padding-left:3px">
	            <c:choose>
	                <c:when test="${ not aBoard.deleted }">
	                    <a class="lists" href="detail?aboardno=${ aBoard.boardNo }&pageNo=${ pager.pageNo }">
	                        ${ aBoard.title }
	                    </a>
	                </c:when>
	                <c:otherwise>
	                    <a style="color:lightgray">${ aBoard.title } (삭제된 글)</a>
	                </c:otherwise>
	            </c:choose>
	        </td>
	        <td>${ aBoard.writer }</td>
	        <td>${ aBoard.readCount }</td>
	        <td>${ aBoard.regDate }</td>
	    </tr>
	</c:forEach>
	</tbody>
	
	<tfoot>
		<tr style="height:30px;">
			<td colspan="4" style="text-align:center;border:none;">${ pager }</td>
			<td style="text-align:right;border:none;">
				<div>
					<a href="#" id="write">[ 글쓰기 ]</a>
				</div>
			</td>
		</tr>
	</tfoot>
</table>