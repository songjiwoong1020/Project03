<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String bname = request.getParameter("bname");
if(bname == null || bname.equals("")){
	JavascriptUtil.jsAlertLocation("필수파라미터누락됨", "../index.jsp", out);
	return;
}

String boardTitle ="";
String imgSrc ="";
switch(bname){
case "notice":
	boardTitle = "공지사항";
	imgSrc ="../images/space/sub01_title.gif";
	break;
case "calendar":
	boardTitle = "프로그램일정";
	imgSrc ="../images/space/sub02_title.gif";
	break;
case "freeboard":
	boardTitle = "자유게시판";
	imgSrc ="../images/space/sub03_title.gif";
	break;
case "photo":
	boardTitle = "사진게시판";
	imgSrc ="../images/space/sub04_title.gif";
	break;
case "dataroom":
	boardTitle = "정보자료실";
	imgSrc ="../images/space/sub05_title.gif";
	break;
case "staffDataroom":
	boardTitle = "직원자료실";
	imgSrc ="../images/community/sub01_title.gif";
	break;
case "guardian":
	boardTitle = "보호자 게시판";
	imgSrc ="../images/community/sub02_title.gif";
	break;
}
%>
	