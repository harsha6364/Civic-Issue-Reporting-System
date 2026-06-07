package com.civic.dao;

import java.util.List;

import com.civic.dto.Message;

public interface MessageDAO {
	boolean creatMessage(Message message);
	Message getMessageById(int id);
	Message getMessageByReportId(int id);
	List<Message> getAllMessagesByRecieverId(int reciever_id);
}
