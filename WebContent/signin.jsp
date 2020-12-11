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
  	#signin_content {
  		width: 100%;
  		height: calc(100% - 100px);
  		display: flex;
  		align-items: center;
  		justify-content: center;
  	}
  	
  	#signin_section {
  		width: 430px;
  		height: 500px;
  		display: flex;
  		align-items: center;
  		justify-content: center;
  		box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
  	}
  	
    #signin_form {
      width: 80%;
      height: 50%;
      display: flex;
  	  align-items: center;
  	  justify-content: space-between;
  	  flex-direction: column;
    }
    
    #signin_go_signup a {
      padding-left: 10px;
    }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %>
  <div id="signin_content">
    <section id="signin_section">
      <form id="signin_form" method=post action="signin.jsp">
        <div id="input_wrapper">
          <label for="email">이메일</label> 
          <input type="email" name="email">
        </div>
        <div id="input_wrapper">
          <label for="password">비밀번호</label>
          <input type="password" name="password">
        </div>
        <div id="signin_go_signup">
        아직 가입하지 않으셨다면? <a href="signup.jsp">회원가입하기</a>
        </div>
        <button type="submit">로그인</button>
      </form>
    </section>
  </div>
  <%@ include file="footer.jsp" %>
</body>
</html>