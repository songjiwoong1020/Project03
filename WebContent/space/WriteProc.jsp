<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="model.BoardDTO"%>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%
request.setCharacterEncoding("UTF-8");




MultipartRequest mr = FileUtil.upload(request, request.getServletContext().getRealPath("/Upload"));

int sucOrFail;

if(mr != null){
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String fileName = mr.getParameter("attachedfile");
	
	File oldFile = null;
	File newFile = null;
	String realFileName = null;
	
	String nowTime = new SimpleDateFormat("yyyy_mm_dd_H_m_s_S").format(new Date());
	
	int idx = -1;
	
	idx = fileName.lastIndexOf(".");
	realFileName = nowTime + fileName.substring(idx, fileName.length());
	
	oldFile = new File(request.getServletContext().getRealPath("/Upload") + oldFile.separator + fileName);
	newFile = new File(request.getServletContext().getRealPath("/Upload") + oldFile.separator + realFileName);
	
	oldFile.renameTo(newFile);
	
	BoardDTO dto = new BoardDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setOfile(mr.getOriginalFileName("attachedfile"));
	dto.setSfile(realFileName);

	dto.setId(session.getAttribute("USER_ID").toString());
	dto.setBname(bname);

	BoardDAO dao = new BoardDAO(application);
	
	sucOrFail = dao.insertWrite(dto);

	dao.close();
} else {
	//mr객체가 생성되지 않았을때(업로드 실패 했을 때)
	sucOrFail = -1;
}
if(sucOrFail == 1){
	//성공
	response.sendRedirect("sub01_list.jsp?bname=" + bname);
} else {
	//실패
	%>
	<script>
		alert("글쓰기에 실패하였습니다.");
		history.go(-1);
	</script>
<%
}
%>
