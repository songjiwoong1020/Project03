package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

public class AdminMainCtrl extends HttpServlet{
	
	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		
		req.getRequestDispatcher("/admin/main/adminMain.jsp").forward(req, res);
	}

}
