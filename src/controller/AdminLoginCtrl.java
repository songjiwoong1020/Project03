package controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MembershipDAO;

public class AdminLoginCtrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String inputId = req.getParameter("inputId");
		String inputPassword = req.getParameter("inputPassword");
		
		
		ServletContext context = req.getSession().getServletContext();
		MembershipDAO dao = new MembershipDAO(context);
		
		Map<String, String> memberInfo = dao.login(inputId, inputPassword);
		
		HttpSession session=req.getSession();
		

		if(memberInfo.get("id") == null) {
			
			System.out.println("로그인실패-아이디 비밀번호 불일치(여긴 AdminLoginCtrl서블렛)");
			//req.setAttribute("LOGIN_FAIL", "<div style=\"font-size: 1.5em; color: red;\">아이디와 비밀번호를 확인하세요</div>");
			req.setAttribute("LOGIN_FAIL", "<script>alert('아이디와 비밀번호를 확인하세요');</script>");
			dao.close();
			req.getRequestDispatcher("/admin/common/login.jsp").forward(req, resp);
			
			
		} else {

			if(!memberInfo.get("memberlv").equals("5")) {
				
				System.out.println("로그인실패-관리자 권한이 아닌 계정(여긴 AdminLoginCtrl서블렛)");
				//req.setAttribute("LOGIN_FAIL", "<div style=\\\"font-size: 1.5em; color: red;\\\">관리자 권한이 없는 계정입니다.</div>");
				req.setAttribute("LOGIN_FAIL", "<script>alert('관리자 권한이 없는 계정입니다.');</script>");
				dao.close();
				req.getRequestDispatcher("/admin/common/login.jsp").forward(req, resp);
				
			} else {
				
				session.setAttribute("USER_ID", memberInfo.get("id"));
				session.setAttribute("USER_NAME", memberInfo.get("name"));
				session.setAttribute("USER_PASS", memberInfo.get("pass"));
				session.setAttribute("USER_LV", memberInfo.get("memberlv"));
				
				System.out.println(memberInfo.get("id") + "로그인 성공(여긴 AdminLoginCtrl서블렛)");
				dao.close();
				req.getRequestDispatcher("/admin/main/adminMain.jsp").forward(req, resp);
			}
		}
		
			
		
	}

}
