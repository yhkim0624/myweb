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
            <div id="aboard-list-container">
            	<%-- <jsp:include page="list.jsp" /> --%>
            </div>
            <br /><br /><br /><br /><br />

        </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">

        $(function() {         

			// 팝업창 설정
    		var uri = "about:blank";
        	var popupName = "_blank";
        	var options = "width=900, height=600, left=200, top=100, location=no, menubar=no, status=no, toolbar=no";
        	
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

            // JQuery load()를 통해 list.jsp 삽입
        	$("#aboard-list-container").load("/myweb/aboard/list?pageNo=" + ${ pager.pageNo });
            
        	$(document).on('click', '#write', function(event) {
            	
	            if (${ empty loginuser }) {
	            	location.href = "/myweb/login";
	        	} else {
		        	var write = "/myweb/aboard/write";
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
					var list = $(this).attr("href");
					console.log(list);
					popUpCloseHandler(uri, popupName, list, options, function(popup) {
						$("#aboard-list-container").load("/myweb/aboard/list");
					});
				}
		    });
            
            if (${ empty loginuser }) {
            	$(".lists").attr("href", "/myweb/login");
        	}
        	
		});

    </script>

</body>

</html>