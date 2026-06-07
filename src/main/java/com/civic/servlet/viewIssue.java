package com.civic.servlet;

import java.io.IOException;
import java.util.List;

import com.civic.dao.IssueReportDAO;
import com.civic.dao.impl.IssueReportDAOImpl;
import com.civic.dto.IssueReport;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/viewIssue")
public class viewIssue extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IssueReportDAO reportDAO = new IssueReportDAOImpl();
		IssueReport issue = new IssueReport();
		HttpSession session = req.getSession();
		
		int id =Integer.parseInt(req.getParameter("id"));
		issue = reportDAO.getIssueReportById(id);
		
		req.setAttribute("issue", issue);
	    req.getRequestDispatcher("viewIssue.jsp").forward(req, resp);
		
	}
}
