package com.civic.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.civic.dao.CategoryDAO;
import com.civic.dto.Category;
import com.civic.utility.Connector;

public class CategoryDAOImpl implements CategoryDAO {
	private Connection con;
	
	public CategoryDAOImpl() {
		this.con = Connector.requestConnection();
	}

	@Override
	public List<Category> getAllCategories() {
		List<Category> categories = new ArrayList<>();
		String query = "SELECT id, name FROM categories ORDER BY id";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				categories.add(c);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to get categories");
		}
		return categories;
	}

	@Override
	public Category getCategoryById(int id) {
		Category c = null;
		String query = "SELECT id, name FROM categories WHERE id = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				c = new Category();  // Initialize object FIRST!
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to get category by id");
		}
		return c;
	}

	@Override
	public Category getCategoryByName(String name) {
		Category c = null;
		String query = "SELECT id, name FROM categories WHERE name = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return c;
	}

	@Override
	public void addCategory(Category category) {
		String query = "INSERT INTO categories (name) VALUES (?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, category.getName());
			ps.executeUpdate();
			ps.close();
			System.out.println("Category added successfully");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to add category");
		}
	}

	@Override
	public void updateCategory(Category category) {
		String query = "UPDATE categories SET name = ? WHERE id = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, category.getName());
			ps.setInt(2, category.getId());
			ps.executeUpdate();
			ps.close();
			System.out.println("Category updated successfully");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteCategory(int id) {
		String query = "DELETE FROM categories WHERE id = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ps.executeUpdate();
			ps.close();
			System.out.println("Category deleted successfully");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean isCategoryExists(String name) {
		String query = "SELECT COUNT(*) FROM categories WHERE name = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}