<%@page import="model.BoardDTO"%>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String title = request.getParameter("title");
String content = request.getParameter("content");

BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);

dto.setId(session.getAttribute("USER_ID").toString());

dto.setBname(bname);

BoardDAO dao = new BoardDAO(application);

int affected = dao.insertWrite(dto);

if(affected == 1){
	response.sendRedirect("sub01_list.jsp?bname=" + bname);
} else {
%>
	<script>
		alert("글쓰기에 실패하였습니다.");
		history.go(-1);
	</script>
<%
}
%>
