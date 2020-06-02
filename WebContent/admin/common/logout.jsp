<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- Logout.jsp --%>

<%
	session.removeAttribute("USER_ID");
	session.removeAttribute("USER_PASS");
	session.removeAttribute("USER_NAME");
	session.removeAttribute("USER_LV");
	session.invalidate();
%>	
	<script>
		alert("로그아웃 되었습니다.");
		location.href = "login.jsp";
	</script>
<%	

	//response.sendRedirect("login.jsp");
%>
