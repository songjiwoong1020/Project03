<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 파일명 : EditProc.jsp --%>
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

//String bname = request.getParameter("bname");
String idx = request.getParameter("idx");
String title = request.getParameter("title");
String content = request.getParameter("content");

BoardDTO dto = new BoardDTO();
dto.setIdx(idx);
dto.setTitle(title);
dto.setContent(content);

BoardDAO dao = new BoardDAO(application);

int affected = dao.updateEdit(dto);
if(affected == 1){
	response.sendRedirect("sub01_view.jsp?bname=" + bname + "&idx=" + dto.getIdx());
} else {
%>
	<script>
		alert("수정하기에 실패하였습니다.");
		history.go(-1);
	</script>
<%
}
%>
