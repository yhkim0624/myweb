<%@page import="com.huation.myweb.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>


<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8" />
		<title>게시물 수정</title>
		<link rel="Stylesheet" href="/myweb/resources/css/default.css" />
		<link rel="Stylesheet" href="/myweb/resources/css/input2.css" />
	</head>
	
	<body>
	
		<div id="pageContainer">
		
			<jsp:include page="/WEB-INF/views/sidebar.jsp" />
			
			<div style="padding-top:25px;text-align:center">
				<div id="inputcontent">
				    <div id="inputmain">
				        <div class="inputsubtitle">게시물 수정</div>
				        <form action="update"
				        	  method="post"
				        	  enctype="multipart/form-data">
				        <table>
				            <tr style="width:600px">
				                <th>제목</th>
				                <td>
				                    <input type="text" name="title" style="width:580px" value="${ nBoard.title }" />
				                </td>
				            </tr>
				            <tr>
				                <th>작성자</th>
				                <td>
				                	<input type="hidden" name="writer" value="${ sessionScope.loginuser.memberId }" />
				                	${ loginuser.memberId }
				                </td>
				            </tr>
				            <tr>
				                <th>첨부자료</th>
				                <td>
				                    <input type="file" name="attach" style="width:580px;height:25px" />
				                </td>
				            </tr>
				            <tr>
				                <th>내용</th>
				                <td>
				                	<textarea name="content" style="width:580px" rows="15">${ nBoard.content }</textarea>
				                </td>
				            </tr>
				        </table>
				        <div class="buttons">
				        	<input type="submit" value="등록" style="height:25px" />
				        	<input id="cancel" type="button" value="취소" style="height:25px"  />
				        </div>
				        <input type="hidden" value="${ nBoard.boardNo }" name="boardNo" />
				        </form>
				    </div>
				</div>   	
		
			</div>
		</div>
		
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
		<script type="text/javascript">
			$(function() {
				$('#cancel').on('click', function(event) {
					//history.back();
					location.href = "list";
				});
			});
		</script>
	
	</body>
</html>