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
			
		<div style="padding-top:25px;text-align:center">
			<div id="inputcontent">
			    <div id="inputmain">
			        <div class="inputsubtitle">게시물 수정</div>
			        <table>
			            <tr style="width:600px">
			                <th>제목</th>
			                <td>
			                    <input type="text" id="title" name="title" style="width:580px" value="${ aBoard.title }" />
			                </td>
			            </tr>
			            <tr>
			                <th>작성자</th>
			                <td>
			                	<input type="hidden" id="writer" name="writer" value="${ sessionScope.loginuser.memberId }" />
			                	${ loginuser.memberId }
			                </td>
			            </tr>
			            <tr>
			                <th>내용</th>
			                <td>
			                	<textarea id="content" name="content" style="width:580px" rows="15">${ aBoard.content }</textarea>
			                </td>
			            </tr>
			        </table>
			        <div class="buttons">
			        	<input type="button" id="updateBtn" value="등록" style="height:25px" />
			        	<input id="cancel" type="button" value="취소" style="height:25px"  />
			        </div>
			        <input type="hidden" id="boardNo" value="${ aBoard.boardNo }" name="boardNo" />
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

	            $('#updateBtn').on('click', function(event) {
	                submitContents();

			    	var boardNo = $('#boardNo').val();
		            var data = {
				    	"title": $('#title').val(),
				    	"content": $('#content').val()
				    };
		            
		            $.ajax({
	                    url: "/myweb/aboard/" + boardNo,
	                    type: "PUT",
	                    contentType: "application/json", // PUT method 처리를 위해 설정
	                    data: JSON.stringify(data), // JSON Object => JSON String
	                    success: function(result, status, xhr) {
							window.close();
							window.open('about:blank', '_self').self.close();
	                    },
	                    error: function(xhr, status, err) {
	                        alert('게시물 수정 실패');
	                    }
	                });
	            });
	            
				$('#cancel').on('click', function(event) {
	                window.close();
	                window.open('about:blank', '_self').self.close();
				});
			});
		</script>
	
	</body>
</html>