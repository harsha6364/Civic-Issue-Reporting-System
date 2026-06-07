package com.civic.dto;

import java.sql.Timestamp;

public class ReportImage {
	private Integer id;
	private Integer reportId;
	private String imagePath;
	private String imageName;
	private Integer imageSizeKb;
	private String mimeType;
	private Integer imageOrder;
    private Timestamp uploadedAt;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getReportId() {
		return reportId;
	}
	public void setReportId(Integer reportId) {
		this.reportId = reportId;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public Integer getImageSizeKb() {
		return imageSizeKb;
	}
	public void setImageSizeKb(Integer imageSizeKb) {
		this.imageSizeKb = imageSizeKb;
	}
	@Override
	public String toString() {
		return "ReportImage [id=" + id + ", reportId=" + reportId + ", imagePath=" + imagePath + ", imageName="
				+ imageName + ", imageSizeKb=" + imageSizeKb + ", mimeType=" + mimeType + ", imageOrder=" + imageOrder
				+ ", uploadedAt=" + uploadedAt + "]";
	}
	public String getMimeType() {
		return mimeType;
	}
	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}
	public Integer getImageOrder() {
		return imageOrder;
	}
	public void setImageOrder(Integer imageOrder) {
		this.imageOrder = imageOrder;
	}
	public Timestamp getUploadedAt() {
		return uploadedAt;
	}
	public void setUploadedAt(Timestamp uploadedAt) {
		this.uploadedAt = uploadedAt;
	}
}
