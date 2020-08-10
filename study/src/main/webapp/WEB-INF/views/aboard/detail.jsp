<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8" />
    <title>게시글 상세</title>
    <link rel="Stylesheet" href="/myweb/resources/css/default.css" />
    <link rel="Stylesheet" href="/myweb/resources/css/input2.css" />
</head>

<body>

	<div style="padding-top:25px;text-align:center">
	    <div id="inputcontent">
	        <div id="inputmain">
	            <div class="inputsubtitle">상세보기</div>
                <input type="hidden" id="aBoardNo" name="aBoardNo" value="${ aBoard.boardNo }" />
	            <table>
	                <tr>
	                    <th>제목</th>
	                    <td>${ aBoard.title }</td>
	                </tr>
	                <tr>
	                    <th>작성자</th>
	                    <td>${ aBoard.writer }</td>
	                </tr>
	                <tr>
	                    <th>조회수</th>
	                    <td>${ aBoard.readCount }</td>
	                </tr>
	                <tr>
	                    <th>등록일자</th>
	                    <td>${ aBoard.regDate }</td>
	                </tr>
	                <tr>
	                    <th>내용</th>
	                    <%-- 줄바꿈 문자열을 저장하고 있는 변수 만들기(EL) --%>
	                    <c:set var="enter" value="
