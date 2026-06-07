package com.civic.dao;

import java.util.List;

import com.civic.dto.IssueReport;
import com.civic.dto.ReportImage;

public interface IssueReportDAO {
	int createIssue(IssueReport report);
	void addImageToReport(int reportId, ReportImage image);
	void addMultipleImages(int repoortId, List<ReportImage> images);
	int updateIssueStatus(int reportId,String status);
	
	IssueReport getIssueReportById(int id);
	List<IssueReport> getAllIssueReports();
	List<IssueReport> getIssuesByUser(int userId);
	List<IssueReport> getIssuesByStatus(String status);
	List<IssueReport> getIssuesByCategory(String category);
	List<ReportImage> getImagesByReportId(int reportId);
	
}
