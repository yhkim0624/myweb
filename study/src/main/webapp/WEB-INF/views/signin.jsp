<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<title>로그인</title>
<link rel="Stylesheet" href="/myweb/resources/css/default.css" />
<link rel="Stylesheet" href="/myweb/resources/css/input.css" />
</head>
<body>

	<div id="pageContainer">

		<jsp:include page="/WEB-INF/views/sidebar.jsp" />

		<div id="inputcontent">
			<br />
			<br />
			<div id="inputmain">
				<div class="inputsubtitle">로그인정보</div>

				<form id="login" action="login" method="post">

					<table>
						<tr>
							<th>아이디(ID)</th>
							<td><input type="text" name="memberId" style="width: 280px" />
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="passwd"
								style="width: 280px" /></td>
						</tr>
					</table>

					<div class="buttons">
						<input type="submit" value="로그인" style="height: 25px" /> <input
							id="cancel" type="button" value="취소" style="height: 25px" />
					</div>
				</form>

			</div>
		</div>

	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript">
	$(function() {
		$('#cancel').on('click', function(event) {
			location.href = "/myweb/";
		});
	});
	</script>

</body>
</html>