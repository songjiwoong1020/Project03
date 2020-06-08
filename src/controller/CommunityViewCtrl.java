package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;
import model.BoardDTO;

public class CommunityViewCtrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String idx = req.getParameter("idx");
		String bname = req.getParameter("bname");
		String nowPage = req.getParameter("nowPage");
		
		
		ServletContext context = req.getSession().getServletContext();
		BoardDAO dao = new BoardDAO(context);
		BoardDTO dto = dao.selectView(idx);
		dao.updateVisitCount(idx);
		
		dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
		dao.close();
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("/community/community_view.jsp").forward(req, resp);
	}

}
