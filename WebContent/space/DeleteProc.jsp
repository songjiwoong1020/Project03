<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../common/isLogin.jsp" %> --%>
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String idx = request.getParameter("idx");

BoardDTO dto = new BoardDTO();
BoardDAO dao = new BoardDAO(application);

dto = dao.selectView(idx);

String session_id = session.getAttribute("USER_ID").toString();
System.out.println("디티오에 저장된 아이디: " + dto.getId() + "세션에 저장된 아이디:" + session_id);
int affected = 0;
if(session_id.equals(dto.getId())){
	dto.setIdx(idx);
	affected = dao.delete(dto);
} else {
	JavascriptUtil.jsAlertBack("본인만 삭제가능합니다.", out);
	return;
}
if(affected == 1){
	JavascriptUtil.jsAlertLocation("삭제되었습니다", "sub01_list.jsp?bname=" + bname, out);
} else {
	out.println(JavascriptUtil.jsAlertBack("삭제실패하였습니다."));
}
%>
