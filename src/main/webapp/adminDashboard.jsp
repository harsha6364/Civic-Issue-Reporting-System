<%@page import="com.civic.dao.UserDAO"%>
<%@page import="com.civic.dao.impl.UserDAOImpl"%>
<%@page import="com.civic.dto.ReportImage"%>
<%@page import="com.civic.dao.impl.IssueReportDAOImpl"%>
<%@page import="com.civic.dao.impl.ReportImageDAOImpl"%>
<%@page import="com.civic.dao.ReportImageDAO"%>
<%@page import="com.civic.dto.IssueReport"%>
<%@page import="java.util.List"%>
<%@page import="com.civic.dao.IssueReportDAO"%>
<%@page import="com.civic.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin</title>
    <link rel="stylesheet" href="adminDashboard.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
      integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
  </head>
  <body>
  
	<%User u = (User)session.getAttribute("user"); %>  
    <div class="container">
      <nav>
        <div class="logo"><h2>CivicSpark</h2></div>
        <div class="links">
          <span
            ><a href=""><i class="fa-regular fa-house"></i> Home</a></span
          >
          <span
            ><a href="reportIssue.jsp"
              ><i class="bi bi-plus-circle"></i> Report Issue</a
            ></span
          >
          <span
            ><a href=""><i class="bi bi-list-ul"></i> My Issues</a></span
          >
          <span
            ><a href=""
              ><i class="bi bi-geo-alt-fill"></i> Nearby Issues</a
            ></span
          >
          <span
            ><a href=""
              ><i class="bi bi-patch-check"></i> Resolved Issues</a
            ></span
          >
        </div>
        <div class="profile">
          <a href=""><i class="bi bi-bell" id="notiBell"></i></a>
          <a href=""><i class="bi bi-box-arrow-right" id="logout">Logout</i></a>
        </div>
      </nav>

      <div class="main">
        <!-- Hero section to print greeting -->
        <% 
        java.time.LocalTime time = java.time.LocalTime.now();
        int hour = time.getHour();
        
        String greet = "";
        
        if(hour >= 00 && hour < 12){
        		greet = "Good Moring";
        }else if(hour >= 12 && hour <18){
        		greet = "Good Afternoon";
        }else {
        		greet = "Good Evening";
        }
        %>
        <div class="hero-section">
          <h2><%=greet %>, <%=u.getName() %></h2>
          <p>Here is the what's happening in the system today</p>
        </div>
	<%
	IssueReportDAO reportDAO = new IssueReportDAOImpl();
	ReportImageDAO imageDAO = new ReportImageDAOImpl();
	UserDAO userdao= new UserDAOImpl();
	
	List<IssueReport> allIssues = reportDAO.getAllIssueReports();
	List<User> users = userdao.getAllUser();
	
	int totalIssues = allIssues.size();
	int underReview = 0;
	int inProgress = 0;
	int resolved = 0;
	int rejected = 0;
	int totalUsers = users.size();
	
	
	for(IssueReport Issue : allIssues){
		String status = Issue.getStatus();
		
		if("pending".equals(status)){
			underReview++;
		}else if("in_progess".equals(status)){
			inProgress++;
		}else if("resolved".equals(status)){
			resolved++;
		}else if("rejected".equals(status)){
			rejected++;
		}
	}
	%> 

        <!-- Counting boxes -->

        <div class="boxes">
          <div class="box" id="box1">
            <div class="upside">
              <div class="icon"><i class="bi bi-card-list"></i></div>
              <div class="content">
                <p>Total Issues Reported</p>
                <h1><%=totalIssues %></h1>
                <p id="all-time">All time</p>
              </div>
            </div>
            <div class="donside">
              <svg class="wave" viewBox="0 0 300 60" preserveAspectRatio="none">
                <defs>
                  <linearGradient id="gradientRed" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stop-color="#fc0329" stop-opacity="0.7" />
                    <stop offset="100%" stop-color="#fc0329" stop-opacity="0" />
                  </linearGradient>
                </defs>

                <!-- Gradient Area -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20
               L300,60
               L0,60 Z"
                  fill="url(#gradientRed)"
                />

                <!-- Line -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20"
                  fill="none"
                  stroke="#fc0329"
                  stroke-width="4"
                  stroke-linecap="round"
                />
              </svg>
            </div>
          </div>

          <div class="box" id="box2">
            <div class="upside">
              <div class="icon"><i class="bi bi-clock"></i></div>
              <div class="content">
                <p>Under Review</p>
                <h1><%=underReview %></h1>
                <p id="all-time">Currently</p>
              </div>
            </div>
            <div class="downside">
              <svg class="wave" viewBox="0 0 300 60" preserveAspectRatio="none">
                <defs>
                  <linearGradient
                    id="gradientYellow"
                    x1="0"
                    y1="0"
                    x2="0"
                    y2="1"
                  >
                    <stop offset="0%" stop-color="#fabb33" stop-opacity="0.7" />
                    <stop offset="100%" stop-color="#fabb33" stop-opacity="0" />
                  </linearGradient>
                </defs>

                <!-- Gradient Area -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20
               L300,60
               L0,60 Z"
                  fill="url(#gradientYellow)"
                />

                <!-- Line -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20"
                  fill="none"
                  stroke="#fabb33"
                  stroke-width="4"
                  stroke-linecap="round"
                />
              </svg>
            </div>
          </div>

          <div class="box" id="box3">
            <div class="upside">
              <div class="icon"><i class="bi bi-gear-fill"></i></div>
              <div class="content">
                <p>In Progress</p>
                <h1><%=inProgress %></h1>
                <p id="all-time">Currently</p>
              </div>
            </div>
            <div class="downside">
              <svg class="wave" viewBox="0 0 300 60" preserveAspectRatio="none">
                <defs>
                  <linearGradient id="gradientBlue" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stop-color="#1c50d5" stop-opacity="0.7" />
                    <stop offset="100%" stop-color="#1c50d5" stop-opacity="0" />
                  </linearGradient>
                </defs>

                <!-- Gradient Area -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20
               L300,60
               L0,60 Z"
                  fill="url(#gradientBlue)"
                />

                <!-- Line -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20"
                  fill="none"
                  stroke="#1c50d5"
                  stroke-width="4"
                  stroke-linecap="round"
                />
              </svg>
            </div>
          </div>

          <div class="box" id="box4">
            <div class="upside">
              <div class="icon"><i class="bi bi-check2-circle"></i></div>
              <div class="content">
                <p>Resolved</p>
                <h1><%=resolved %></h1>
                <p id="all-time">All time</p>
              </div>
            </div>
            <div class="downside">
              <svg class="wave" viewBox="0 0 300 60" preserveAspectRatio="none">
                <defs>
                  <linearGradient
                    id="gradientGreen"
                    x1="0"
                    y1="0"
                    x2="0"
                    y2="1"
                  >
                    <stop offset="0%" stop-color="#57b713" stop-opacity="0.7" />
                    <stop offset="100%" stop-color="#57b713" stop-opacity="0" />
                  </linearGradient>
                </defs>

                <!-- Gradient Area -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20
               L300,60
               L0,60 Z"
                  fill="url(#gradientGreen)"
                />

                <!-- Line -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20"
                  fill="none"
                  stroke="#57b713"
                  stroke-width="4"
                  stroke-linecap="round"
                />
              </svg>
            </div>
          </div>

          <div class="box" id="box5">
            <div class="upside">
              <div class="icon">
                <i class="bi bi-x-lg"></i>
              </div>
              <div class="content">
                <p>Rejected</p>
                <h1><%=rejected %></h1>
                <p id="all-time">All time</p>
              </div>
            </div>
            <div class="downside">
              <svg class="wave" viewBox="0 0 300 60" preserveAspectRatio="none">
                <defs>
                  <linearGradient id="gradientRed" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stop-color="#fc0329" stop-opacity="0.7" />
                    <stop offset="100%" stop-color="#fc0329" stop-opacity="0" />
                  </linearGradient>
                </defs>

                <!-- Gradient Area -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20
               L300,60
               L0,60 Z"
                  fill="url(#gradientRed)"
                />

                <!-- Line -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20"
                  fill="none"
                  stroke="#fc0329"
                  stroke-width="4"
                  stroke-linecap="round"
                />
              </svg>
            </div>
          </div>

          <div class="box" id="box6">
            <div class="upside">
              <div class="icon">
                <i class="bi bi-people"></i>
              </div>
              <div class="content">
                <p>Total Users</p>
                <h1><%=totalUsers %></h1>
                <p id="all-time">All time</p>
              </div>
            </div>
            <div class="downside">
              <svg class="wave" viewBox="0 0 300 60" preserveAspectRatio="none">
                <defs>
                  <linearGradient
                    id="gradientPurple"
                    x1="0"
                    y1="0"
                    x2="0"
                    y2="1"
                  >
                    <stop offset="0%" stop-color="#a01cd5" stop-opacity="0.7" />
                    <stop offset="100%" stop-color="#a01cd5" stop-opacity="0" />
                  </linearGradient>
                </defs>

                <!-- Gradient Area -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20
               L300,60
               L0,60 Z"
                  fill="url(#gradientPurple)"
                />

                <!-- Line -->
                <path
                  d="M0,45
               C30,20 60,55 90,35
               C120,15 150,55 180,30
               C210,10 240,50 270,25
               C285,15 295,5 300,20"
                  fill="none"
                  stroke="#a01cd5"
                  stroke-width="4"
                  stroke-linecap="round"
                />
              </svg>
            </div>
          </div>
        </div>
		<%
		int totalPending=0;
		for(IssueReport issue: allIssues){
			if("pending".equals(issue.getStatus())){
				totalPending++;
			}
		}
		
		%>
		
		
		
        <div class="table-container">
          <div class="table-header">
            <h2>
              
              1.Recent Issues (Not Approved / Not Assigned)
              <p id="not-approvedCount"><%=totalPending %></p>
            </h2>

            <a href="#">View All Issues →</a>
          </div>

          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Issue</th>
                <th>Category</th>
                <th>Priority</th>
                <th>Date</th>
                <th>Action</th>
                <th>View</th>
              </tr>
            </thead>

            <tbody>
                              <%
                    int serialNo = 1;
                    if (allIssues != null && !allIssues.isEmpty()) {
                        for (IssueReport issue : allIssues) {
                            // Get first image for this issue
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
                            
                            
                            String statusDisplay = issue.getStatus();
                            String statusClass = issue.getStatus();
                            String priorityClass = issue.getPriority();
                            String priorityDisplay = issue.getPriority();
                            if("pending".equals(statusDisplay)){
                            
                            		%>
                            		<tr>
                  <td><%= serialNo++ %></td>
                  <td class="issue-cell">
                    <img src="<%= imagePath %>" alt="Issue Image" onerror="this.src='https://picsum.photos/60'" />
                    <div>
                      <h4><%= issue.getTitle() %></h4>
                      <p><%= issue.getLocation() %></p>
                    </div>
                  </td>
                  <td><%= issue.getCategory() != null ? issue.getCategory() : "Unknown" %></td>
                  
                  <td>
                    <span class="priority <%= priorityClass %>"><%= issue.getPriority() != null ? issue.getPriority() : "medium" %></span>
                  </td>
                 <td><%= issue.getCreatedAt() != null ? issue.getCreatedAt().toString().substring(0, 10) : "N/A" %></td>
                  <td>
                  <form action="updateIssueStatus" method="POST">
                  	<input type="hidden" name="id" value="<%=issue.getId()%>" >
                  	<button type="submit" class="reject-btn" name="status" value="rejected">Reject</button>
                  	<button type="submit" class="approve-btn" name="status" value="in_progress">Approve</button>
                  </form>
                  
                </td>
                <td>
                    <button class="view-btn" onclick="location.href='userDashboard.jsp?id=<%= issue.getId() %>'">View</button>
                  </td>
                </tr>
                 <% }
               } 
           }else {%>
           <tr>
           <td colspan="7" style="text-align: center; padding: 40px;">
             No issues reported yet. 
             <a href="reportIssue.jsp" style="color: #16a34a; text-decoration: none;">Report your first issue</a>
           </td>
         </tr>
         
           <%} %>

              
            </tbody>
          </table>
        </div>

        <!-- table for all the issue which are not resolved -->
        <div class="table-container2" id="table-container2">
          <div class="table-header">
            <h2>
              2.Approved Issues - Change Status
              <p id="not-approvedCount"><%=allIssues.size() %></p>
            </h2>

            <a href="#">View All Issues →</a>
          </div>

          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Issue</th>
                <th>Category</th>
                <th>Status</th>
                <th>Priority</th>
                <th>Date</th>
                <th>Action</th>
              </tr>
            </thead>

            <tbody>
            <%
                    int serialNo2 = 1;
                    if (allIssues != null && !allIssues.isEmpty()) {
                        for (IssueReport issue : allIssues) {
                            // Get first image for this issue
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
                            
                            String statusClass = "";
                            String statusDisplay = issue.getStatus();
                            if ("pending".equals(issue.getStatus()) || "assigned".equals(issue.getStatus())) {
                                statusClass = "progress";
                                statusDisplay = "Under Review";
                            } else if ("in_progress".equals(issue.getStatus())) {
                                statusClass = "in_progress";
                                statusDisplay = "In Progress";
                            } else if ("resolved".equals(issue.getStatus()) || "closed".equals(issue.getStatus())) {
                                statusClass = "resolved";
                                statusDisplay = "Resolved";
                            } else if ("rejected".equals(issue.getStatus())) {
                                statusClass = "rejected";
                                statusDisplay = "Rejected";
                            }
                            
                            String priorityClass = "";
                            if ("high".equals(issue.getPriority()) || "urgent".equals(issue.getPriority())) {
                                priorityClass = "high";
                            } else if("medium".equals(issue.getPriority())){
                            		priorityClass = "medium";
                            }else if("low".equals(issue.getPriority())){
                            		priorityClass = "low";
                            }
                %>
                <tr>
                  <td><%= serialNo2++ %></td>
                  <td class="issue-cell">
                    <img src="<%= imagePath %>" alt="Issue Image" onerror="this.src='https://picsum.photos/60'" />
                    <div>
                      <h4><%= issue.getTitle() %></h4>
                      <p><%= issue.getLocation() %></p>
                    </div>
                  </td>
                  <td><%= issue.getCategory() != null ? issue.getCategory() : "Unknown" %></td>
                  <td>
                    <span class="status <%= statusClass %>"><%= statusDisplay %></span>
                  </td>
                  <td>
                    <span class="priority <%= priorityClass %>"><%= issue.getPriority() != null ? issue.getPriority() : "medium" %></span>
                  </td>
                  <td><%= issue.getCreatedAt() != null ? issue.getCreatedAt().toString().substring(0, 10) : "N/A" %></td>
                  <td>
                  <form action="viewIssue" method="POST">
                  	<input type="hidden" name="id" value="<%=issue.getId()%>">
                  	<button type="submit" class="view-btn" >View</button>
                  </form>
                    
                  </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                  <td colspan="7" style="text-align: center; padding: 40px;">
                    No issues reported yet. 
                    <a href="reportIssue.jsp" style="color: #16a34a; text-decoration: none;">Report your first issue</a>
                  </td>
                </tr>
                <% } %>
            </tbody>
          </table>
        </div>
      </div>
      <%@ include file="footer.jsp" %>
    </div>
  </body>
</html>
