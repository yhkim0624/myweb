<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<title>사용자등록</title>
<link rel="Stylesheet" href="/myweb/resources/css/default.css" />
<link rel="Stylesheet" href="/myweb/resources/css/input.css" />

</head>
<body>

	<div id="pageContainer">

		<jsp:include page="/WEB-INF/views/sidebar.jsp" />

		<div id="inputcontent">
			<br /> <br />
			<div id="inputmain">
				<div class="inputsubtitle">회원기본정보</div>

				<form id="registerform" action="register" method="post">
					<!-- 상대경로표시 -->
					<table>
						<tr>
							<th>아이디(ID)</th>
							<td><input type="text" id="memberId" name="memberId"
								style="width: 280px" placeholder="첫글자 영문, 영문 or 숫자 4~12자리" /></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" id="passwd" name="passwd"
								style="width: 280px" placeholder="영문, 숫자, 특수문자 8~20자리" /></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td><input type="password" id="confirm" name="confirm"
								style="width: 280px" placeholder="비밀번호 확인" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" id="email" name="email"
								style="width: 280px" placeholder="ex) abc@abc.com" /></td>
						</tr>

					</table>
					<div class="buttons">
						<input id="register" type="submit" value="등록" style="height: 25px" />
						<input id="cancel" type="button" value="취소" style="height: 25px" />

					</div>
				</form>
			</div>
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript">
		$(function() {

			$('#registerform').on('submit', function(e) {
				// 유호성 체크용 정규표현식
				var checkId = new RegExp("^[a-zA-Z][a-zA-Z0-9]{3,11}$","g");
				var checkPswd = new RegExp("^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$", "g");
				var checkEmail = new RegExp("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$", "g");

				// 유효성 체크
				if (!checkId.test($('#memberId').val())) {
					alert("아이디 형식에 맞지 않습니다.");
					$('#memberId').val("");
					$('#memberId').focus();
					return false;
				} else if (!checkPswd.test($('#passwd').val())) {
					alert("비밀번호 형식에 맞지 않습니다.");
					$('#passwd').val("");
					$('#passwd').focus();
					return false;
				} else if ($('#passwd').val() !== $('#confirm').val()) {
					alert("비밀번호가 일치하지 않습니다.");
					$('#confirm').val("");
					$('#confirm').focus();
					return false;
				} else if (!checkEmail.test($('#email').val())) {
					alert("이메일 형식이 맞지 않습니다.");
					$('#email').val("");
					$('#email').focus();
					return false;
				} else {
					return true;
				}
			});
			
		});

	
		$(function() {
			$('#cancel').on('click', function(event) {
				location.href = "/myweb/";
			});
		});
	</script>

</body>
</html>