" />
	                    <%-- nBoard.content 문자열에서 \r\n을 <br>로 변경 --%>
	                    <td>${ fn:replace(aBoard.content, enter, "<br>") }</td>
	                </tr>
	            </table>
	            <div class="buttons">
	                <%-- 로그인한 사용자와 글의 작성자가 같으면 삭제, 수정 버튼 활성화 --%>
	                <c:if test="${ loginuser.memberId eq aBoard.writer }">
	                    <input type="button" id="update_button" value="편집" style="height:25px" />
                        <input type="button" id="deleteBtn" value="삭제" style="height:25px" />
	                </c:if>
	
	                <input type="button" id="re_button" value="답변" style="height:25px" />
	                <input type="button" id="cancel_button" value="목록" style="height:25px" />	
	            </div>
	
	            <div id="reply-content" style="text-align:left;">
	
	                <h3 style="color:#1f6cba;">댓글</h3>
	                <div id="reply-list-container">
	                    <%-- <jsp:include page="reply-list.jsp" /> --%>
	                </div>
	
	                <div id="reply-write-container">
	                    <form id="replyForm">
	                        <input type="hidden" name="boardNo" value="${ aBoard.boardNo }">
	                        <input type="hidden" name="replier" value="${ loginuser.memberId }">
	                        <textarea id="reply" name="reply" rows="5"></textarea>
	                        <br>
	                        <div style="text-align:right">
	                        	<input type="button" id='addReplyBtn' value="작성">
	                        </div>
	                    </form>
	                </div>
	
	                <br>
	            </div>
	
	        </div>
	    </div>
	</div>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <script type="text/javascript">
        $(function() {

        	// JQuery load()를 통해 reply-list.jsp 삽입
        	$("#reply-list-container").load("/myweb/aboard/reply-list/${ aBoard.boardNo }");
        	
            // 게시물 수정
            $("#update_button").on('click', function(event) {
                location.href = "update?aboardno=${ aBoard.boardNo }";
            });

			// 게시물 삭제
            $("#deleteBtn").on('click', function (event) {
                var ok = confirm("${aBoard.boardNo}번 자료를 삭제할까요?");
                if (!ok) {
                    event.preventDefault();
                }
                var bno = $('#aBoardNo').val();
	            
	            $.ajax({
                    url: "/myweb/aboard/" + bno,
                    type: "DELETE",
                    success: function(result, status, xhr) {
						window.close();
						window.open('about:blank', '_self').self.close();
                    },
                    error: function(xhr, status, err) {
                        alert('게시물 삭제 실패');
                    }
                });
            });

			// 답변 게시물 작성
            $("#re_button").on('click', function(event) {
            	location.href = "/myweb/aboard?type=rewrite&aboardno=${ aBoard.boardNo }&stepno=${ aBoard.stepNo }";
            });

			// 목록으로 돌아가기
            $("#cancel_button").on('click', function(event) {
            	window.close();
				window.open('about:blank', '_self').self.close();
            });

            // 댓글 작성
            $("#addReplyBtn").on('click', function(event) {
                var values = $('#replyForm').serializeArray();
                var type = "reply";
                $.ajax({
                    url: "/myweb/aboard/reply?type=" + type,
                    type: "POST",
                    data: values,
                    success: function(data, status, xhr) {
                        $("#content").val("");
                    	$("#reply-list-container").load("/myweb/aboard/reply-list/${ aBoard.boardNo }"); // 댓글작성 후엔 최신 페이지로
                    },
                    error: function(xhr, status, err) {
                        alert('댓글 쓰기 실패');
                    }
                });
            });

            var modifyActive = true;
            var reReplyActive = true;
            var rno = null;

			// 댓글 수정
            $("#reply-content").on('click', '.modify', function(event) {
                rno = $(this).attr("data-rno");
                var findString = "[data-no=" + rno + "]";
                var findString2 = "[data-selector=" + rno + "]"
                var reply = $(".comment-content").find(findString2).text();

                if (modifyActive) {
					modifyActive = false;
                    
	                $("#comments").find(findString).append(`
	              		<form id="modifyReplyForm">
		                    <textarea id="modifyReply" name="reply" rows="5"></textarea>
		                    <br>
		                    <div style="text-align:right">
		                    	<input type="button" id="addUpdateBtn" value="수정">
		                    	<input type="button" id="cancelUpdateBtn" value="취소">
		                    </div>
	                    </form>
	                `);
	                $("#modifyReply").val(reply);
                }
            });

			// 댓글 수정 취소
            $("#reply-content").on('click', '#cancelUpdateBtn', function(event) {
            	$("#modifyReplyForm").remove();
                modifyActive = true;
            });

			// 댓글 수정 완료
            $("#reply-content").on('click', '#addUpdateBtn', function(event) {
            	var data =  {
				    	"reply": $('#modifyReply').val()
				    };
			    
                $.ajax({
                    url: "/myweb/aboard/reply/" + rno,
                    type: "PUT",
                    contentType: "application/json", // PUT method 처리를 위해 설정
                    data: JSON.stringify(data), // JSON Object => JSON String
                    success: function(result, status, xhr) {
						$("#modifyReplyForm").remove();
						$("#reply-list-container").load("/myweb/aboard/reply-list/${ aBoard.boardNo }"); // 댓글작성 후엔 최신 페이지로
						modifyActive = true;
                    },
                    error: function(xhr, status, err) {
                        alert('댓글 수정 실패');
                    }
                });
            });

            // 대댓글 작성
            $("#reply-content").on('click', '.re-reply', function(event) {
            	rno = $(this).attr("data-rno");
            	var findString = "[data-no=" + rno + "]";

            	if (reReplyActive) {
            		reReplyActive = false;
                    
	                $("#comments").find(findString).append(`
	              		<form id="reReplyForm">
		              		<input type="hidden" name="prCommentNo" value=\${rno}>
		              		<input type="hidden" name="boardNo" value="${ aBoard.boardNo }">
		              		<input type="hidden" name="replier" value="${ loginuser.memberId }">
		                    <textarea name="reply" rows="5"></textarea>
		                    <br>
		                    <div style="text-align:right">
		                    	<input type="button" id="addReReplyBtn" value="작성">
		                    	<input type="button" id="cancelReReplyBtn" value="취소">
		                    </div>
	                    </form>
	                `);
                }
            });

            $("#reply-content").on('click', '#cancelReReplyBtn', function(event) {
            	$("#reReplyForm").remove();
            	reReplyActive = true;
            });

            $("#reply-content").on('click', '#addReReplyBtn', function(event) {
            	var values =  $('#reReplyForm').serializeArray();
            	console.log(values);
            	var type = "rereply";
                $.ajax({
                	url: "/myweb/aboard/reply?type=" + type,
                    type: "POST",
                    data: values,
                    success: function(data, status, xhr) {
                    	$("#reReplyForm").remove();
                    	$("#reply-list-container").load("/myweb/aboard/reply-list/${ aBoard.boardNo }"); // 댓글작성 후엔 최신 페이지로
                    	reReplyActive = true;
                    },
                    error: function(xhr, status, err) {
                        alert('대댓글 쓰기 실패');
                    }
                });
            });

         	// 댓글 삭제
            $("#reply-content").on('click', '.delete', function (event) {
                var ok = confirm("댓글을 삭제할까요?");
                if (!ok) {
                    return false;
                }
                var bno = $(this).parent().find('#commentNo').val();
	            
	            $.ajax({
                    url: "/myweb/aboard/reply/" + bno,
                    type: "DELETE",
                    success: function(result, status, xhr) {
                    	$("#reply-list-container").load("/myweb/aboard/reply-list/${ aBoard.boardNo }"); // 댓글작성 후엔 최신 페이지로
                    },
                    error: function(xhr, status, err) {
                        alert('댓글 삭제 실패');
                    }
                });
            });

        });
    </script>
</body>

</html>