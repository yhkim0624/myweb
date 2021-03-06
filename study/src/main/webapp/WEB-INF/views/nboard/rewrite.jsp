<%@page import="com.huation.myweb.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>


<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8" />
    <title>게시물 작성</title>
    <link rel="Stylesheet" href="/myweb/resources/css/default.css" />
    <link rel="Stylesheet" href="/myweb/resources/css/input2.css" />
</head>

<body>

    <div id="pageContainer">

        <jsp:include page="/WEB-INF/views/sidebar.jsp" />

        <div style="padding-top:25px;text-align:center">
            <div id="inputcontent">
                <div id="inputmain">
                    <div class="inputsubtitle">게시물 작성</div>
                    <form id="writeForm" action="rewrite" method="post" enctype="multipart/form-data">
                    	<input type="hidden" name="prNBoardNo" value="${ nBoardNo }" />
                    	<input type="hidden" name="stepNo" value="${ stepNo }" />
                        <table>
                            <tr>
                                <th>제목</th>
                                <td>
                                    <input type="text" name="title" />
                                </td>
                            </tr>
                            <tr>
                                <th>작성자</th>
                                <td>
                                    <input type="hidden" name="writer" value="${ loginuser.memberId }" />
                                    ${ loginuser.memberId }
                                </td>
                            </tr>
                            <tr>
                                <th>첨부자료</th>
                                <td>
                                    <input type="file" name="attach" />
                                </td>
                            </tr>
                            <tr>
                            	<th><input type="button" class="addFileInput" value="+" style="width:25px;height:25px;" /></th>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td>
                                    <textarea id="content" name="content" rows="20"></textarea>
                                </td>
                            </tr>
                        </table>
                        <div class="buttons">
                            <input type="submit" value="등록" style="height:25px" />
                            <input id="cancel" type="button" value="취소" style="height:25px" />
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <!-- 스마트 에디터 -->
    <script type="text/javascript" src="/myweb/resources/smart-editor/js/service/HuskyEZCreator.js"
        charset="utf-8"></script>

    <script type="text/javascript">
        $(function () {

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

            $('#writeForm').on('submit', function (event) {
                submitContents();
                console.log($('#content').val());
            });

            $('#cancel').on('click', function (event) {
                //history.back();
                location.href = "list";
            });

            // 첨부파일 추가
            $(document).on('click', '.addFileInput', function(event) {
                $(this).closest('tr').append('<td><input type="file" name="attach" style="height:25px;" /></td>');
                $(this).closest('tr').next().before('<tr><th><input type="button" class="addFileInput" value="+" style="width:25px;height:25px;" /></th></tr>');
                $(this).val('-').removeClass('addFileInput').addClass('removeFileInput');
            });

            $(document).on('click', '.removeFileInput', function(event) {
                $(this).closest('tr').remove();
            });
        });
    </script>

</body>

</html>