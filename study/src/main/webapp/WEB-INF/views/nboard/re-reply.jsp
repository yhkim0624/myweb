<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8" />
    <title>댓글 수정</title>
    <link rel="Stylesheet" href="/myweb/resources/css/default.css" />
    <link rel="Stylesheet" href="/myweb/resources/css/input2.css" />
</head>

<body>

    <div id="pageContainer">

        <jsp:include page="/WEB-INF/views/sidebar.jsp" />

        <div style="padding-top:25px;text-align:center">
            <div id="inputcontent">
                <div id="inputmain">
                    <div class="inputsubtitle">댓글 수정</div>

                    <div id="reply-content" style="text-align:left;">

                        <div id="reply-write-container">
                            <form id="reply" action="modify-reply" method="post">
                                <input type="hidden" name="commentNo" value="${ comment.commentNo }">
                                <input type="hidden" name="boardNo" value="${ comment.boardNo }">
                                <input type="hidden" name="replier" value="${ comment.replier }">
                                <textarea id="reply" name="reply" style="width:734px"
                                    rows="5">${ comment.reply }</textarea>
                                <br>
                                <div style="float:right;">
                                    <input type="button" id='modifyBtn' value="완료" style="height:25px;">
                                    <input type="button" id='cancelBtn' value="취소" style="height:25px;">
                                </div>
                            </form>
                        </div>

                        <br>
                    </div>

                </div>
            </div>
        </div>
    </div>

	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	
	<script type="text/javascript">
        $(function () {

            $("#modifyBtn").on('click',function (event) {
				$("#reply").submit();
            });
        	
        	$("#cancelBtn").on('click', function (event) {
       			history.back();
       		});
            
        });
    </script>

</body>

</html>