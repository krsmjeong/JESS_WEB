<%@ page import="com.exam.vo.MemberVo"%>
<%@ page import="com.exam.dao.MemberDao"%>
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
<%
   String id = session.getAttribute("id").toString();
   
   // 세션에 저장된 아이디를 가져와서
   // 그 아이디 해당하는 회원정보를 가져온다.
   MemberDao memberDao = MemberDao.getInstance();
   MemberVo memberVo = memberDao.getMemberById(id);
%>
<div id="wrap">
	<%-- header 영역 --%>
	
	<article>
		
	<h1>MyInfo</h1>
	<form id="join" action="updateMemberPro.jsp" method="post" name="frm">
	<fieldset>
		<legend>Detail Info</legend>
		
		<table id="logintb">
			<tr>
				<td>User ID</td>
				<td><%=memberVo.getId() %><br></td>
			</tr>
			<tr>
				<td>PassWord</td>
				<td><input type="password" name="passwd" class="pass pass1" value="<%=memberVo.getPasswd()%>"><br></td>
			</tr>
			<tr>
				<td>Retype Password</td>
				<td><input type="password" class="pass pass2" required></td>
				<td><span id="msgPass"></span></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><%=memberVo.getName() %><br></td>
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
					<td><%=memberVo.getAge()%><br></td>
				</tr>
				<tr>
					<td>Gender</td>
					<td><%=memberVo.getGender()%><br></td>
				</tr>
			</table>
		
	</fieldset>
	<%
		if (id.equals("myLord")) {
			%>
			<div class="clear"></div>
			<div id="buttons">
			<input type="button" value="수정불가" class="submit"> 
			<input type="button" value="돌아가기" class="cancel" onclick="location.href='/index.jsp'">
			<%
		} else { // id가 있으면
			%>
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="수정완료" class="submit"> 
				<input type="button" value="취소하기" class="cancel" id="infoCancel">
			</div>
			<%
		}
		%>
	
	</form> 
	
	</article>
	
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page="/include/bottomFooter.jsp" />
</div>
<script src="/script/jquery-3.5.1.js"></script>
<script>
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

	$("#infoCancel").click(function(){
	    if(confirm("수정을 취소 하시겠습니까 ?") == true){
	    	location.href = '/index.jsp'
	    }
	    else{
	        alert("취소되었습니다")
	    	return ;
	    }
	});
</script>
</body>
</html>   

    