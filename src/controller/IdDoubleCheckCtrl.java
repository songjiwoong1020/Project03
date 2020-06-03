package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.MembershipDAO;

public class IdDoubleCheckCtrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//DAO생성
		ServletContext context = req.getSession().getServletContext();
		MembershipDAO dao = new MembershipDAO(context);
		
		//클라이언트가 입력한 값 ajax로 받아옴
		String idDoubleCheckVal = req.getParameter("idDoubleCheckVal");
		
		//데이터베이스에서 중복되는 아이디가 있는지 확인 있으면 false
		boolean result = dao.idDoubleCheck(idDoubleCheckVal);
		
		//이게 있어야 하는거 같다.
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		
		try {
			//심플제이슨으로 제이슨 오브젝트를 만들어서
			JSONObject object = new JSONObject();
			//프린트라이터를 준비해주고
			PrintWriter out;
			
			if(result) {
				//한줄로 써도 될거같긴 한데 더 건드릴 엄두가 안난다..
				out = resp.getWriter();
				object.put("message", "<span>사용 가능한 아이디입니다!</span>");
				object.put("doubleCheckResult", "true");
				out.print(object);
				out.flush();
			} else {
				out = resp.getWriter();
				object.put("message", "<span style='color:red;'> 해당 아이디는 사용 할 수 없습니다. </span>");
				object.put("doubleCheckResult", "false");
				out.print(object);
				out.flush();
			}
			dao.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
