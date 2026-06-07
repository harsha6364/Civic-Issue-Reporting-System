package com.civic.servlet;

import java.io.IOException;

import com.civic.dao.IssueReportDAO;
import com.civic.dao.MessageDAO;
import com.civic.dao.UserDAO;
import com.civic.dao.impl.IssueReportDAOImpl;
import com.civic.dao.impl.MessageDAOImpl;
import com.civic.dao.impl.UserDAOImpl;
import com.civic.dto.IssueReport;
import com.civic.dto.Message;
import com.civic.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/sendMessage")
public class MessageServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Message message = new Message();
		HttpSession session = req.getSession();
		MessageDAO messageDAO = new MessageDAOImpl();
		IssueReportDAO reportDAO = new IssueReportDAOImpl();
		UserDAO UDAO = new UserDAOImpl();
//		User u = new User();
		
		Integer issueId = Integer.parseInt(req.getParameter("issueId"));
		System.out.println("Issue Id = " + issueId);
		IssueReport issue = reportDAO.getIssueReportById(issueId);
		System.out.println("Issue Object = " + issue);
		
		Integer userId = Integer.parseInt(req.getParameter("userId"));
		User u = UDAO.getUserById(userId);
		
		String title = req.getParameter("subject");
		String description = req.getParameter("message");
		Integer recieverId =Integer.parseInt( req.getParameter("recieverId"));
		String recieverName = req.getParameter("recieverName");
		Integer senderId = Integer.parseInt(req.getParameter("senderId"));
		String senderName = req.getParameter("senderName");
		String senderRole = req.getParameter("senderRole");
		message.setTittle(title);
		message.setDescription(description);
		message.setRecieverId(recieverId);
		message.setRecieverName(recieverName);
		message.setSentById(senderId);
		message.setSentByName(senderName);
		message.setSentByRole(senderRole);
		
		boolean messageSent = messageDAO.creatMessage(message);
		if(messageSent) {
		    req.setAttribute("messageSent", "Message sent successfully");
		    req.setAttribute("issue", issue);
		    req.setAttribute("user", u);
		    req.getRequestDispatcher("viewIssue.jsp").forward(req, resp);
		} else {
		    req.setAttribute("messageNotSent", "Failed to send message");
		    req.setAttribute("issue", issue);
		    req.setAttribute("user", u);
		    req.getRequestDispatcher("viewIssue.jsp").forward(req, resp);
		}
		
	}
	
}
