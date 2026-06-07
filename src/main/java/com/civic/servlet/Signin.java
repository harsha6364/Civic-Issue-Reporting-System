package com.civic.servlet;

import java.io.IOException;

import com.civic.dao.UserDAO;
import com.civic.dao.impl.UserDAOImpl;
import com.civic.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/signin")
public class Signin extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UserDAO udao = new UserDAOImpl();
		User u = new User();
		HttpSession session = req.getSession();
		
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		u = udao.getUserByEmailPassword(email, password);
		if(u != null) {
			if("super-admin".equalsIgnoreCase(u.getRole())) {
				session.setAttribute("user", u);
				
				req.setAttribute("Success", "Loged in successfully");
				req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
			}else if("admin".equalsIgnoreCase(u.getRole())) {
				session.setAttribute("user", u);
				
				req.setAttribute("Success", "Loged in successfully");
				req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
			}else {
				session.setAttribute("user", u);
				
				req.setAttribute("Success", "Loged in successfully");
				req.getRequestDispatcher("userDashboard.jsp").forward(req, resp);
			}
		}
		else {
			req.setAttribute("error", "Failed to login");
			req.getRequestDispatcher("signin.jsp").forward(req, resp);
		}
		
	}
}
