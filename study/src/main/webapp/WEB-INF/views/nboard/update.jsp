<%@page import="com.huation.myweb.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
				        <form id="updateForm"
				        	  action="update"
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
				                <th rowspan="2">첨부자료</th>
	                            <td>
	                                <c:forEach var="file" items="${ nBoard.uploadFiles }">
	                                    <a href="download?file-no=${ file.uploadFileNo }">${ file.userFileName }</a>
	                                    (${ file.downloadCount })
	                                    <a href="#" id="delete-file" data-no="${ file.uploadFileNo }">[삭제]</a><br>
	                                </c:forEach>
	                            </td>
				            </tr>
				            <tr>
                                <td>
                                    <input type="file" name="attach" style="height:25px;" />
                                </td>
				            </tr>
				            <tr>
				                <th>내용</th>
				                <td>
				                	<textarea id="content" name="content" style="width:580px" rows="15">${ nBoard.content }</textarea>
				                </td>
				            </tr>
				        </table>
				        <div class="buttons">
				        	<input type="submit" value="등록" style="height:25px" />
				        	<input id="cancel" type="button" value="취소" style="height:25px"  />
				        </div>
				        <input type="hidden" value="${ nBoard.boardNo }" id="board-no" name="boardNo" />
				        </form>
				    </div>
				</div>   	
		
			</div>
		</div>
		
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
		<!-- 스마트 에디터 -->
   		<script type="text/javascript" src="/myweb/resources/smart-editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
			$(function() {
				
				//스마트에디터
	            var oEditors = [];
	            nhn.husky.EZCreator.createInIFrame({
	                oAppRef: oEditors,
	                elPlaceHolder: "content",
	                sSkinURI: "/myweb/resources/smart-editor/SmartEditor2Skin.html",
	                fCreator: "createSEditor2"
	            });

	            function submitContents() {
	                oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	            };

	            function makeForm(action, fileNo, boardNo, method="GET") {
	    			var form = $('<form></form>');
	    			form.attr({
	    				'action': action,
	    				'method': method
	    			});
	    			form.append($('<input>').attr({
	    				"type": "hidden",
	    				"name": "file-no",
	    				"value" : fileNo })
	    			);
	    			form.append($('<input>').attr({
	    				"type": "hidden",
	    				"name": "board-no",
	    				"value" : boardNo })
	    			);
	    			
	    			form.appendTo("body");
	    			
	    			return form;
	    		}

	            $('#updateForm').on('submit', function (event) {
	                submitContents();
	            });
				
				$('#cancel').on('click', function(event) {
					//history.back();
					location.href = "list";
				});

				$('#delete-file').on('click', function(event) {
					event.preventDefault();
					var fileNo = $('#delete-file').attr("data-no");
					var boardNo = $('#board-no').val();
					var deleteFileForm = makeForm("delete-file", fileNo, boardNo, "POST")
					deleteFileForm.submit();
					
				});
			});
		</script>
	
	</body>
</html>