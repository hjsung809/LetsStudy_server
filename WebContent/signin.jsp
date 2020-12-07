<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean scope="application" id="passport" class="study.Passport" />

<%

  if(request.getMethod().equals("POST")) {
      study.User user = passport.signIn(request.getParameter("email"), request.getParameter("password"));

      if (user != null) {
        session.setAttribute("user", user);
        response.sendRedirect("study_main.jsp");
      } else {
        out.println("<script>alert('로그인에 실패하였습니다.')</script>");
      }
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" type="text/css" href="init.css">
  
  <style>
    #content > #main_section {
      width: 960px;
      float: none;
      margin: 0 auto;
      height: 100%;
      background-color: antiquewhite;
    }

    #signin_form {
      width: 360px;
      margin: 0 auto;
      border: 1px solid black;
      padding: 10px;
    }

    #signin_form input{
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      border: 1px solid #ccc;
      display: inline-block;
      box-sizing: border-box;
    }

    #signin_form button {
      background-color: #4CAF50;
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      cursor: pointer;
      width: 100%;
    }

    button:hover {
      opacity: 0.8;
    }
  </style>
</head>
<body>
  <div id="content">

    <section id="main_section">
      <form id="signin_form" method=post action="signin.jsp">
        <div>

        </div>
        <div>
          <label for="email">E-Mail</label> 
          <input type="email" name="email">
          <label for="password">Password</label>
          <input type="password" name="password">
          <button type="submit">로그인</button>
        </div>
        아직 가입하지 않으셨다면? <a href="signup.jsp">회원 가입하기</a>
      </form>
    </section>

  </div>
  <footer id="main_footer">
    <h3>Let's study</h3>
  </footer>
</body>
</html>