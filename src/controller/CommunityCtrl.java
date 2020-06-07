package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;
import util.PagingUtil;

public class CommunityCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext context = req.getSession().getServletContext();
		BoardDAO dao = new BoardDAO(context);
		
		Map param = new HashMap();
		
		String bname = req.getParameter("bname");
		
		param.put("bname", bname);
		
		String addQueryString = "";
		
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		if(!(searchWord==null || searchWord.equals("")))
		{
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", 
					searchColumn, searchWord);
			param.put("Column", searchColumn);
			param.put("Word", searchWord);
			
		}
		int totalRecordCount = dao.getTotalRecordCount(param);
		param.put("totalCount", totalRecordCount);
		
		ServletContext application = this.getServletContext();
		int pageSize = 10;
		int blockPage = 5;
		
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);		
		
		int nowPage = (req.getParameter("nowPage")==null
				|| req.getParameter("nowPage").equals("")) ?
						1 : Integer.parseInt(req.getParameter("nowPage"));
		
		int start = (nowPage-1)*pageSize;
		int end = pageSize;
		
		param.put("start", start);
		param.put("end", end);
		param.put("totalPage", totalPage);
		param.put("nowPage", nowPage);
		param.put("totalCount", totalRecordCount);
		param.put("pageSize", pageSize);
		
		
		String pagingImg = PagingUtil.pagingBS4(totalRecordCount, 
				pageSize, blockPage, nowPage,
				"../DataRoom/DataList?"+addQueryString);
		param.put("pagingImg", pagingImg);		
		
		
		List<BoardDAO> lists = dao.selectListPage(param);	

		
		dao.close();
		
		req.setAttribute("lists", lists);
		req.setAttribute("map", param);
		req.getRequestDispatcher("/community/community_list.jsp?bname=" + bname).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
