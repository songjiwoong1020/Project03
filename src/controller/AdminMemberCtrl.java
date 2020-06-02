package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MembershipDAO;
import model.MembershipDTO;

public class AdminMemberCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		ServletContext context = req.getSession().getServletContext();

		MembershipDAO dao = new MembershipDAO(context);
		
		
		List<MembershipDTO> lists = dao.List();
		
		req.setAttribute("lists", lists);
		
		dao.close();
		
		req.getRequestDispatcher("/admin/tables/memberTable.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
