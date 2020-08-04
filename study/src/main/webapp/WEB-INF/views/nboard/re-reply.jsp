<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    <c:choose>
                        <c:when test="${ empty comment }">
                            <div class="inputsubtitle">댓글 작성</div>
                        </c:when>
                        <c:otherwise>
                            <div class="inputsubtitle">댓글 수정</div>
                        </c:otherwise>
                    </c:choose>
                    <div id="reply-content" style="text-align:left;">

                        <div id="reply-write-container">
                            <c:choose>
                                <c:when test="${ empty comment }">
                                    <form id="reply" action="re-reply" method="post">
                                        <input type="hidden" name="prCommentNo" value="${ commentNo }">
                                        <input type="hidden" name="replier" value="${ loginuser.memberId }">
                                        <textarea id="reply" name="reply" rows="10"></textarea>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form id="reply" action="modify-reply" method="post">
                                        <input type="hidden" name="commentNo" value="${ comment.commentNo }">
                                        <input type="hidden" name="boardNo" value="${ comment.boardNo }">
                                        <input type="hidden" name="replier" value="${ comment.replier }">
                                        <textarea id="reply" name="reply" rows="10">${ comment.reply }</textarea>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <div style="text-align:center;">
                                <input type="button" id='modifyBtn' value="완료" style="height:25px;">
                                <input type="button" id='cancelBtn' value="취소" style="height:25px;">
                            </div>
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

            $("#modifyBtn").on('click', function (event) {
                $("#reply").submit();
            });

            $("#cancelBtn").on('click', function (event) {
                history.back();
            });

        });
    </script>

</body>

</html>