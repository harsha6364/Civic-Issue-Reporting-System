<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Log in</title>
  <link rel="stylesheet" href="signin.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  
</head>
<body>
  <div class="container">
    <form action="signin" method="POST">
      <div >
        <h1 id="heading">CivicSpark</h1>
      </div>
      <% String Success = (String)request.getAttribute("Success");
      if(Success!=null){%>
      	<p style="green"><%=Success %></p>
      <%}%>
      
      <% String error = (String)request.getAttribute("error");
      if(error!=null){%>
      	<p style="red"><%=error %></p>
      <%}%>
      
      
      <div>
        <!-- <label for="email">Email</label><br> -->
        <input type="text" placeholder="Enter your email" name="email" id="email">
      </div>
      <div>
        <!-- <label for="password">Password</label><br> -->
        <input type="text" placeholder="Enter your password" name="password" id="password">
      </div>
      <div>
        <p>By signing up or logging in, you consent to DeepSeek's <a href="#">Terms of Use</a>  and <a href="#">Privacy Policy</a></p>
      </div>
      <div>
        <a href="#" id="forgot">Forgot password</a>
        <a href="#">Sign Up</a>
      </div>
      <div>
        <button type="submit">Log in</button>
      </div>
    </form>
  </div>
</body>
</html>