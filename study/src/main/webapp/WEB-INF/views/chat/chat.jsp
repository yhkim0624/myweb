<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset='utf-8' />
<title>Home</title>
<link rel='Stylesheet' href='/myweb/resources/css/default.css' />
<style>
	html, body, #pageContainer, #content {
		height: 100%;
		overflow: hidden;
	}

	#userboard {
		float: left;
		position: relative;
		left: 5%;
		width: 20%;
		height: 63%;
		border: solid;
		overflow: scroll;
	}
	
	#chat {
		float: right;
		position: relative;
		left: -4.8%;
		width: 70%;
		height: 70%;
	}
	
	#messageArea {
		border: solid;
		height: 90%;
		overflow: scroll;
		text-align: left;
		padding-left: 10px;
	}
	
	#message {
		width: 70%;
	}
</style>
</head>
<body>

	<div id='pageContainer'>

		<jsp:include page="/WEB-INF/views/sidebar.jsp" />

		<div id='content' style="text-align:center;">
			<br /> <br /> <br />
			<h2 style='text-align: center'>Chat</h2>
			
			<div id="userboard">
				<h2>접속중인 멤버</h2>
				<div id="userList"></div>
			</div>
			
			<div id="chat">
				<div id="messageArea"></div>
				<br><br>
				<input type="hidden" id="memberId" value="${ loginuser.memberId }"/>
				<input type="text" id="message" />
				<input type="button" id="sendBtn" value="submit"/>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
	<script type="text/javascript">
		$("#sendBtn").click(function() {
			sendMessage();
			$('#message').val('')
		});
		$("#message").keydown(function(key) {
			if (key.keyCode == 13) {
				sendMessage();
				$('#message').val('')
			}
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
			
			if (data.startsWith("{")) {	// 접속멤버리스트용 json data일 경우
				console.log(data);
				var jsonData = JSON.parse(data)
				console.log(jsonData);
				$("#userList").empty();
				$.each(jsonData, function(key, value){
				    console.log(value);
				    $("#userList").append("<h3>" + value + "</h3>");
				});
			} else {	// 채팅용 message일 경우
				$("#messageArea").append("<h2>" + data + "</h2>");
				$('#messageArea').scrollTop($('#messageArea')[0].scrollHeight);
			}
		}
		
		// 서버와 연결을 끊었을 때
		function onClose(evt) {
			$("#messageArea").append("연결 끊김");
	
		}
</script>

</body>
</html>