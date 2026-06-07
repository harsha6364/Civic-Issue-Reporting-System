<%@page import="com.civic.dto.User"%>
<%@page import="com.civic.dto.ReportImage"%>
<%@page import="com.civic.dao.ReportImageDAO"%>
<%@page import="com.civic.dao.impl.ReportImageDAOImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.civic.dto.IssueReport"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="viewIssue.css">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<%
	User u = (User)session.getAttribute("user");
	IssueReport issue=(IssueReport) request.getAttribute("issue"); 
	
	if(issue!=null){ 
	ReportImageDAO imageDAO = new ReportImageDAOImpl();
	List<ReportImage> images = imageDAO.getImagesByReportId(issue.getId());
    String imagePath = request.getContextPath() + "/";
    if (images != null && !images.isEmpty()) {
    		String imgPath = images.get(0).getImagePath();
		// Convert backslash to forward slash for URL
		imgPath = imgPath.replace("\\", "/");
		imagePath += imgPath;
    } else {
        imagePath += "uploads/reports/default.jpg";
    }
	
	%>

<div class="container">

    <!-- Header -->
    <div class="page-header">
    <%if(u.getRole().equalsIgnoreCase("citizen")){ %>
        <a href="userDashboard.jsp" class="back-btn">
        <i class="fa-solid fa-arrow-left"></i> Back
        </a>
<%}else{ %>    
        <a href="adminDashboard.jsp" class="back-btn">
            <i class="fa-solid fa-arrow-left"></i> Back
        </a>
        <%} %>

        <!--<div class="status-box">
            <span class="status"><%=issue.getStatus() %></span>
        </div>-->
    </div>

    <!-- Title -->
    <div class="title-card">
        <h1><%=issue.getTitle() %></h1>
        <span class="issue-id"><%=issue.getId() %></span>
    </div>

    <!-- Main Content -->
    <div class="issue-container">

        <!-- Left Side -->
        <div class="left-section">

            <!-- Images -->
            <div class="card">
                <h3><i class="fa-solid fa-image"></i> Issue Images</h3>

                <img id="main-img" src="<%=imagePath %>" class="main-image">

                <div class="thumbs">
                <div>
                
                  <%
                  
                  for(ReportImage image: images){
                	  	String imagePath1 = request.getContextPath() + "/";
        				String imgPath1="";
        				imgPath1 = image.getImagePath();
            			// Convert backslash to forward slash for URL
            			imgPath1 = imgPath1.replace("\\", "/");
            			imagePath1 += imgPath1;
            			
            		%>
            			
            			<img class="thumb-img" src="<%=imagePath1 %>">
            			
       			<%}%>
       		</div>
       			<%if("pending".equals(issue.getStatus())) {%>
       			<form action="updateIssueStatus" method="POST">
                  	<input type="hidden" name="id" value="<%=issue.getId()%>" >
                  	<button type="submit" class="reject-btn" name="status" value="rejected">Reject</button>
                  	<button type="submit" class="approve-btn" name="status" value="in_progress">Approve</button>
                 </form>
                 <%} %>
                </div>
                
            </div>

            <!-- Description -->
            <div class="card">
                <h3><i class="fa-solid fa-file-lines"></i> Description</h3>

                <p>
                    <%=issue.getDescription() %>
                </p>
            </div>

            <!-- Message User -->
            <div class="card">
                <h3>
                    <i class="fa-solid fa-paper-plane"></i>
                    Send Message To Reporter
                </h3>

                <form action="sendMessage" method="post">

                    

                    <label>Subject</label>
                    <input type="text"
                           name="subject"
                           placeholder="Enter subject">

                    <label>Message</label>
                    <textarea rows="6"
                              name="message"
                              placeholder="Type your message here"></textarea>

                    <div class="msg-buttons">
                        <button type="button" class="template-btn">
                            Request More Info
                        </button>

                        <button type="button" class="template-btn">
                            Issue Assigned
                        </button>

                        <button type="button" class="template-btn">
                            Issue Resolved
                        </button>
                        <input type="hidden" name="issueId" value="<%=issue.getId()%>">
                        <input type="hidden" name="userId" value="<%=u.getId()%>">
                        <input type="hidden" name="recieverId" value="<%=issue.getReportedById()%>">
                        <input type="hidden" name="recieverName" value="<%=issue.getReportedByName()%>">
                        <input type="hidden" name="senderId" value="<%=u.getId()%>">
                        <input type="hidden" name="senderName" value="<%=u.getName()%>">
                        <input type="hidden" name="senderRole" value="<%=u.getRole()%>">
                    </div>

                    <button type="submit" class="send-btn">
                        <i class="fa-solid fa-paper-plane"></i>
                        Send Message
                    </button>
                    <%String messageSent = (String)request.getAttribute("messageSent");
                    String messageNotSent = (String)request.getAttribute("messageNotSent");

                    if(messageSent != null){
                    %>
                    <div id="toast" class="toast">
                        <div class="icon">✔</div>
                        <div>
                            <h3>Success</h3>
                            <p><%=messageSent%></p>
                        </div>
                    </div>
                    <%
                    }else if(messageNotSent != null){
                    %>
                    <div id="toast" class="toast">
                        <div class="icon">✖</div>
                        <div>
                            <h3>Error</h3>
                            <p><%=messageNotSent%></p>
                        </div>
                    </div>
                    <%
                    }
                    %>

                </form>
            </div>

        </div>

        <!-- Right Side -->
        <div class="right-section">

            <div class="card">
                <h3>Issue Details</h3>

                <div class="detail-row">
                    <span>Category</span>
                    <strong><%=issue.getCategory() %></strong>
                </div>

                <div class="detail-row">
                    <span>Priority</span>
                    <span class="<%=issue.getPriority() %>"><%=issue.getPriority() %></span>
                </div>

                <div class="detail-row">
                    <span>Status</span>
                    <span class="<%=issue.getStatus()%>"><%=issue.getStatus() %></span>
                </div>

                <div class="detail-row">
                    <span>Reported By</span>
                    <strong><%=issue.getReportedByName() %></strong>
                </div>
				<%String reportedAt =  issue.getCreatedAt().toString().substring(0, 10)+" / "+issue.getCreatedAt().toString().substring(10, 19);%>
                <div class="detail-row">
                    <span>Date Reported</span>
                    <strong><%=reportedAt%></strong>
                </div>

                <div class="detail-row">
                    <span>Issue ID</span>
                    <strong><%=issue.getId() %></strong>
                </div>
            </div>

            <div class="card" id="location-card">
                <h3>Location</h3>

                <p>
                    <%=issue.getLocation() %>
                </p>

                <button class="map-btn">
                    View on Map
                </button>
            </div>

            <div class="card">
                <h3>Additional Information</h3>

                <div class="detail-row">
                    <span>Assigned To</span>
                    <strong>---------</strong>
                </div>

                <div class="detail-row">
                    <span>Expected Resolution</span>
                    <strong>07-Jun-2026</strong>
                </div>
            </div>

        </div>

    </div>

</div>

	<%}else{ %>
		<h1>Issue is null</h1>
	<%} %>
	<script>
    const mainImg = document.querySelector("#main-img");

    const thumbImg = document.querySelectorAll(".thumb-img");
	
    thumbImg.forEach(img => {
    	
    		if(img.src === mainImg.src){
            img.classList.add("active");
        } else {
            img.classList.remove("active");
        }
        img.addEventListener("click", function () {
        	 // Change main image
            mainImg.src = this.src;

            // Make all thumbnails faded
            thumbImg.forEach(i => {
                i.classList.remove("active");
            });

            // Highlight clicked thumbnail
            this.classList.add("active");
        });
    });
    
    
    setTimeout(() => {
        document.getElementById("toast").classList.add("show");
      }, 100);

      setTimeout(() => {
        document.getElementById("toast").classList.remove("show");
      }, 3000);
    
</script>
</body>
</html>