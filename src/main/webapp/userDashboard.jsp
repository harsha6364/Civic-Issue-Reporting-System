<%@page import="com.civic.dto.ReportImage"%>
<%@page import="com.civic.dto.IssueReport"%>
<%@page import="java.util.List"%>
<%@page import="com.civic.dao.impl.ReportImageDAOImpl"%>
<%@page import="com.civic.dao.ReportImageDAO"%>
<%@page import="com.civic.dao.IssueReportDAO"%>
<%@page import="com.civic.dao.impl.IssueReportDAOImpl"%>
<%@page import="com.civic.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CivicSpark - user</title>
    <link rel="stylesheet" href="userDashboard.css" />
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
  <%User u = (User)session.getAttribute("user"); 
  if(u == null){
	    response.sendRedirect("signin.jsp");
	    return;
	}
  	
  	IssueReportDAO reportDAO =new IssueReportDAOImpl();
  	ReportImageDAO imageDAO = new ReportImageDAOImpl();
  	
  	List<IssueReport> userIssues = reportDAO.getIssuesByUser(u.getId());
  	
  	int totalIssues = userIssues.size();
  	int pendingCount = 0;
  	int inProgressCount = 0;
  	int resolvedCount = 0;
  	int rejectedCount = 0;
  	
  	for(IssueReport issue: userIssues){
  		String status = issue.getStatus();
  		
  		if("pending".equalsIgnoreCase(status) || "assigned".equals(status)){
  			pendingCount++;
  		}else if("in_progress".equalsIgnoreCase(status)){
  			inProgressCount++;
  		}else if ("resolved".equals(status) || "closed".equals(status)) {
            resolvedCount++;
        }else if("rejected".equals(status)){
        		rejectedCount++;
        }
  	}
  
  %>
    <div class="container">
      <nav>
        <div class="logo"><h2>CivicSpark</h2></div>
        <div class="links">
        		<div><a href="userDashboard.jsp"><i class="fa-regular fa-house"></i> Home</a></div>
         	<div><a href="reportIssue.jsp"><i class="bi bi-plus-circle"></i> Report Issue</a></div>
         	<div><a href=""><i class="bi bi-list-ul"></i> My Issues</a></div>
         	<div><a href=""><i class="bi bi-geo-alt-fill"></i> Nearby Issues</a></div>
         	<div><a href=""><i class="bi bi-patch-check"></i> Resolved Issues</a></div>
        </div>
        <div class="profile">
          <a href=""><i class="bi bi-bell" id="notiBell"></i></a>
          <a href="logout"><i class="bi bi-box-arrow-right" id="logout">Logout</i></a>
        </div>
      </nav>
      <div class="main">
        <div class="leftSection">
          <div class="heroSection">
            <div class="heading">
            <%
    java.time.LocalTime time = java.time.LocalTime.now();
    int hour = time.getHour();

    String greeting = "";

    if(hour >= 00 && hour < 12){
        greeting = "Good Morning";
    }
    else if(hour >= 12 && hour < 17){
        greeting = "Good Afternoon";
    }
    else {
        greeting = "Good Evening";
    }
   
