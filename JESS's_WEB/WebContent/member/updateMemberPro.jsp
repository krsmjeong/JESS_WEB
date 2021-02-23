<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 액션태그로 VO 객체 준비 --%>
<jsp:useBean id="memberVo" class="com.exam.vo.MemberVo" />
<%-- 액션태그로 VO객체에 파라미터값 저장 --%>
<jsp:setProperty property="*" name="memberVo" />
    
<%
//DAO 객체 준비
MemberDao memberDao = MemberDao.getInstance();
//회원가입 메서드 호출
memberDao.UpdateMemberInfo(memberVo);
%>
<script>
	alert('회원정보 수정 성공');
	location.href = 'userInfoForm.jsp';
</script>