package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.MembershipDAO;

public class FindIdCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("아이디 찾기 서블릿진입");
		ServletContext context = req.getSession().getServletContext();
		MembershipDAO dao = new MembershipDAO(context);
		
		String name = req.getParameter("findIdName");
		String email = req.getParameter("findIdEmail");
		String result = dao.findId(name, email);
		
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		try {
			JSONObject object = new JSONObject();
			PrintWriter out;
			
			out = resp.getWriter();
			object.put("findIdResult", result);
			out.print(object);
			out.flush();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
