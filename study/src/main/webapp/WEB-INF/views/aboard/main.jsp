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

        	var popUpCloseHandler = function(uri, name, options, closeCallback) {
            	var popup = window.open(uri, name, options);
            	popup.location.href = "/myweb/aboard/write";
            	var interval = window.setInterval(function() {
                	try {
						if (popup === null || popup.closed) {
							window.clearInterval(interval);
							closeCallback(popup);
						}
                    } catch (e) {
						console.log("Interval error" + e);
                    }
                }, 1000);
                return popup;
	        }
               
        	$("#aboard-list-container").load("/myweb/aboard/list");
            
        	$(document).on('click', '#write', function (event) {
            	
	            if (${ empty loginuser }) {
	            	location.href = "/myweb/login";
	        	} else {
	        		var uri = "about:blank";
	            	var popupName = "_blank";
	            	var options = "width=900, height=600, left=200, top=100, location=no, menubar=no, status=no, toolbar=no";
	            	
		        	popUpCloseHandler(uri, popupName, options, function(popup) {
			        	//console.log("정상 확인 테스트");
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