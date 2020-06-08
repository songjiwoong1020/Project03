package controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import model.BoardDAO;
import model.BoardDTO;
import util.FileUtil;

public class CommunityWriteCtrl extends HttpServlet{
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String bname = req.getParameter("bname");
		req.getRequestDispatcher("community_write.jsp?bname=" + bname).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String bname = null;
		String title = null;
		String content = null;
		String fileName = null;
		String thumbnail = null;

		File oldFile = null;
		File newFile = null;
		String realFileName = null;

		MultipartRequest mr = FileUtil.upload(request, request.getServletContext().getRealPath("/upload"));
		//System.out.println("mr=" + mr);
		int sucOrFail;

		if(mr != null){
			bname = mr.getParameter("bname");
			title = mr.getParameter("title");
			content = mr.getParameter("content");
			fileName = mr.getFilesystemName("attachedfile");
			thumbnail = mr.getParameter("thumbnail");
			System.out.println("thumbnail=" + thumbnail);
			
			
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
			dto.setThumbnail(thumbnail);
			
			HttpSession session = request.getSession();

			dto.setId(session.getAttribute("USER_ID").toString());
			dto.setBname(bname);
			
			ServletContext context = request.getSession().getServletContext();
			BoardDAO dao = new BoardDAO(context);
			
			sucOrFail = dao.insertWrite(dto);

			dao.close();
		} else {
			sucOrFail = -1;
		}
		if(sucOrFail == 1){
			response.sendRedirect("../community/community.do?bname=" + bname);
		} else {
			request.getRequestDispatcher("/community_write.jsp?bname=" + bname)
			.forward(request,response);
		}

	}

}
