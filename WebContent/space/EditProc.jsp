<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 파일명 : EditProc.jsp --%>
<!-- 
	수정의 가능성
	첨부파일이 없던 글을 수정하는경우
		- 그대로 첨부파일 업로드 없이 등록
		- 새롭게 첨부파일을 추가해서 등록
	첨부파일이 있던 글을 수정하는경우
		- 기존에 있던 첨부파일을 그대로 등록
		- 기존에 있던 첨부파일을 삭제하고 등록
		- 기존에 있던 첨부파일을 삭제하고 새로운 첨부파일을 등록
 -->
<%@ include file="../include/isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String bname = null;
String title = null;
String content = null;
String fileName = null;
String idx = null;
String stayFile = null;

File oldFile = null;
File newFile = null;
String realFileName = null;

MultipartRequest mr = FileUtil.upload(request, request.getServletContext().getRealPath("/upload"));

int sucOrFail = 0;
BoardDTO dto = new BoardDTO();

if(mr != null){
	bname = mr.getParameter("bname");
	title = mr.getParameter("title");
	content = mr.getParameter("content");
	fileName = mr.getFilesystemName("attachedfile");
	stayFile = mr.getParameter("stayFile");
	idx = mr.getParameter("idx");
	if(stayFile == null) stayFile = "noStay";
	System.out.println("stayFile:" + stayFile);
	System.out.println("fileName:" + fileName);
	
	String nowTime = new SimpleDateFormat("yyyy_mm_dd_H_m_s_S").format(new Date());
	
	int idx2 = -1;
	
	dto.setIdx(idx);
	dto.setTitle(title);
	dto.setContent(content);
	
	dto.setBname(bname);
	
	BoardDAO dao = new BoardDAO(application);
	
	//파일네임이 null이 아닐때 => stayFile일 경우는 기존 파일을 삭제 안했을때, 그 외일경우 기존 파일을 삭제하고 새로운 파일을 만들었을때.
	if(fileName != null || !(stayFile.equals("noStay"))){
		System.out.println("첨부파일이 있을시 진입");
		if(stayFile.equals("stayFile")){
			System.out.println("첨부파일이 있을시 기존 첨부파일 데이터는 놔두고 나머지 데이터를 업데이트");
			sucOrFail = dao.updateEditNoFile(dto);
		} else {
			System.out.println("첨부파일이 있을시 새로운 첨부파일을 넣고 업데이트");
			idx2 = fileName.lastIndexOf(".");
			
			realFileName = nowTime + fileName.substring(idx2, fileName.length());
			System.out.println("realFileName=" + realFileName);
			
			oldFile = new File(request.getServletContext().getRealPath("/upload") + oldFile.separator + fileName);
			newFile = new File(request.getServletContext().getRealPath("/upload") + oldFile.separator + realFileName);
			System.out.println("oldFile=" + oldFile);
			System.out.println("newFile=" + newFile);
			
			oldFile.renameTo(newFile);
			dto.setOfile(mr.getOriginalFileName("attachedfile"));
			dto.setSfile(realFileName);

			sucOrFail = dao.updateEdit(dto);
		}
	//파일네임이 null 일때 => 기존 파일을 삭제 후 새로운 파일을 등록 안할시. 즉 파일이 사라져야함.
	} else {
		System.out.println("첨부파일이 없을시 진입\n저장되있던 첨부파일을 null처리 혹은 원래 첨부파일이 없었거나");
		dto.setOfile(null);
		dto.setSfile(null);
		sucOrFail = dao.updateEdit(dto);
	}
	dao.close();
	
} else {
	sucOrFail = -1;
}
if(sucOrFail == 1){
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
