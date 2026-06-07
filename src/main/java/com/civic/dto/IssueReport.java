package com.civic.dto;

import java.sql.Timestamp;

public class IssueReport {
	private Integer id;
	private String title;
	private Integer category_id;
	private String category;
	private String	description;
	private String location;
	private Double longitute;
	private Double latitute;
	private String status;
	private String priority;
	private Integer assignedTo;
	private Integer assignedBy;
	private Timestamp assignedDate;
	private Timestamp resolvedDate;
	private String resolutionNotes;
	private Integer reportedById;
	private String reportedByName;
	private String reportedByEmail;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String assignedToName;
	private String assignedByName;
	
	@Override
	public String toString() {
		return "IssueReport [id=" + id + ", title=" + title + ", category_id=" + category_id + ", category=" + category
				+ ", description=" + description + ", location=" + location + ", longitute=" + longitute + ", latitute="
				+ latitute + ", status=" + status + ", priority=" + priority + ", assignedTo=" + assignedTo
				+ ", assignedBy=" + assignedBy + ", assignedDate=" + assignedDate + ", resolvedDate=" + resolvedDate
				+ ", resolutionNotes=" + resolutionNotes + ", reportedById=" + reportedById + ", reportedByName="
				+ reportedByName + ", reportedByEmail=" + reportedByEmail + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + ", assignedToName=" + assignedToName + ", assignedByName=" + assignedByName + "]";
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getCategory_id() {
		return category_id;
	}
	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Double getLongitute() {
		return longitute;
	}
	public void setLongitute(Double longitute) {
		this.longitute = longitute;
	}
	public Double getLatitute() {
		return latitute;
	}
	public void setLatitute(Double latitute) {
		this.latitute = latitute;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public Integer getAssignedTo() {
		return assignedTo;
	}
	public void setAssignedTo(Integer assignedTo) {
		this.assignedTo = assignedTo;
	}
	public Integer getAssignedBy() {
		return assignedBy;
	}
	public void setAssignedBy(Integer assignedBy) {
		this.assignedBy = assignedBy;
	}
	public Timestamp getAssignedDate() {
		return assignedDate;
	}
	public void setAssignedDate(Timestamp assignedDate) {
		this.assignedDate = assignedDate;
	}
	public Timestamp getResolvedDate() {
		return resolvedDate;
	}
	public void setResolvedDate(Timestamp resolvedDate) {
		this.resolvedDate = resolvedDate;
	}
	public String getResolutionNotes() {
		return resolutionNotes;
	}
	public void setResolutionNotes(String resolutionNotes) {
		this.resolutionNotes = resolutionNotes;
	}
	public Integer getReportedById() {
		return reportedById;
	}
	public void setReportedById(Integer reportedById) {
		this.reportedById = reportedById;
	}
	public String getReportedByName() {
		return reportedByName;
	}
	public void setReportedByName(String reportedByName) {
		this.reportedByName = reportedByName;
	}
	public String getReportedByEmail() {
		return reportedByEmail;
	}
	public void setReportedByEmail(String reportedByEmail) {
		this.reportedByEmail = reportedByEmail;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getAssignedToName() {
		return assignedToName;
	}
	public void setAssignedToName(String assignedToName) {
		this.assignedToName = assignedToName;
	}
	public String getAssignedByName() {
		return assignedByName;
	}
	public void setAssignedByName(String assignedByName) {
		this.assignedByName = assignedByName;
	}
}
