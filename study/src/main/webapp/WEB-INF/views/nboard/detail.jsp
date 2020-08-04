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

    <div id="pageContainer">

        <jsp:include page="/WEB-INF/views/sidebar.jsp" />

        <div style="padding-top:25px;text-align:center">
            <div id="inputcontent">
                <div id="inputmain">
                    <div class="inputsubtitle">상세보기</div>
                    <table>
                        <tr>
                            <th>제목</th>
                            <td>${ nBoard.title }</td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td>${ nBoard.writer }</td>
                        </tr>
                        <tr>
                            <th>조회수</th>
                            <td>${ nBoard.readCount }</td>
                        </tr>
                        <tr>
                            <th>등록일자</th>
                            <td>${ nBoard.regDate }</td>
                        </tr>
                        <tr>
                            <th>첨부자료</th>
                            <td>
                                <c:forEach var="file" items="${ nBoard.uploadFiles }">
                                    <a href="download?file-no=${ file.uploadFileNo }">${ file.userFileName }</a>
                                    (${ file.downloadCount })<br>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <%-- 줄바꿈 문자열을 저장하고 있는 변수 만들기(EL) --%>
                            <c:set var="enter" value="
" />
                            <%-- nBoard.content 문자열에서 \r\n을 <br>로 변경 --%>
                            <td>${ fn:replace(nBoard.content, enter, "<br>") }</td>
                        </tr>
                    </table>
                    <div class="buttons" style="margin:5px 0px 5px 260px;">
                        <%-- 로그인한 사용자와 글의 작성자가 같으면 삭제, 수정 버튼 활성화 --%>
                        <c:if test="${ loginuser.memberId eq nBoard.writer }">
                            <input type="button" id="update_button" value="편집" style="height:25px" />

                            <form action="delete" style="display:inline" method="post">
                                <input type="hidden" name="nBoardNo" value="${ nBoard.boardNo }" />
                                <input type="submit" id="delete_button" value="삭제" style="height:25px" />
                            </form>
                        </c:if>

                        <input type="button" id="re_button" value="답변" style="height:25px" />
                        <input type="button" id="cancel_button" value="목록보기" style="height:25px" />

                    </div>

                    <div id="reply-content" style="text-align:left;">

                        <h3 style="color:#1f6cba;">댓글</h3>
                        <div id="reply-list-container">
                            <jsp:include page="reply-list.jsp" />
                        </div>

                        <div id="reply-write-container">
                            <form id="reply" action="reply" method="post">
                                <input type="hidden" name="boardNo" value="${ nBoard.boardNo }">
                                <input type="hidden" name="replier" value="${ loginuser.memberId }">
                                <textarea id="content" name="reply" style="width:734px" rows="5"></textarea>
                                <br>
                                <input type="button" id='addReplyBtn' value="작성" style="margin-left:700px;height:25px;">
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

            // 게시물
            $("#update_button").on('click', function (event) {
                location.href = "update?nboardno=${ nBoard.boardNo }";
            });

            $("#delete_button").on('click', function (event) {
                var ok = confirm("${nBoard.boardNo}번 자료를 삭제할까요?");
                if (!ok) {
                    event.preventDefault();
                }
            });

            $("#re_button").on('click', function (event) {
                location.href = "rewrite?nboardno=${ nBoard.boardNo }&stepno=${ nBoard.stepNo }";
            });

            $("#cancel_button").on('click', function (event) {
                location.href = "list";
                //history.back(); // 브라우저의 이전 버튼을 클릭
            });

            // 댓글
            $("#addReplyBtn").on('click', function (event) {
                $("#reply").submit();
            });

            $("#comments").on('click', '.modify', function (event) {
                var rno = $(this).attr("data-rno");
                location.href = "modify-reply?rno=" + rno;
            });

            // 작성중~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            $("#comments").on('click', '.re-reply', function (event) {
            	var rno = $(this).attr("data-rno");
            	location.href = "re-reply?rno=" + rno;
            });

        });
    </script>
</body>

</html>