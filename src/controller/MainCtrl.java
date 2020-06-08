package controller;

import java.io.IOException;
import java.util.List;
import java.util.Vector;

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
		
		/*req.setAttribute("lists", lists);*/
		
		/*
		 * 모든 게시물을 담는 lists를 생성 후 게시글의 bname를 체크해서 구분해준다.
		 * 필요한 게시판은 다시 리스트를 만들어줘서 그 리스트에는 내용이 최대 6개가
		 * 담기도록 만들었다.  
		 * 
		 * 타이틀부분은 cut함수로 길이체크해서 넘어가면 잘라줘야하고
		 * 날짜 부분은 시간부분을 서브스트링으로 잘라주고 -를 .으로 바꿔줘야한다.
		 */
		List<BoardDTO> noticeList = new Vector<BoardDTO>();
		List<BoardDTO> freeboardList = new Vector<BoardDTO>();
		List<BoardDTO> photoList = new Vector<BoardDTO>();
		int noticeIndex = 0;
		int freeboardIndex = 0;
		int photoIndex = 0;
		for(BoardDTO dto : lists) {
			if(noticeIndex <= 5 && dto.getBname().equals("notice")){
				dto.setTitle(cut(dto.getTitle(), 20));
				dto.setPostdate(dto.getPostdate().substring(0, 10).replace("-", "."));
				noticeList.add(dto);
				noticeIndex++;
			}
			if(freeboardIndex <= 5 && dto.getBname().equals("freeboard")){
				dto.setTitle(cut(dto.getTitle(), 20));
				dto.setPostdate(dto.getPostdate().substring(0, 10).replace("-", "."));
				freeboardList.add(dto);
				freeboardIndex++;
			}
			if(photoIndex <= 5 && dto.getBname().equals("photo")){
				dto.setTitle(cut(dto.getTitle(), 8));
				photoList.add(dto);
				photoIndex++;
			}
			
		}
		req.setAttribute("noticeList", noticeList);
		req.setAttribute("freeboardList", freeboardList);
		req.setAttribute("photoList", photoList);

		
		
		dao.close();
		//페인화면으로 포워딩
		req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	private static String cut(String text, int size) {
		if(text.length() > size) {
			text = text.substring(0, size) + " ...";
		}
		
		return text;
	}
	
}
