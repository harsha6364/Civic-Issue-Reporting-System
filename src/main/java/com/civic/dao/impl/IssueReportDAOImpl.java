package com.civic.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.civic.dao.IssueReportDAO;
import com.civic.dto.IssueReport;
import com.civic.dto.ReportImage;
import com.civic.utility.Connector;

public class IssueReportDAOImpl implements IssueReportDAO {
	private Connection con;
	
	public IssueReportDAOImpl() {
		this.con = Connector.requestConnection();
	}
	
	// Helper method to get category name from ID
	private String getCategoryNameById(int categoryId) {
		switch (categoryId) {
			case 1: return "Road Construction";
			case 2: return "Drainage & Sewage";
			case 3: return "Street Light";
			case 4: return "Garbage & Sanitation";
			case 5: return "Water Supply";
			case 6: return "Electricity";
			case 7: return "Healthcare Facility";
			case 8: return "Other Public Service";
			default: return "Other";
		}
	}
	
	@Override
	public int createIssue(IssueReport report) {
		// IMPORTANT: Insert into BOTH category (VARCHAR NOT NULL) AND category_id (INT)
		String query = "INSERT INTO issue_reports (title, category, category_id, description, location, priority, reported_by, reported_by_name, reported_by_email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int generatedId = 0;
		
		try {
			PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			
			ps.setString(1, report.getTitle());
			
			// Get category name from ID (for the 'category' VARCHAR column)
			String categoryName = getCategoryNameById(report.getCategory_id());
			ps.setString(2, categoryName);
			ps.setInt(3, report.getCategory_id());
			
			ps.setString(4, report.getDescription());
			ps.setString(5, report.getLocation());
			ps.setString(6, report.getPriority() != null ? report.getPriority() : "medium");
			ps.setInt(7, report.getReportedById() != null ? report.getReportedById() : 0);
			ps.setString(8, report.getReportedByName());
			ps.setString(9, report.getReportedByEmail());
			
			System.out.println("Inserting: " + report.getTitle() + " | Category: " + categoryName + " | Category ID: " + report.getCategory_id());
			
			int affectedRows = ps.executeUpdate();
			
			if (affectedRows > 0) {
				ResultSet generatedKeys = ps.getGeneratedKeys();
				if (generatedKeys.next()) {
					generatedId = generatedKeys.getInt(1);
					System.out.println("✅ Issue reported successfully with ID: " + generatedId);
				}
				generatedKeys.close();
			}
			ps.close();
		} catch (SQLException e) {
			System.err.println("❌ SQL Error: " + e.getMessage());
			e.printStackTrace();
		}
		return generatedId;
	}

