<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8" />
    <title>게시판2</title>
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
            <h2>게시판 2 (AJAX)</h2>
            <br />
            <div style="float:right;margin-right:100px;">
                <div class="dataTables_length" id="dataTable_length" style="margin-bottom:15px">
	                <select id="searchType" name="searchType" style="height:24px">
	                    <option value="T" ${ param.searchType == 'T' ? 'selected' : '' }>제목</option>
	                    <option value="C" ${ param.searchType == 'C' ? 'selected' : '' }>내용</option>
	                    <option value="TC" ${ param.searchType == 'TC' ? 'selected' : '' }>제목+내용</option>
	                    <option value="W" ${ param.searchType == 'W' ? 'selected' : '' }>작성자</option>
	                </select>
	                <input type="search" id="searchKey" name="searchKey" placeholder="" value="${ param.searchKey }" />
	                <input type="button" id="searchBtn" value="검색" />
                </div>
            </div>
            <div id="aboard-list-container">
            	<jsp:include page="list.jsp" />
            </div>
            <br /><br /><br /><br /><br />

        </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">

        $(function() {
        	
        	// Page 처리 : [처음]
        	$(document).on('click', '#first', function(event) {
        		event.preventDefault();
        		var searchType = $("#searchType").val() === null ? '' : "&searchType=" + $("#searchType").val();
            	var searchKey = $("#searchKey").val() === null ? '' : "&searchKey=" + $("#searchKey").val();
                $("#aboard-list-container").load("/myweb/aboard/list?pageNo=1" + searchType + searchKey);
            });
        	
        	// Page 처리 : [숫자페이지]
    		$(document).on('click', '.numPage', function(event) {
    			event.preventDefault();

    			var searchType = $("#searchType").val() === null ? '' : "&searchType=" + $("#searchType").val();
            	var searchKey = $("#searchKey").val() === null ? '' : "&searchKey=" + $("#searchKey").val();
    			var pageNo = $(this).html();
    			
                $("#aboard-list-container").load("/myweb/aboard/list?pageNo=" + pageNo + searchType + searchKey);
            });
        	
        	// Page 처리 : [마지막]
            $(document).on('click', '#last', function(event) {
            	event.preventDefault();

            	var searchType = $("#searchType").val() === null ? '' : "&searchType=" + $("#searchType").val();
            	var searchKey = $("#searchKey").val() === null ? '' : "&searchKey=" + $("#searchKey").val();
            	var pageCount = $(this).data("count");
            	
            	$("#aboard-list-container").load("/myweb/aboard/list?pageNo=" + pageCount + searchType + searchKey);
            });

			// 검색버튼 이벤트
			$("#searchBtn").on('click', function(event) {
				$.ajax({
	                url: "/myweb/aboard/main",
	                type: "GET",
	                success: function (data, status, xhr) {
	                	$("#aboard-list-container").load("/myweb/aboard/list?searchType=" + $("#searchType").val() + "&searchKey=" + $("#searchKey").val());
	                },
	                error: function (xhr, status, err) {
	                    alert('검색 실패');
	                }
	            });
			});
        	
			// 팝업창 설정
    		var uri = "about:blank";
        	var popupName = "_blank";
        	var popupX = (window.screen.width / 2) - (900 / 2);
        	var popupY= (window.screen.height / 2) - (600 / 2);
        	var options = `width=900, height=600, left=${popupX}, top=${popupY}, location=no, menubar=no, status=no, toolbar=no`;
        	
        	// 팝업창을 감시해서 닫히면(close) => closeCallback()
        	var popUpCloseHandler = function(uri, name, location, options, closeCallback) {
            	var popup = window.open(uri, name, options);
            	popup.location.href = location;
            	var interval = window.setInterval(function() {
                	try {
						if (popup === null || popup.closed) {
							window.clearInterval(interval);
							closeCallback(popup);
						}
                    } catch (e) {
						console.log("popUpCloseHandler error: " + e);
                    }
                }, 1000);
                return popup;
	        }            
            
        	$(document).on('click', '#write', function(event) {
            	
	            if (${ empty loginuser }) {
	            	location.href = "/myweb/login";
	        	} else {
		        	var type = "write"
		        	var write = "/myweb/aboard?type=" + type;
	            	// 팝업창이 닫혔을 때 JQuary load()를 통해 list.jsp 갱신
		        	popUpCloseHandler(uri, popupName, write, options, function(popup) {
		        		$("#aboard-list-container").load("/myweb/aboard/list"); // 글작성 후엔 최신 페이지로
			        });
	        	}
	        });

	        $(document).on('click', '.lists', function(event) {

				event.preventDefault();
		        
		        if (${ empty loginuser }) {
					location.href = "/myweb/login";
				} else {
					var list = "/myweb/aboard/" + $(this).data("bno");
					console.log(list);
					popUpCloseHandler(uri, popupName, list, options, function(popup) {
						$("#aboard-list-container").load("/myweb/aboard/list");
					});
				}
		    });
        	
		});

    </script>

</body>

</html>