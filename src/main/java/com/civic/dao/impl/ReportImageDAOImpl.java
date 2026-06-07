package com.civic.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.civic.dao.ReportImageDAO;
import com.civic.dto.ReportImage;
import com.civic.utility.Connector;

public class ReportImageDAOImpl implements ReportImageDAO {
	private Connection con;
	
	public ReportImageDAOImpl() {
		this.con = Connector.requestConnection();
	}

	@Override
	public void addImage(ReportImage image) {
		String query = "INSERT INTO report_images (report_id, image_path, image_name, image_size_kb, mime_type, image_order) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, image.getReportId());
			ps.setString(2, image.getImagePath());
			ps.setString(3, image.getImageName());
			ps.setInt(4, image.getImageSizeKb());
			ps.setString(5, image.getMimeType());
			ps.setInt(6, image.getImageOrder());
			ps.executeUpdate();
			ps.close();
			System.out.println("Image added successfully");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to add image");
		}
	}

	@Override
	public void addImages(List<ReportImage> images) {
		String query = "INSERT INTO report_images (report_id, image_path, image_name, image_size_kb, mime_type, image_order) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			for (ReportImage image : images) {
				ps.setInt(1, image.getReportId());
				ps.setString(2, image.getImagePath());
				ps.setString(3, image.getImageName());
				ps.setInt(4, image.getImageSizeKb());
				ps.setString(5, image.getMimeType());
				ps.setInt(6, image.getImageOrder());
				ps.addBatch();
			}
			
			int[] results = ps.executeBatch();
			ps.close();
			System.out.println("Added " + results.length + " images");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Failed to add multiple images");
		}
	}

	@Override
	public ReportImage getImageById(int id) {
		ReportImage image = null;
		String query = "SELECT * FROM report_images WHERE id = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				image = new ReportImage();
				image.setId(rs.getInt("id"));
				image.setReportId(rs.getInt("report_id"));
				image.setImagePath(rs.getString("image_path"));
				image.setImageName(rs.getString("image_name"));
				image.setImageSizeKb(rs.getInt("image_size_kb"));
				image.setMimeType(rs.getString("mime_type"));
				image.setImageOrder(rs.getInt("image_order"));
				image.setUploadedAt(rs.getTimestamp("uploaded_at"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return image;
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