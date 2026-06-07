package com.civic.servlet;

import java.io.IOException;
import java.sql.Connection;

import com.civic.dto.User;

import com.civic.dao.IssueReportDAO;
import com.civic.dao.impl.IssueReportDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateIssueStatus")
public class UpdateIssueStatus extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User u = (User) session.getAttribute("user");
		IssueReportDAO reportDAO= new IssueReportDAOImpl();
		
		int id =Integer.parseInt(req.getParameter("id"));
		String status = req.getParameter("status");
		int i = reportDAO.updateIssueStatus(id,status);
		if(i==1) {
			req.setAttribute("success", "Status Updated successfully");
			req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
		}else {
			req.setAttribute("failed", "Failed to update status");
			req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
		}
	}
}
