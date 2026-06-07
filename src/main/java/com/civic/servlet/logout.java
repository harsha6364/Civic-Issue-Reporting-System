package com.civic.servlet;

import java.io.IOException;

import com.civic.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class logout extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		
		if (session != null) {
            User u = (User) session.getAttribute("user");
            if (u != null) {
                session.invalidate();
                req.setAttribute("logout", "Logout successful");
            } else {
                req.setAttribute("error", "Session already expired");
            }
        } else {
            req.setAttribute("error", "No active session");
        }
        
        req.getRequestDispatcher("signin.jsp").forward(req, resp);
		
		
	}
}
