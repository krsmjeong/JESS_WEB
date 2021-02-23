<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 로그인 상태유지 쿠키정보 가져오기
Cookie[] cookies = request.getCookies();
// 쿠키 name이 "id"인 쿠키객체 찾기
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("id")) {
			String id = cookie.getValue();
			
			// 로그인 인증 처리(세션에 id값 추가)
			session.setAttribute("id", id);
		}
	}
}

// 세션값 가져오기
String id = (String) session.getAttribute("id");
// 세션값 있으면  ..님 반가워요~  [로그아웃]으로 바뀜. [회원가입]은 없어짐.
// 세션값 없으면  [로그인]  [회원가입]
%>
<header class="topHeader">
	<div class="login" align="right">
		<%
		if (id != null) {
			%>
			Welcome to Jess web! <%=id %>!
			<a href="/member/logout.jsp">Logout</a>
			| <a href="/member/userInfoForm.jsp">my page</a>
			| <a href="/member/withdraw.jsp">withdraw</a>
			<%
		} else { // id == null
			%>
			<a href="/member/skipPro.jsp">skip Login</a>
			 | <a href="/member/login.jsp">Login</a>
			 | <a href="/member/join.jsp">Join me</a>
			<%
		}
		%>
	</div>
	
	<div id="header-wrapper">
	<div id="header" class="container">
		<div id="logo">
			<h1><a href="/index.jsp">Jess's Web</a></h1>
		</div>
		<div id="menu">
			<ul class="current_page_item">
				<li><a href="/" title="">Homepage</a></li>
				<li><a href="/content/Portfolio/PortfolioBoard.jsp" title="">Portfolio</a></li>
				<li><a href="/content/AboutMe/AboutMe.jsp" title="">About Me</a></li>
				<li><a href="/content/ContactMe/ContactMe.jsp" title="">Contact Me</a></li>
			</ul>
		</div>
	</div>
</div>
</header>
<body>
<script type="text/javascript">

var current_page_item = document.getElementsByClassName('current_page_item');

for (var i = 0; i < current_page_item.length; i++) {
	current_page_item[i].addEventListener('click', function(){
    for (var j = 0; j < current_page_item.length; j++) {
    	current_page_item[j].style.color = "black";
    }
    this.style.color = "gold";
  })
}

</script>
</body>