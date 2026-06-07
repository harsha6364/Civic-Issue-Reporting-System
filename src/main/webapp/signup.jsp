<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
  <link rel="stylesheet" href="signup.css">
</head>
<body>
  <div class="container">
    <form action="signup" method="POST">
      <div class="heading">
        <h1>CivicSpark</h1>
      </div>
      <div>
        <!-- <label for="email">Email</label><br> -->
        <input type="text" placeholder="Enter your name" name="name" id="name">
      </div>
      <div>
        <!-- <label for="email">Email</label><br> -->
        <input type="text" placeholder="Enter your email" name="email" id="email">
      </div>
      <div>
        <!-- <label for="email">Email</label><br> -->
        <input type="tel" placeholder="Enter your mobile number" name="phone" id="phone">
      </div>
      <div>
        <!-- <label for="password">Password</label><br> -->
        <input type="text" placeholder="Enter your password" name="password" id="password">
      </div>
      <div>
        <!-- <label for="password">Password</label><br> -->
        <input type="text" placeholder="Enter your village name" name="village" id="village">
      </div>
      <div>
        <p>By signing up or logging in, you consent to DeepSeek's <a href="#">Terms of Use</a>  and <a href="#">Privacy Policy</a></p>
      </div>
      <div>
        <a href="forgotPassword.jsp" id="forgotPassword">Forgot password</a>
        <a href="signin.jsp">Login </a>
      </div>
      <div>
        <button type="submit">Sign Up</button>
      </div>
    </form>
  </div>
</body>
</html>