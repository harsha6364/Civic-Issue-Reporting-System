package com.civic.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import com.civic.dao.IssueReportDAO;
import com.civic.dao.impl.IssueReportDAOImpl;
import com.civic.dto.IssueReport;
import com.civic.dto.ReportImage;
import com.civic.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/reportIssue")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 25 * 1024 * 1024
)
public class IssueReportServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads/reports";
    
    private int getCategoryIdByName(String categoryName) {
        switch (categoryName) {
            case "Road Construction": return 1;
            case "Drainage & Sewage": return 2;
            case "Street Light": return 3;
            case "Garbage & Sanitation": return 4;
            case "Water Supply": return 5;
            case "Electricity": return 6;
            case "Healthcare Facility": return 7;
            case "Other Public Service": return 8;
            default: return 0;
        }
    }
    
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                return new File(fileName).getName();
            }
        }
        return "unknown.jpg";
    }
    
    private String generateUniqueFileName(String originalFileName) {
        String extension = "";
        int dotIndex = originalFileName.lastIndexOf(".");
        if (dotIndex > 0) {
            extension = originalFileName.substring(dotIndex);
        }
        return System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + extension;
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = req.getSession();
            User loggedInUser = (User) session.getAttribute("user");
            
            String title = req.getParameter("title");
            String categoryValue = req.getParameter("category");
            String description = req.getParameter("description");
            String location = req.getParameter("location");
            
            // Validation
            if (title == null || title.trim().isEmpty()) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Please enter an issue title\"}");
                return;
            }
            if (categoryValue == null || categoryValue.trim().isEmpty()) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Please select a category\"}");
                return;
            }
            if (description == null || description.trim().isEmpty()) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Please describe the issue\"}");
                return;
            }
            if (location == null || location.trim().isEmpty()) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Please provide location\"}");
                return;
            }
            
            // Get uploaded files
            Collection<Part> parts = req.getParts();
            List<Part> fileParts = new ArrayList<>();
            for (Part part : parts) {
                if ("photos".equals(part.getName()) && part.getSize() > 0) {
                    fileParts.add(part);
                }
            }
            
            if (fileParts.isEmpty()) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Please upload at least one image\"}");
                return;
            }
            if (fileParts.size() > 5) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Maximum 5 images allowed\"}");
                return;
            }
            
            int categoryId = getCategoryIdByName(categoryValue);
            if (categoryId == 0) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Invalid category selected\"}");
                return;
            }
            
            // Create upload directory
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Create report
            IssueReport report = new IssueReport();
            report.setTitle(title);
            report.setCategory_id(categoryId);
            report.setDescription(description);
            report.setLocation(location);
            report.setPriority("medium");
            
            if (loggedInUser != null) {
                report.setReportedById(loggedInUser.getId());
                report.setReportedByName(loggedInUser.getName());
                report.setReportedByEmail(loggedInUser.getEmail());
            } else {
                report.setReportedByName("Anonymous User");
                report.setReportedByEmail("anonymous@civicspark.com");
            }
            
            IssueReportDAO reportDAO = new IssueReportDAOImpl();
            int reportId = reportDAO.createIssue(report);
            
            if (reportId == 0) {
                resp.getWriter().print("{\"success\": false, \"error\": \"Failed to save report to database\"}");
                return;
            }
            
            // Save images
            int order = 0;
            for (Part filePart : fileParts) {
                String fileName = extractFileName(filePart);
                String uniqueFileName = generateUniqueFileName(fileName);
                String relativePath = UPLOAD_DIR + File.separator + uniqueFileName;
                String absolutePath = uploadPath + File.separator + uniqueFileName;
                
                filePart.write(absolutePath);
                
                ReportImage image = new ReportImage();
                image.setReportId(reportId);
                image.setImagePath(relativePath);
                image.setImageName(fileName);
                image.setImageSizeKb((int) (filePart.getSize() / 1024));
                image.setMimeType(filePart.getContentType());
                image.setImageOrder(order++);
                
                reportDAO.addImageToReport(reportId, image);
            }
            
            resp.getWriter().print("{\"success\": true, \"reportId\": " + reportId + ", \"message\": \"Issue reported successfully\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().print("{\"success\": false, \"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}