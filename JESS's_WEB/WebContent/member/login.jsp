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
	<article>
		<h1>로그인</h1>
		<form action="loginPro.jsp" method="post" id="join">
			<fieldset>
				<legend>Login Info</legend>
				
				<table id="logintb">
					<tr>
						<td>ID</td>
						<td><input type="text" name="id"><br></td>
					</tr>
					<tr>
						<td>PassWord</td>
						<td><input type="password" name="passwd"><br></td>
					</tr>
				</table>
						<label>로그인 상태 유지</label>
						<input type="checkbox" name="keepLogin" value="true">
				
				<br>
			</fieldset>
			
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="로그인" class="submit">
				<input type="button" value="회원가입" class="cancel" onclick="location.href='/member/join.jsp'">
			</div>
		</form>
	</article>
	
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page="/include/bottomFooter.jsp" />
</div>

</body>
</html>   

    