<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8" />
    <title>자료 목록</title>
    <link rel="Stylesheet" href="/myweb/resources/css/default.css" />
    <style>
        a {
            text-decoration: none;
        }

        td {
            border: 1px solid;
        }
    </style>
</head>

<body>

    <div id="pageContainer">

        <jsp:include page="/WEB-INF/views/sidebar.jsp" />

        <div style="padding-top:25px;text-align:center">
            <h2>게시판 1</h2>
            <br />

            <div style="float:left;margin-left:100px;font-size:12pt;">
                <a href="#" onclick="excelUp()">[Excel Up]</a>
                <a href="#" onclick="excelDown()">[Excel Down]</a>
            </div>
            <div style="float:right;margin-right:100px;">
                <div class="dataTables_length" id="dataTable_length" style="margin-bottom:15px">
                    <form action="list" method="get">
                        <select name="searchType" style="height:24px">
                            <option value="T" ${ param.searchType=='T' ? 'selected' : '' }>제목</option>
                            <option value="C" ${ param.searchType=='C' ? 'selected' : '' }>내용</option>
                            <option value="TC" ${ param.searchType=='TC' ? 'selected' : '' }>제목+내용</option>
                            <option value="W" ${ param.searchType=='W' ? 'selected' : '' }>작성자</option>
                        </select>
                        <input type="search" name="searchKey" placeholder="" value="${ param.searchKey }" />
                        <input type="submit" value="검색" />
                    </form>
                </div>
            </div>

            <table style="width:90%;margin:0 auto;">

                <thead>
                    <tr style="background-color:black;color:white;height:30px">
                        <th style="width:100px">번호</th>
                        <th style="width:700px">제목</th>
                        <th style="width:100px">작성자</th>
                        <th style="width:100px">조회수</th>
                        <th style="width:200px;text-align:center">작성일</th>
                    </tr>
                </thead>

                <tbody style="border:1px solid">
                    <c:forEach var="nBoard" items="${ nBoards }">
                        <tr style="height:30px;">
                            <td>${ nBoard.boardNo }</td>
                            <td style="text-align:left;padding-left:3px">
                                <c:choose>
                                    <c:when test="${ not nBoard.deleted }">
                                        <a class="lists"
                                            href="detail?nboardno=${ nBoard.boardNo }&pageNo=${ pager.pageNo }&searchType=${ empty param.searchType ? '' : param.searchType }&searchKey=${ empty param.searchKey ? '' : param.searchKey }">
                                            ${ nBoard.title }
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a style="color:lightgray">${ nBoard.title } (삭제된 글)</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${ nBoard.writer }</td>
                            <td>${ nBoard.readCount }</td>
                            <td>${ nBoard.regDate }</td>
                        </tr>
                    </c:forEach>
                </tbody>

                <tfoot>
                    <tr style="height:30px;">
                        <td colspan="4" style="text-align:center;border:none;">${ pager }</td>
                        <td style="text-align:right;border:none;">
                            <c:choose>
                                <c:when test="${ empty loginuser }">
                                    <div>
                                        <a href="/myweb/login">[ 글쓰기 ]</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div>
                                        <a href="write">[ 글쓰기 ]</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </tfoot>

            </table>
            <br />
            <br /><br /><br /><br />

        </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">

        $(function () {

            if (${ empty loginuser }) {
            $(".lists").attr("href", "/myweb/login");
        }
            
		});

        function excelDown() {
            if (confirm("엑셀파일로 저장하시겠습니까?") == true) {
                var myTable = $("table");
                var rows = $("table > tbody > tr").length;
                var columns = $("table > thead > tr > th").length;
                if (rows < 2) {
                    alert("엑셀파일로 저장할 데이터가 없습니다.");
                    return;
                }
                var dataParam = tableToJson(myTable);
                var myTitle = dataParam[0].toString();
                var myContents = dataParam[1];
                var name = "Table To Excel";
                var form = "<form action='excel-down' method='post' id='excelForm'>";
                form += "<input type='hidden' name='title' value='" + myTitle + "' />";
                form += "<input type='hidden' name='contents' value='" + myContents + "' />";
                form += "<input type='hidden' name='name' value='" + name + "' />";
                form += "<input type='hidden' name='rows' value='" + rows + "' />";
                form += "<input type='hidden' name='columns' value='" + columns + "' />";
                form += "</form>";

                $(form).appendTo("body").submit().remove();
            }
        }

        function excelUp() {
            var form = "<form action='excel-up' method='post' id='excelForm' enctype='multipart/form-data'>";
            form += "<input type='file' id='excelFile' name='excelFile' style='display:none;' />";
            form += "</form>";

            $(form).appendTo("body");
            $("#excelFile").change(function () {
                $("#excelForm").submit().remove();
            });
            $("#excelFile").click();
        }

        function tableToJson(table) {
            var myRows = [];
            var title = [];
            var $headers = $("th");
            $("th").each(function (index, item) {
                title[index] = $(item).html();
            });

            var $rows = $("tbody tr").each(
                function (index) {
                    $cells = $(this).find("td");
                    myRows[index] = {};
                    $cells.each(function (cellIndex) {
                        if ($(this).find("a").html()) {
                            myRows[index][$($headers[cellIndex]).html()] = $(this).find("a").html().trim();
                        } else {
                            myRows[index][$($headers[cellIndex]).html()] = $(this).html().trim();
                        }
                    });
                });

            var myObj = {};
            myObj = myRows;

            var myJson = JSON.stringify(myObj);
            return [title, myJson];
        }

    </script>

</body>

</html>