package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.MembershipDAO;
import smtp.SMTPAuth;

public class FindPassCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext context = req.getSession().getServletContext();
		MembershipDAO dao = new MembershipDAO(context);

		String id = req.getParameter("findPassId");
		String name = req.getParameter("findPassName");
		String email = req.getParameter("findPassEmail");
		System.out.println("비번 찾기 서블릿에서 받은 데이타");
		System.out.println("id=" + id + " name=" + name + " email=" + email);
		
		String result = dao.findPass(id, name, email);

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		System.out.println("result = " + result);
		if(result.equals("fail")) {
			//일치하는 정보가 없으면.. result에 fail로 전송..
		} else {
			SMTPAuth smtp = new SMTPAuth();
			
			Map<String, String> emailContent = new HashMap<String, String>();
			emailContent.put("from", "swan0511@naver.com");
			emailContent.put("to", email);
			emailContent.put("subject", "비밀번호 찾기 답변입니다.");
			emailContent.put("content", "회원님의 비밀번호는 [" + result + "]입니다.");
			
			boolean emailResult = smtp.emailSending(emailContent);
			if(emailResult == true){
				System.out.println("메일 발송 성공");
			} else {
				System.out.println("메일 발송 성공");
			}
			
		}
		try {
			JSONObject object = new JSONObject();
			PrintWriter out;
			
			out = resp.getWriter();
			object.put("findPassResult", result);
			out.print(object);
			out.flush();
			dao.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
