<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("진입");
	/*
		경로 처리만 해주면 될거같음.
		내가 경로에 대해서 하나도 모르는거같다.
	*/
	String uploadPath = request.getSession().getServletContext().getRealPath("/summernoteImg");
	int size = 10 * 1024 * 1024;
	System.out.println(uploadPath);
	
	String fileName = "";
	
	try{
		MultipartRequest mr = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration files = mr.getFileNames();
		String file = (String)files.nextElement();
		fileName = mr.getFilesystemName(file);
	} catch(Exception e){
		e.printStackTrace();
	}
	
	uploadPath = request.getContextPath() + "/summernoteImg/" + fileName;
	System.out.println(uploadPath);
	
	JSONObject object = new JSONObject();
	object.put("url", uploadPath);
	
	response.setContentType("application/json");
	out.print(object);
	
	
%>