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

		<div id='content' style="text-align:center;">
			<br /> <br /> <br />
			<h2 style='text-align: center'>Chat</h2>
			<input type="hidden" id="memberId" value="${ loginuser.memberId }"/>
			<input type="text" id="message" />
			<input type="button" id="sendBtn" value="submit"/>
			<div id="messageArea"></div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
	<script type="text/javascript">
		$("#sendBtn").click(function() {
			sendMessage();
			$('#message').val('')
		});
	
		let sock = new SockJS("/myweb/echo");
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		// 메시지 전송
		function sendMessage() {
			sock.send($("#memberId").val() + ": " + $("#message").val());
		}
		// 서버로부터 메시지를 받았을 때
		function onMessage(msg) {
			var data = msg.data;
			console.log(msg);
			$("#messageArea").append("<h2>" + data + "</h2>");
		}
		// 서버와 연결을 끊었을 때
		function onClose(evt) {
			$("#messageArea").append("연결 끊김");
	
		}
</script>

</body>
</html>