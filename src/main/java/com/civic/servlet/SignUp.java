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

@WebServlet("/signup")
public class SignUp extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = new User();
		UserDAO udao = new UserDAOImpl();
		
		u.setName(req.getParameter("name"));
		u.setEmail(req.getParameter("email"));
		u.setPhone(req.getParameter("phone"));
		u.setPassword(req.getParameter("password"));
		u.setVillage(req.getParameter("village"));
		u.setRole("citizen");  // IMPORTANT: Always set role to citizen
		
		udao.registerUser(u);
		req.setAttribute("success", "Signed Up Successfully");
		req.getRequestDispatcher("signin.jsp").forward(req, resp);
	}
}