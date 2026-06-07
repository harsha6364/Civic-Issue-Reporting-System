package com.civic.dao;

import java.util.List;

import com.civic.dto.ReportImage;

public interface ReportImageDAO {
	void addImage(ReportImage image);
    void addImages(List<ReportImage> images);
    ReportImage getImageById(int id);
    List<ReportImage> getImagesByReportId(int reportId);
}
