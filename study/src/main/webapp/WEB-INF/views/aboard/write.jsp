<%@page import="com.huation.myweb.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>


<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8" />
    <title>게시물 작성</title>
    <link rel="Stylesheet" href="/myweb/resources/css/aboard/default.css" />
    <link rel="Stylesheet" href="/myweb/resources/css/aboard/input2.css" />
</head>

<body>

    <div style="padding-top:25px;text-align:center">
        <div id="inputcontent">
            <div id="inputmain">
                <div class="inputsubtitle">게시물 작성</div>
                <form id="writeForm">
                    <table>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" id="title" name="title" />
                            </td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td>
                                <input type="hidden" id="writer" name="writer" value="${ loginuser.memberId }" />
                                ${ loginuser.memberId }
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea id="content" name="content" rows="20"></textarea>
                            </td>
                        </tr>
                    </table>
                </form>
                <div class="buttons">
                    <button id="okBtn">등록</button>
                    <button id="cancelBtn">취소</button>
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

            $('#okBtn').on('click', function (event) {
                
            	submitContents();
            	
            	var values = $('#writeForm').serializeArray();

                $.ajax({
                    url: "/myweb/aboard/write",
                    type: "POST",
                    data: values,
                    success: function (data, status, xhr) {
						window.close();
						window.open('about:blank', '_self').self.close();
                    },
                    error: function (xhr, status, err) {
                        alert('게시물 쓰기 실패');
                    }
                });
            });

            $('#cancelBtn').on('click', function (event) {
                window.close();
                window.open('about:blank', '_self').self.close();
            });
        });
    </script>

</body>

</html>