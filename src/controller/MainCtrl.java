package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;
import model.BoardDTO;

public class MainCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		ServletContext context = req.getSession().getServletContext();
		BoardDAO dao = new BoardDAO(context);
		/* 메인 화면에 출력할 용도로 모든 게시물을 다 받는건 낭비아닐까? */
		List<BoardDTO> lists = dao.List(); 
		
/*		int Index = 0;
		for(BoardDTO dto : list) {
			if(dto.getBname().equals("notice")){
				req.setAttribute("noticeTitle" + Index, dto.getTitle()); 
				req.setAttribute("noticePostdate" + Index, dto.getPostdate().substring(0, 10));
			}
		}
*/		req.setAttribute("lists", lists);
		
		
		dao.close();
		//페인화면으로 포워딩
		req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
}
