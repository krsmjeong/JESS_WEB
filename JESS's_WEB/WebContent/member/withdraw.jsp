<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
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
 MemberDao Dao = MemberDao.getInstance();
 MemberVo Vo = Dao.getMemberById(id);
%>
<div id="wrap">
	<article>
		<h1>회원탈퇴</h1>
		<form action="withdrawPro.jsp" method="post" id="join">
			<fieldset>
				<legend>for withdraw</legend>
				
				<table id="logintb">
					<tr>
						<td>User ID</td>
						<td><%=Vo.getId() %><br></td>
					</tr>	
					<tr>
						<td>PassWord</td>
						<td><input type="password" name="passwd" class="pass pass1" required><br></td>
					</tr>
				</table>
				
				<br>
			</fieldset>
			<%
		if (id.equals("myLord")) {
			%>
			<div class="clear"></div>
			<div id="buttons">
			<input type="button" value="탈퇴불가" class="submit"> 
			<input type="button" value="돌아가기" class="cancel" onclick="location.href='/index.jsp'">
			<%
		} else { // id가 있으면
			%>
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="회원탈퇴" class="submit" id="btnWithDraw">
				<input type="button" value="취소" class="cancel" onclick="location.href='/index.jsp'">
				<%-- onclick="location.href='/member/withdrawPro.jsp'" --%>
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
//패스워드 
	$('.pass2').focusout(function () {
		let pass1 = $('.pass1').val();
		let pass2 = $(this).val();
	
		if (pass1 == pass2) {
			$('#msgPass').html('패스워드가 일치합니다').css('color', 'green');
		} else {
			$('#msgPass').html('패스워드가 다릅니다').css('color', 'red');
		}
	});
	
	$("#btnWithDraw").click(function(){
	    if(confirm("정말 탈퇴하시겠습니까 ?") == true){
	    	location.href = 'withdrawPro.jsp'
	    }
	    else{
	        alert("취소되었습니다")
	    	return ;
	    }
	});
</script>

</body>
</html>   

    