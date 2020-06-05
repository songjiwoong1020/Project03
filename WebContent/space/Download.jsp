<%@page import="util.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ofilename = request.getParameter("ofilename");
String sfilename = request.getParameter("sfilename");

FileUtil.download(request, response, "/upload", sfilename, ofilename);
%>
