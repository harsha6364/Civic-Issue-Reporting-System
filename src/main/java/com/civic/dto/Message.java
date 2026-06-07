package com.civic.dto;

import java.sql.Timestamp;

public class Message {
	private int id;
	private String tittle;
	private String description;
	private int reportId;
	private int sentById;
	private String sentByName;
	private String sentByRole;
	private int recieverId;
	private String recieverName;
	@Override
	public String toString() {
		return "Message [id=" + id + ", tittle=" + tittle + ", description=" + description + ", reportId=" + reportId
				+ ", sentById=" + sentById + ", sentByName=" + sentByName + ", sentByRole=" + sentByRole
				+ ", recieverId=" + recieverId + ", recieverName=" + recieverName + ", sentAt=" + sentAt + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTittle() {
		return tittle;
	}
	public void setTittle(String tittle) {
		this.tittle = tittle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getReportId() {
		return reportId;
	}
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	public int getSentById() {
		return sentById;
	}
	public void setSentById(int sentById) {
		this.sentById = sentById;
	}
	public String getSentByName() {
		return sentByName;
	}
	public void setSentByName(String sentByName) {
		this.sentByName = sentByName;
	}
	public String getSentByRole() {
		return sentByRole;
	}
	public void setSentByRole(String sentByRole) {
		this.sentByRole = sentByRole;
	}
	public int getRecieverId() {
		return recieverId;
	}
	public void setRecieverId(int recieverId) {
		this.recieverId = recieverId;
	}
	public String getRecieverName() {
		return recieverName;
	}
	public void setRecieverName(String recieverName) {
		this.recieverName = recieverName;
	}
	public Timestamp getSentAt() {
		return sentAt;
	}
	public void setSentAt(Timestamp sentAt) {
		this.sentAt = sentAt;
	}
	private Timestamp sentAt;
}
