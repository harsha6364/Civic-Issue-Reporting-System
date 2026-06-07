package com.civic.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.civic.dao.MessageDAO;
import com.civic.dto.Message;
import com.civic.utility.Connector;

public class MessageDAOImpl implements MessageDAO {
	private Connection con;
	
	public MessageDAOImpl() {
		this.con = Connector.requestConnection();
	}
	@Override
	public boolean creatMessage(Message message) {
		String query = "INSERT INTO MESSAGE VALUES(0,?,?,?,?,?,?,?,?,?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, message.getTittle());
			ps.setString(2, message.getDescription());
			ps.setInt(3, message.getReportId());
			ps.setInt(4,message.getSentById());
			ps.setString(5, message.getSentByName());
			ps.setString(6, message.getSentByRole());
			ps.setInt(7,message.getRecieverId());
			ps.setString(8,message.getRecieverName());
			ps.setTimestamp(9,message.getSentAt());
			int i = ps.executeUpdate();
			if(i>0) {
				System.out.println("Message created successfully");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Failed to create message");
		}
		return true;

	}

	@Override
	public Message getMessageById(int id) {
		Message m = null;
		String query = "SELECT * FROM MESSAGE WHERE ID = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				m = new Message();
				m.setId(rs.getInt("id"));
				m.setTittle(rs.getString("title"));
				m.setDescription(rs.getString("description"));
				m.setReportId(rs.getInt("report_id"));
				m.setSentById(rs.getInt("sent_by_if"));
				m.setSentByName(rs.getString("sent_by_name"));
				m.setSentByRole(rs.getString("sent_by_role"));
				m.setRecieverId(rs.getInt("reciever_id"));
				m.setRecieverName(rs.getString(rs.getString("reciever_name")));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return m;
	}

	@Override
	public Message getMessageByReportId(int report_id) {
		Message m = null;
		String query = "SELECT * FROM MESSAGE WHERE REPORT_ID = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, report_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				m = new Message();
				m.setId(rs.getInt("id"));
				m.setTittle(rs.getString("title"));
				m.setDescription(rs.getString("description"));
				m.setReportId(rs.getInt("report_id"));
				m.setSentById(rs.getInt("sent_by_if"));
				m.setSentByName(rs.getString("sent_by_name"));
				m.setSentByRole(rs.getString("sent_by_role"));
				m.setRecieverId(rs.getInt("reciever_id"));
				m.setRecieverName(rs.getString(rs.getString("reciever_name")));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return m;
	}

	@Override
	public List<Message> getAllMessagesByRecieverId(int reciever_id) {
		List<Message> messages = new ArrayList<>();
		Message m = null;
		String query = "SELECT * FROM MESSAGE WHERE REPORT_ID = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, reciever_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				m = new Message();
				m.setId(rs.getInt("id"));
				m.setTittle(rs.getString("title"));
				m.setDescription(rs.getString("description"));
				m.setReportId(rs.getInt("report_id"));
				m.setSentById(rs.getInt("sent_by_if"));
				m.setSentByName(rs.getString("sent_by_name"));
				m.setSentByRole(rs.getString("sent_by_role"));
				m.setRecieverId(rs.getInt("reciever_id"));
				m.setRecieverName(rs.getString(rs.getString("reciever_name")));
				messages.add(m);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return messages;
	}

}
