package com.civic.dao;

import java.util.List;

import com.civic.dto.User;

public interface UserDAO {
	
	void registerUser(User u);
	
	User getUserByEmail(String email);
	
	User getUserByEmailPassword(String email, String password);
	
	User getUserById(int id);
	
	List<User> getAllUser();
	
	void updateUser(User u);
}
