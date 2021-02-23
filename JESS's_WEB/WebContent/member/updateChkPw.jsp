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

String passwd = request.getParameter("passwd");

//DAO 객체 준비
MemberDao memberDao = MemberDao.getInstance();
MemberVo memberVo = memberDao.getMemberById(id);


%>
<div id="wrap">
	<%-- header 영역 --%>
	
	<article>
		
	<h1>유저확인</h1>
	<form id="join" action="userInfoUpdateForm.jsp" method="post" name="frm">
	<fieldset>
		<legend>비밀번호를 한번 더 입력해주세요</legend>
		
		<table id="logintb">
			<tr>
				<td>User ID</td>
				<td><%=memberVo.getId() %><br></td>
			</tr>
			<tr>
				<td>PassWord</td>
				<td><input type="password" name="passwd" class="pass pass1" required><br></td>
			</tr>
		</table>
	</fieldset>
	<%
		if (id.equals("myLord")) {
			%>
			<div class="clear"></div>
			<div id="buttons">
			<input type="button" value="확인" class="submit"> 
			<input type="button" value="돌아가기" class="cancel" onclick="location.href='/index.jsp'">
			<%
		} else { // id가 있으면
			%>
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="확인" class="submit" id="chkPw"> 
				<input type="button" value="돌아가기" class="cancel" id="infoCancel">
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

	$("#chkPw").click(function(){
	    if(confirm("메인화면으로 돌아가시겠습니까 ?") == true){
	    	location.href = '/index.jsp'
	    }
	    else{
	    	<%
	    	//로그인 확인.
	    	//check -1  없는 아이디
	    	//check  0  패스워드 틀림
	    	//check  1  아이디, 패스워드 모두 일치
	    	int check = memberDao.userCheck(id, passwd);

	    	//비밀번호 틀리면
	    	if (check != 1) {
	    		%>
	    		<script>
	    			alert('패스워드가 일치하지 않습니다.');
	    			history.back();
	    		</script>	
	    		<%
	    		return;
	    	}
	    	%>
	    }
	});

	$("#infoCancel").click(function(){
	    if(confirm("메인화면으로 돌아가시겠습니까 ?") == true){
	    	location.href = '/index.jsp'
	    }
	    else{
	    	return ;
	    }
	});
</script>

</body>
</html>   

    