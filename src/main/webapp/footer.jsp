<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      .footer {
        background: #0f172a;
        color: white;
        padding-top: 40px;
        margin-top: 30px;
        font-family: Arial, sans-serif;
      }

      .footer-container {
        width: 90%;
        margin: auto;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 30px;
      }

      .footer-section {
        flex: 1;
        min-width: 220px;
      }

      .footer-section h2,
      .footer-section h3 {
        margin-bottom: 15px;
        color: #22c55e;
      }

      .footer-section p {
        line-height: 1.7;
        color: #cbd5e1;
      }

      .footer-section ul {
        list-style: none;
        padding: 0;
      }

      .footer-section ul li {
        margin-bottom: 10px;
      }

      .footer-section ul li a {
        text-decoration: none;
        color: #cbd5e1;
        transition: 0.3s;
      }

      .footer-section ul li a:hover {
        color: #22c55e;
        padding-left: 5px;
      }

      .footer-bottom {
        text-align: center;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        margin-top: 30px;
        padding: 15px 0;
        font-size: 14px;
        color: #94a3b8;
      }
    </style>
  </head>
  <body>
    <footer class="footer">
      <div class="footer-container">
        <div class="footer-section">
          <h2>CivicSpark</h2>
          <p>
            A smart civic issue reporting platform that helps citizens report
            and track local problems efficiently.
          </p>
        </div>

        <div class="footer-section">
          <h3>Quick Links</h3>
          <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#">Report Issue</a></li>
            <li><a href="#">Track Complaints</a></li>
            <li><a href="#">Contact</a></li>
          </ul>
        </div>

        <div class="footer-section">
          <h3>Contact</h3>
          <p>Email: support@civicspark.com</p>
          <p>Phone: +91 9876543210</p>
          <p>Bangalore, India</p>
        </div>
      </div>

      <div class="footer-bottom">
        <p>© 2026 CivicSpark | All Rights Reserved</p>
      </div>
    </footer>
  </body>
</html>