	@Override
	public void addImageToReport(int reportId, ReportImage image) {
		String query = "INSERT INTO report_images (report_id, image_path, image_name, image_size_kb, mime_type, image_order) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, reportId);
			ps.setString(2, image.getImagePath());
			ps.setString(3, image.getImageName());
			ps.setInt(4, image.getImageSizeKb());
			ps.setString(5, image.getMimeType());
			ps.setInt(6, image.getImageOrder());
			
			ps.executeUpdate();
			ps.close();
			System.out.println("✅ Image added successfully to report: " + reportId);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to add image");
		}
	}

	@Override
	public void addMultipleImages(int reportId, List<ReportImage> images) {
		String query = "INSERT INTO report_images (report_id, image_path, image_name, image_size_kb, mime_type, image_order) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			for (ReportImage image : images) {
				ps.setInt(1, reportId);
				ps.setString(2, image.getImagePath());
				ps.setString(3, image.getImageName());
				ps.setInt(4, image.getImageSizeKb());
				ps.setString(5, image.getMimeType());
				ps.setInt(6, image.getImageOrder());
				ps.addBatch();
			}
			
			int[] results = ps.executeBatch();
			ps.close();
			System.out.println("✅ Added " + results.length + " images to report: " + reportId);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to add multiple images");
		}
	}

	@Override
	public IssueReport getIssueReportById(int id) {
		IssueReport report = null;
		String query = "SELECT ir.*, c.name as category_name FROM issue_reports ir LEFT JOIN categories c ON ir.category_id = c.id WHERE ir.id = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				report = new IssueReport();
				report.setId(rs.getInt("id"));
				report.setTitle(rs.getString("title"));
				report.setCategory_id(rs.getInt("category_id"));
				report.setCategory(rs.getString("category_name"));
				report.setDescription(rs.getString("description"));
				report.setLocation(rs.getString("location"));
				report.setStatus(rs.getString("status"));
				report.setPriority(rs.getString("priority"));
				report.setAssignedTo(rs.getInt("assigned_to"));
				report.setAssignedBy(rs.getInt("assigned_by"));
				report.setAssignedDate(rs.getTimestamp("assigned_date"));
				report.setResolvedDate(rs.getTimestamp("resolved_date"));
				report.setResolutionNotes(rs.getString("resolution_notes"));
				report.setReportedById(rs.getInt("reported_by"));
				report.setReportedByName(rs.getString("reported_by_name"));
				report.setReportedByEmail(rs.getString("reported_by_email"));
				report.setCreatedAt(rs.getTimestamp("created_at"));
				report.setUpdatedAt(rs.getTimestamp("updated_at"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return report;
	}

	@Override
	public int updateIssueStatus(int reportId, String status) {
		String query = "UPDATE issue_reports SET STATUS=? WHERE ID=?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1,status );
			ps.setInt(2, reportId);
			return ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Failed to update status");
		}
		return 0;
	}

	@Override
	public List<IssueReport> getAllIssueReports() {
		List<IssueReport> reports = new ArrayList<>();
		String query = "SELECT ir.*, c.name as category_name FROM issue_reports ir LEFT JOIN categories c ON ir.category_id = c.id ORDER BY ir.created_at DESC";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				IssueReport report = new IssueReport();
				report.setId(rs.getInt("id"));
				report.setTitle(rs.getString("title"));
				report.setCategory_id(rs.getInt("category_id"));
				report.setCategory(rs.getString("category_name"));
				report.setDescription(rs.getString("description"));
				report.setLocation(rs.getString("location"));
				report.setStatus(rs.getString("status"));
				report.setPriority(rs.getString("priority"));
				report.setCreatedAt(rs.getTimestamp("created_at"));
				reports.add(report);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reports;
	}

	@Override
	public List<IssueReport> getIssuesByUser(int userId) {
		List<IssueReport> reports = new ArrayList<>();
		String query = "SELECT ir.*, c.name as category_name FROM issue_reports ir LEFT JOIN categories c ON ir.category_id = c.id WHERE ir.reported_by = ? ORDER BY ir.created_at DESC";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				IssueReport report = new IssueReport();
				report.setId(rs.getInt("id"));
				report.setTitle(rs.getString("title"));
				report.setCategory_id(rs.getInt("category_id"));
				report.setCategory(rs.getString("category_name"));
				report.setDescription(rs.getString("description"));
				report.setLocation(rs.getString("location"));
				report.setStatus(rs.getString("status"));
				report.setPriority(rs.getString("priority"));
				report.setCreatedAt(rs.getTimestamp("created_at"));
				reports.add(report);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reports;
	}

	@Override
	public List<IssueReport> getIssuesByStatus(String status) {
		List<IssueReport> reports = new ArrayList<>();
		String query = "SELECT ir.*, c.name as category_name FROM issue_reports ir LEFT JOIN categories c ON ir.category_id = c.id WHERE ir.status = ? ORDER BY ir.created_at DESC";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, status);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				IssueReport report = new IssueReport();
				report.setId(rs.getInt("id"));
				report.setTitle(rs.getString("title"));
				report.setCategory_id(rs.getInt("category_id"));
				report.setCategory(rs.getString("category_name"));
				report.setDescription(rs.getString("description"));
				report.setLocation(rs.getString("location"));
				report.setStatus(rs.getString("status"));
				report.setPriority(rs.getString("priority"));
				report.setCreatedAt(rs.getTimestamp("created_at"));
				reports.add(report);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reports;
	}

	@Override
	public List<IssueReport> getIssuesByCategory(String category) {
		List<IssueReport> reports = new ArrayList<>();
		String query = "SELECT ir.*, c.name as category_name FROM issue_reports ir LEFT JOIN categories c ON ir.category_id = c.id WHERE c.name = ? ORDER BY ir.created_at DESC";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, category);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				IssueReport report = new IssueReport();
				report.setId(rs.getInt("id"));
				report.setTitle(rs.getString("title"));
				report.setCategory_id(rs.getInt("category_id"));
				report.setCategory(rs.getString("category_name"));
				report.setDescription(rs.getString("description"));
				report.setLocation(rs.getString("location"));
				report.setStatus(rs.getString("status"));
				report.setPriority(rs.getString("priority"));
				report.setCreatedAt(rs.getTimestamp("created_at"));
				reports.add(report);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reports;
	}

	@Override
	public List<ReportImage> getImagesByReportId(int reportId) {
		List<ReportImage> images = new ArrayList<>();
		String query = "SELECT * FROM report_images WHERE report_id = ? ORDER BY image_order";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, reportId);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				ReportImage image = new ReportImage();
				image.setId(rs.getInt("id"));
				image.setReportId(rs.getInt("report_id"));
				image.setImagePath(rs.getString("image_path"));
				image.setImageName(rs.getString("image_name"));
				image.setImageSizeKb(rs.getInt("image_size_kb"));
				image.setMimeType(rs.getString("mime_type"));
				image.setImageOrder(rs.getInt("image_order"));
				image.setUploadedAt(rs.getTimestamp("uploaded_at"));
				images.add(image);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return images;
	}
}