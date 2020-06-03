package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MembershipDAO;
import model.MembershipDTO;

public class SignUpCtrl extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String name = req.getParameter("name");
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		String tel1 = req.getParameter("tel1");
		String tel2 = req.getParameter("tel2");
		String tel3 = req.getParameter("tel3");
		String mobile1 = req.getParameter("mobile1");
		String mobile2 = req.getParameter("mobile2");
		String mobile3 = req.getParameter("mobile3");
		String email1 = req.getParameter("email1");
		String email2 = req.getParameter("email2");
		String zip1 = req.getParameter("zip1");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		String openEmail = req.getParameter("openEmail");//null or on
		
		String tel = tel1 + tel2 + tel3;
		String mobile = mobile1 + mobile2 + mobile3;
		String email = email1 + "@" + email2;
		String addr = zip1 + addr1 + addr2;
		
		if(openEmail == null) {
			openEmail = "off";
		}

		ServletContext context = req.getSession().getServletContext();
		MembershipDAO dao = new MembershipDAO(context);
		MembershipDTO dto = new MembershipDTO();
		dto.setName(name);
		dto.setId(id);
		dto.setPass(pass);
		dto.setPhone(tel);
		dto.setCellphone(mobile);
		dto.setEmail(email);
		dto.setAddress(addr);
		
		int result = dao.signUp(dto, openEmail);
		
		if(result == 1) {
			HttpSession session=req.getSession();
			session.setAttribute("SUCCESS_SIGNUP", "<script>alert('회원가입이 완료 되었습니다!');</script>");
			dao.close();
			resp.sendRedirect("../main/main.do");
		} else {
			dao.close();
			req.getRequestDispatcher("/member/join02.jsp").forward(req, resp);
		}
		
	}

}
