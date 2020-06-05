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
<%
request.setCharacterEncoding("UTF-8");

String bname = null;
String title = null;
String content = null;
String fileName = null;

File oldFile = null;
File newFile = null;
String realFileName = null;

MultipartRequest mr = FileUtil.upload(request, request.getServletContext().getRealPath("/upload"));
System.out.println("mr=" + mr);
int sucOrFail;

if(mr != null){
	bname = mr.getParameter("bname");
	title = mr.getParameter("title");
	content = mr.getParameter("content");
	fileName = mr.getFilesystemName("attachedfile");
	
	
	String nowTime = new SimpleDateFormat("yyyy_mm_dd_H_m_s_S").format(new Date());
	
	int idx = -1;
	
	BoardDTO dto = new BoardDTO();

	System.out.println("fileName=" + fileName);
	if(fileName != null){
		idx = fileName.lastIndexOf(".");
		
		realFileName = nowTime + fileName.substring(idx, fileName.length());
		System.out.println("realFileName=" + realFileName);
		
		oldFile = new File(request.getServletContext().getRealPath("/upload") + oldFile.separator + fileName);
		newFile = new File(request.getServletContext().getRealPath("/upload") + oldFile.separator + realFileName);
		System.out.println("oldFile=" + oldFile);
		System.out.println("newFile=" + newFile);
		
		oldFile.renameTo(newFile);
		dto.setOfile(mr.getOriginalFileName("attachedfile"));
		dto.setSfile(realFileName);
	} else {
		dto.setOfile(null);
		dto.setSfile(null);
	}

	
	dto.setTitle(title);
	dto.setContent(content);

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