%>

              <h2><%=greeting %>, <%= u.getName() %> !</h2>
              <p>Here's what's happening in your community today.</p>
            </div>
            <!-- <div class="img"><img src="bg.png" alt=""></div> -->
          </div>
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
                <svg
                  class="wave"
                  viewBox="0 0 300 60"
                  preserveAspectRatio="none"
                >
                  <defs>
                    <linearGradient
                      id="gradientRed"
                      x1="0"
                      y1="0"
                      x2="0"
                      y2="1"
                    >
                      <stop
                        offset="0%"
                        stop-color="#fc0329"
                        stop-opacity="0.7"
                      />
                      <stop
                        offset="100%"
                        stop-color="#fc0329"
                        stop-opacity="0"
                      />
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
                  <h1><%=pendingCount %></h1>
                  <p id="all-time">Not approved</p>
                </div>
              </div>
              <div class="downside">
                <svg
                  class="wave"
                  viewBox="0 0 300 60"
                  preserveAspectRatio="none"
                >
                  <defs>
                    <linearGradient
                      id="gradientYellow"
                      x1="0"
                      y1="0"
                      x2="0"
                      y2="1"
                    >
                      <stop
                        offset="0%"
                        stop-color="#fabb33"
                        stop-opacity="0.7"
                      />
                      <stop
                        offset="100%"
                        stop-color="#fabb33"
                        stop-opacity="0"
                      />
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
                  <h1><%=inProgressCount %></h1>
                  <p id="all-time">Assigned to Dept</p>
                </div>
              </div>
              <div class="downside">
                <svg
                  class="wave"
                  viewBox="0 0 300 60"
                  preserveAspectRatio="none"
                >
                  <defs>
                    <linearGradient
                      id="gradientBlue"
                      x1="0"
                      y1="0"
                      x2="0"
                      y2="1"
                    >
                      <stop
                        offset="0%"
                        stop-color="#1c50d5"
                        stop-opacity="0.7"
                      />
                      <stop
                        offset="100%"
                        stop-color="#1c50d5"
                        stop-opacity="0"
                      />
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
                  <h1><%=resolvedCount %></h1>
                  <p id="all-time">All time</p>
                </div>
              </div>
              <div class="downside">
                <svg
                  class="wave"
                  viewBox="0 0 300 60"
                  preserveAspectRatio="none"
                >
                  <defs>
                    <linearGradient
                      id="gradientGreen"
                      x1="0"
                      y1="0"
                      x2="0"
                      y2="1"
                    >
                      <stop
                        offset="0%"
                        stop-color="#57b713"
                        stop-opacity="0.7"
                      />
                      <stop
                        offset="100%"
                        stop-color="#57b713"
                        stop-opacity="0"
                      />
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
                  <i class="bi bi-hand-thumbs-up-fill"></i>
                </div>
                <div class="content">
                  <p>Rejected</p>
                  <h1><%=rejectedCount %></h1>
                  <p id="all-time">All time</p>
                </div>
              </div>
              <div class="downside">
                <svg
                  class="wave"
                  viewBox="0 0 300 60"
                  preserveAspectRatio="none"
                >
                  <defs>
                    <linearGradient
                      id="gradientPurple"
                      x1="0"
                      y1="0"
                      x2="0"
                      y2="1"
                    >
                      <stop
                        offset="0%"
                        stop-color="#a01cd5"
                        stop-opacity="0.7"
                      />
                      <stop
                        offset="100%"
                        stop-color="#a01cd5"
                        stop-opacity="0"
                      />
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

          <div class="table-container">
            <div class="table-header">
              <h2>
                <i class="fa-solid fa-clipboard-list"></i>
                My Recent Issues
              </h2>

              <a href="#">View All My Issues →</a>
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
                    int serialNo = 1;
                    if (userIssues != null && !userIssues.isEmpty()) {
                        for (IssueReport issue : userIssues) {
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

        <div class="rightSection">
          <div class="notification-card">
            <div class="card-header">
              <h2>Recent Notifications</h2>
              <a href="#">View All →</a>
            </div>

            <!-- Notification 1 -->
            <div class="notification-item">
              <div class="left-section">
                <div class="icon green-bg">
                  <i class="fa-solid fa-check"></i>
                </div>

                <div class="text-content">
                  <h3>Your issue #123 has been resolved successfully.</h3>
                  <p>2 days ago</p>
                </div>
              </div>

              <span class="dot green"></span>
            </div>

            <!-- Notification 2 -->
            <div class="notification-item">
              <div class="left-section">
                <div class="icon orange-bg">
                  <i class="fa-regular fa-clock"></i>
                </div>

                <div class="text-content">
                  <h3>Issue #124 is under review by admin.</h3>
                  <p>3 days ago</p>
                </div>
              </div>

              <span class="dot orange"></span>
            </div>

            <!-- Notification 3 -->
            <div class="notification-item">
              <div class="left-section">
                <div class="icon blue-bg">
                  <i class="fa-regular fa-message"></i>
                </div>

                <div class="text-content">
                  <h3>New comment on your issue #120.</h3>
                  <p>5 days ago</p>
                </div>
              </div>

              <span class="dot blue"></span>
            </div>

            <!-- Notification 4 -->
            <div class="notification-item">
              <div class="left-section">
                <div class="icon purple-bg">
                  <i class="fa-regular fa-user"></i>
                </div>

                <div class="text-content">
                  <h3>Your issue #118 has been assigned to admin.</h3>
                  <p>1 week ago</p>
                </div>
              </div>

              <span class="dot purple"></span>
            </div>
          </div>
          <div class="nearByIssues">
            <h3>See Issues Near You</h3>
            <p>Explore issues reported in your area and support by upvoting.</p>
            <a href="#">View Nearby Issues</a>
          </div>
          <div class="help-card">
            <h3>Need help?</h3>
            <p>Report an issue or contact support for an assistance.</p>
            <a href="#"><i class="bi bi-headset"></i> Contact Support</a>
          </div>
        </div>
      </div>
      <%@ include file="footer.jsp" %>
    </div>
  </body>
</html>
