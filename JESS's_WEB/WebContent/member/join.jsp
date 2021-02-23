<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 컨텐트 영역 --%>
<jsp:include page="/include/topHeader.jsp" />

<link href="/css/default.css" rel="stylesheet" type="text/css"  media="all">
</head>

<body>
<div id="wrap">
	<%-- header 영역 --%>
	
	<article>
		
	<h1>회원 가입</h1>
	<form id="join" action="joinPro.jsp" method="post" name="frm">
	<fieldset>
		<legend>Basic Info</legend>
		
		<table id="logintb">
			<tr>
				<td>User ID</td>
				<td><input type="text" name="id" class="id" required> </td>
				<td><input type="button" value="ID 중복확인" class="dup" id="btnDupChk"><br></td>
			</tr>
			<tr>
				<td>PassWord</td>
				<td><input type="password" name="passwd" class="pass pass1" required><br></td>
			</tr>
			<tr>
				<td>Retype Password</td>
				<td><input type="password" class="pass pass2" required></td>
				<td><span id="msgPass"></span></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><input type="text" name="name" class="nick" required><br></td>
			</tr>
			<tr>
				<td>E-Mail</td>
				<td><input type="email" name="email" class="email email1" required><br></td>
			</tr>
			<tr>
				<td>Retype E-mail</td>
				<td><input type="email" class="email email2" required></td>
				<td><span id="msgEmail"></span></td>
			</tr>
		</table>
	</fieldset>
	
	<fieldset>
		<legend>Optional</legend>
			<table>
				<tr>
					<td>Company</td>
					<td><input type="text" name="cname" class="cname"><br></td>
				</tr>
				<tr>
					<td>Phone Number</td>
					<td><input type="tel" name="tel" class="phone"><br></td>
				</tr>
				<tr>
					<td>Age</td>
					<td><input type="number" name="age" min="0" max="200" class="mobile"><br></td>
				</tr>
				<tr>
					<td>Gender</td>
					<td>
						<input type="radio" name="gender" value="남"> 남성
						<input type="radio" name="gender" value="여"> 여성
						<br>
					</td>
				</tr>
			</table>
		
	</fieldset>

	<div class="clear"></div>
	<div id="buttons">
		<input type="submit" value="회원가입" class="submit"> 
		<input type="reset" value="초기화" class="cancel">
	</div>
	</form> 
	
	</article>
	
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page="/include/bottomFooter.jsp" />
</div>

<script src="/script/jquery-3.5.1.js"></script>
<script>
	$('#btnDupChk').click(function () {
		
		let id = $('input[name="id"]').val();
		
		// id가 공백이면 '아이디 입력하세요' 포커스주기
		if (id == '') { // id.length == 0
			alert('아이디를 입력하세요');
			$('input[name="id"]').focus();
			return;
		}

		// id중복체크 창열기  joinIdDupCheck.jsp
		window.open('joinIdDupCheck.jsp?id=' + id, 'idDupCheck', 'width=500, height=400');
	});

	// 패스워드 
	$('.pass2').focusout(function () {
		let pass1 = $('.pass1').val();
		let pass2 = $(this).val();

		if (pass1 == pass2) {
			$('#msgPass').html('패스워드가 일치합니다').css('color', 'green');
		} else {
			$('#msgPass').html('패스워드가 다릅니다').css('color', 'red');
		}
	});

	$('.email2').focusout(function () {
		let email1 = $('.email1').val();
		let email2 = $(this).val();

		if (email1 == email2) {
			$('#msgEmail').html('이메일이 일치합니다').css('color', 'green');
		} else {
			$('#msgEmail').html('이메일이 다릅니다').css('color', 'red');
		}
	});

</script>
</body>
</html>   

    