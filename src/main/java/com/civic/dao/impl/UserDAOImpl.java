package com.civic.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.civic.dao.UserDAO;
import com.civic.dto.User;
import com.civic.utility.Connector;

public class UserDAOImpl implements UserDAO {
	private Connection con;
	
	public UserDAOImpl() {
		this.con = Connector.requestConnection();
	}

	@Override
	public void registerUser(User u) {
		// FIXED: Changed "defualt" to "DEFAULT"
		String query = "INSERT INTO users (name, email, mobile, password, role, village) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setString(1, u.getName());
			ps.setString(2, u.getEmail());
			ps.setString(3, u.getPhone());
			ps.setString(4, u.getPassword());
			ps.setString(5, u.getRole());
			ps.setString(6, u.getVillage());
			int i = ps.executeUpdate();
			
			if(i > 0) {
				System.out.println("User registered successfully");
			}
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to register user");
		}
	}

	@Override
	public User getUserByEmail(String email) {
		String query = "SELECT * FROM users WHERE email = ?";
		User u = null;
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPhone(rs.getString("mobile"));
				u.setPassword(rs.getString("password"));
				u.setRole(rs.getString("role"));
				u.setVillage(rs.getString("village"));
				u.setCreated_at(rs.getString("created_at"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return u;
	}

	@Override
	public User getUserByEmailPassword(String email, String password) {
		String query = "SELECT * FROM users WHERE email = ? AND password = ?";
		User u = null;
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPhone(rs.getString("mobile"));
				u.setPassword(rs.getString("password"));
				u.setRole(rs.getString("role"));
				u.setVillage(rs.getString("village"));
				u.setCreated_at(rs.getString("created_at"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return u;
	}

	@Override
	public User getUserById(int id) {
		String query = "SELECT * FROM users WHERE id = ?";
		User u = null;
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPhone(rs.getString("mobile"));
				u.setPassword(rs.getString("password"));
				u.setRole(rs.getString("role"));
				u.setVillage(rs.getString("village"));
				u.setCreated_at(rs.getString("created_at"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return u;
	}

	@Override
	public List<User> getAllUser() {
		List<User> users = new ArrayList<>();
		String query = "SELECT * FROM users ORDER BY id";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPhone(rs.getString("mobile"));
				u.setPassword(rs.getString("password"));
				u.setRole(rs.getString("role"));
				u.setVillage(rs.getString("village"));
				u.setCreated_at(rs.getString("created_at"));
				users.add(u);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	@Override
	public void updateUser(User u) {
		String query = "UPDATE users SET name = ?, email = ?, mobile = ?, village = ? WHERE id = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, u.getName());
			ps.setString(2, u.getEmail());
			ps.setString(3, u.getPhone());
			ps.setString(4, u.getVillage());
			ps.setInt(5, u.getId());
			ps.executeUpdate();
			ps.close();
			System.out.println("User updated successfully");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}