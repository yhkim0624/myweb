<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset='utf-8' />
<title>Home</title>
<link rel='Stylesheet' href='/myweb/resources/css/default.css' />
</head>
<body>

	<div id='pageContainer'>

		<jsp:include page="/WEB-INF/views/sidebar.jsp" />

		<div id='content'>
			<br /> <br /> <br />
			<h2 style='text-align: center'>${ serverTime }</h2>
		</div>
	</div>

</body>
</html>